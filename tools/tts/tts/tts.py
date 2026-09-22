"""Audio backend for the game's TTS gateway.

Set TTS_PROVIDER=silero to use the original local model. The default edge
provider uses the local edge-tts client and supports English and Chinese
voices through the same HTTP contract consumed by the game.
"""
import asyncio
import io
import json
import os

from flask import Flask, request, send_file

app = Flask(__name__)
TTS_PROVIDER = os.getenv("TTS_PROVIDER", "edge").lower()
SAMPLE_RATE = int(os.getenv("TTS_SAMPLE_RATE", "48000"))
model = None
edge_voice_data = []

LEGACY_VOICE_ALIASES = {
    "Male 01": "en-US-GuyNeural", "Male 02": "en-US-RyanMultilingualNeural",
    "Female 01": "en-US-AriaNeural", "Female 02": "zh-CN-XiaoxiaoNeural",
    "Female 03": "zh-CN-XiaoyiNeural", "Мужской 1": "en-US-GuyNeural",
    "Мужской 2": "en-US-RyanMultilingualNeural", "Женский 1": "en-US-AriaNeural",
    "Женский 2": "zh-CN-XiaoxiaoNeural", "Женский 3": "zh-CN-XiaoyiNeural",
}
STATIC_EDGE_VOICES = [
    "en-US-AriaNeural", "en-US-GuyNeural", "en-US-JennyNeural",
    "en-US-RyanMultilingualNeural", "en-GB-SoniaNeural", "en-AU-NatashaNeural",
    "zh-CN-XiaoxiaoNeural", "zh-CN-XiaoyiNeural", "zh-CN-YunxiNeural",
    "zh-CN-YunjianNeural", "zh-TW-HsiaoChenNeural", "zh-HK-HiuGaaiNeural",
]


def _load_silero():
    global model
    import torch
    language = os.getenv("TTS_SILERO_LANGUAGE", "ru")
    speaker_model = os.getenv("TTS_SILERO_MODEL", "v5_5_ru")
    models_dir = os.environ.get("TTS_HOME", os.path.join(os.path.dirname(__file__), "tts_data"))
    os.makedirs(models_dir, exist_ok=True)
    torch.hub.set_dir(models_dir)
    print(f"Loading Silero TTS ({language}/{speaker_model})...", flush=True)
    model, _ = torch.hub.load(repo_or_dir="snakers4/silero-models", model="silero_tts",
                               language=language, speaker=speaker_model, trust_repo=True)
    model.to(torch.device("cuda" if torch.cuda.is_available() else "cpu"))


def _load_edge_voices():
    global edge_voice_data
    try:
        import edge_tts
        edge_voice_data = [v for v in asyncio.run(edge_tts.list_voices())
                           if v.get("ShortName", "").startswith(("en-", "zh-"))]
        if not edge_voice_data:
            raise RuntimeError("Edge returned no English or Chinese voices")
    except Exception as exc:
        print(f"Could not query Edge voice catalog, using fallback list: {exc}", flush=True)
        edge_voice_data = [{"ShortName": v} for v in STATIC_EDGE_VOICES]


if TTS_PROVIDER == "silero":
    _load_silero()
    SILERO_VOICES = ["aidar", "baya", "kseniya", "xenia", "eugene", "random"]
else:
    _load_edge_voices()


def available_voices():
    if TTS_PROVIDER == "silero":
        return SILERO_VOICES
    return sorted(set([v["ShortName"] for v in edge_voice_data] + list(LEGACY_VOICE_ALIASES)))


def _voice_for_request(voice, text):
    if TTS_PROVIDER == "silero":
        return voice if voice in SILERO_VOICES else "random"
    voice = LEGACY_VOICE_ALIASES.get(voice, voice)
    valid = {v["ShortName"] for v in edge_voice_data}
    if voice not in valid:
        voice = "zh-CN-XiaoxiaoNeural" if any("\u3400" <= c <= "\u9fff" for c in text) else "en-US-AriaNeural"
    return voice


def _pitch_value(pitch):
    try:
        return {"-2": "-10Hz", "-1": "-5Hz", "0": "+0Hz", "1": "+5Hz", "2": "+10Hz"}.get(str(int(pitch)), "+0Hz")
    except (TypeError, ValueError):
        return "+0Hz"


async def _edge_audio(text, voice, pitch):
    import edge_tts
    from pydub import AudioSegment
    output = io.BytesIO()
    communicate = edge_tts.Communicate(text, voice, pitch=_pitch_value(pitch))
    async for chunk in communicate.stream():
        if chunk["type"] == "audio":
            output.write(chunk["data"])
    output.seek(0)
    wav = io.BytesIO()
    AudioSegment.from_file(output, format="mp3").set_frame_rate(SAMPLE_RATE).export(wav, format="wav")
    wav.seek(0)
    return wav


def _silero_audio(text, voice, pitch):
    import soundfile as sf
    import torch
    with torch.no_grad():
        audio = model.apply_tts(text=text, speaker=voice, sample_rate=SAMPLE_RATE)
    output = io.BytesIO()
    sf.write(output, audio.squeeze().cpu().numpy(), SAMPLE_RATE, format="WAV")
    output.seek(0)
    return output


def generate_audio(text, voice, pitch):
    voice = _voice_for_request(voice, text)
    return _silero_audio(text, voice, pitch) if TTS_PROVIDER == "silero" else asyncio.run(_edge_audio(text, voice, pitch))


def request_data():
    payload = request.get_json(silent=True) or {}
    return (str(payload.get("text", request.args.get("text", ""))),
            str(payload.get("voice", request.args.get("voice", ""))),
            str(payload.get("pitch", request.args.get("pitch", "0"))))


@app.route("/tts", methods=["GET", "POST"])
@app.route("/generate-tts", methods=["GET", "POST"])
def text_to_speech():
    text, voice, pitch = request_data()
    if not text.strip():
        return "No text provided", 400
    try:
        return send_file(generate_audio(text, voice, pitch), mimetype="audio/wav")
    except Exception as exc:
        print(f"TTS error: {exc}", flush=True)
        return str(exc), 500


@app.route("/tts-blips", methods=["GET", "POST"])
@app.route("/generate-tts-blips", methods=["GET", "POST"])
def text_to_speech_blips():
    # Edge voices do not expose phoneme samples; normal speech preserves the preference and protocol.
    return text_to_speech()


@app.route("/tts-voices")
def voices_list():
    return json.dumps(available_voices(), ensure_ascii=False)


@app.route("/health-check")
def health_check():
    return f"OK ({TTS_PROVIDER})", 200


@app.route("/pitch-available")
def pitch_available():
    return "OK", 200


if __name__ == "__main__":
    from waitress import serve
    print(f"TTS server started on port 5003 (provider={TTS_PROVIDER})", flush=True)
    serve(app, host="0.0.0.0", port=5003, threads=2, backlog=8, connection_limit=24, channel_timeout=120)
