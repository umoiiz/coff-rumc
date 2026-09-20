"""Read-only Windows IME snapshot for a specified test window; no input injection."""

import argparse
import ctypes as C
from ctypes import wintypes as W
import json


class GUITHREADINFO(C.Structure):
    _fields_ = [("cbSize", W.DWORD), ("flags", W.DWORD)] + [
        (name, W.HWND) for name in
        ("hwndActive", "hwndFocus", "hwndCapture", "hwndMenuOwner", "hwndMoveSize", "hwndCaret")
    ] + [("rcCaret", W.RECT)]


def snapshot(hwnd):
    user32 = C.WinDLL("user32", use_last_error=True)
    imm32 = C.WinDLL("imm32", use_last_error=True)
    user32.GetWindowThreadProcessId.argtypes = [W.HWND, C.POINTER(W.DWORD)]
    user32.GetWindowThreadProcessId.restype = W.DWORD
    user32.GetGUIThreadInfo.argtypes = [W.DWORD, C.POINTER(GUITHREADINFO)]
    user32.GetGUIThreadInfo.restype = W.BOOL
    user32.GetKeyboardLayout.argtypes = [W.DWORD]
    user32.GetKeyboardLayout.restype = W.HANDLE
    user32.GetClassNameW.argtypes = [W.HWND, W.LPWSTR, C.c_int]
    user32.GetClassNameW.restype = C.c_int
    user32.SendMessageTimeoutW.argtypes = [W.HWND, W.UINT, W.WPARAM, W.LPARAM, W.UINT, W.UINT, C.POINTER(C.c_size_t)]
    user32.SendMessageTimeoutW.restype = W.LPARAM
    imm32.ImmGetDefaultIMEWnd.argtypes = [W.HWND]
    imm32.ImmGetDefaultIMEWnd.restype = W.HWND
    pid = W.DWORD()
    thread = user32.GetWindowThreadProcessId(hwnd, C.byref(pid))
    if not thread:
        raise C.WinError(C.get_last_error())
    info = GUITHREADINFO(cbSize=C.sizeof(GUITHREADINFO))
    if not user32.GetGUIThreadInfo(thread, C.byref(info)):
        raise C.WinError(C.get_last_error())
    focus = info.hwndFocus or hwnd
    focus_thread = user32.GetWindowThreadProcessId(focus, None)
    layout = user32.GetKeyboardLayout(focus_thread)
    name = C.create_unicode_buffer(256)
    user32.GetClassNameW(focus, name, len(name))
    ime = imm32.ImmGetDefaultIMEWnd(focus)

    def query(command):
        if not ime:
            return None
        result = C.c_size_t()
        # WM_IME_CONTROL; only IMC_GET* queries, with a bounded timeout.
        ok = user32.SendMessageTimeoutW(ime, 0x283, command, 0, 2, 200, C.byref(result))
        return result.value if ok else None

    opened, conversion = query(5), query(1)
    language = (layout or 0) & 0xffff
    # PRIMARYLANGID handles Simplified/Traditional Chinese locales alike.
    # A missing/failed IMM result is unknown, never proof of English mode.
    if not layout:
        blocked = None
    elif language & 0x3ff != 0x04:
        blocked = False
    elif opened is None or conversion is None:
        blocked = None
    else:
        blocked = bool(opened and conversion & 0x1)  # IME_CMODE_NATIVE
    return dict(pid=pid.value, thread=thread, focus=focus, focus_class=name.value,
                layout=hex(layout or 0), language=hex((layout or 0) & 0xffff),
                ime_window=ime, ime_open=opened, conversion=conversion, blocked=blocked)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("hwnd", type=lambda value: int(value, 0))
    args = parser.parse_args()
    print(json.dumps(snapshot(args.hwnd)))
