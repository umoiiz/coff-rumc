# Aperture TTS（中英文兼容）

该目录提供游戏现有 TTS HTTP 协议的本地部署方案：

1. `tts` 在本机生成 WAV。默认 `TTS_PROVIDER=edge`，可用大量英文和中文音色；也可以切换回原始 `silero` 本地模型。
2. `tts-api` 负责鉴权、混合中英文分句、音频转换和游戏所需的 `/tts`、`/tts-blips`、`/tts-voices` 端点。

游戏服务器只需要访问 `tts-api:5002`，不会直接接触模型。

## 启动

安装 [Docker](https://docs.docker.com/get-docker/)，在此目录执行：

```bash
docker compose up -d --build
curl http://localhost:5002/health-check
```

停止：

```bash
docker compose down
```

Windows PowerShell 也可以这样设置令牌：

```powershell
$env:TTS_AUTHORIZATION_TOKEN="your-token"
docker compose up -d --build
```

## 游戏服务器配置

```text
TTS_HTTP_URL http://你的电脑地址:5002
TTS_HTTP_TOKEN your-token
```

如果游戏服务器和 Docker 在同一台电脑上，使用 `http://127.0.0.1:5002`；局域网服务器请使用电脑的局域网 IP，并允许防火墙访问 5002 端口。

## 后端选择

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| `TTS_PROVIDER` | `edge` | `edge` 支持中英文音色；`silero` 使用原始本地模型 |
| `TTS_AUTHORIZATION_TOKEN` | `coolio` | API 鉴权令牌 |
| `TTS_SAMPLE_RATE` | `48000` | WAV 输出采样率 |

例如使用原始 Silero：

```powershell
$env:TTS_PROVIDER="silero"
docker compose up -d --build
```

Silero 模式保留原有俄语音色；中文和英文建议使用默认 Edge 模式。

## API 转接

网关继续使用原有协议。外部供应商或自建服务只需提供 `/generate-tts`、`/generate-tts-blips`、`/tts-voices` 和 `/pitch-available`，并将 `TTS_BACKEND_URL` 指向它。游戏端无需改动。

请求示例：

```bash
curl -H "Authorization: your-token" \
  "http://localhost:5002/tts?voice=zh-CN-XiaoxiaoNeural" \
  -H "Content-Type: application/json" \
  -d '{"text":"你好，Captain! Hello!"}' --output out.ogg
```

`tts_speech_filter` 会保留拉丁字母、西里尔字母、中文字符和中英文标点，因此问号、感叹号、句号等仍可影响语气；其他不可用控制字符会替换为空格。
