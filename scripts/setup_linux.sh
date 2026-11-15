#!/usr/bin/env bash
# ==============================================================================
# Environment Verification & Setup Script
# Checks host USB multiplexing, Python tooling, and iOS device pairing state.
# ==============================================================================

set -euo pipefail

echo "==> Checking host dependencies..."

MISSING_DEPS=()
for cmd in usbmuxd python3 curl qrencode; do
    if ! command -v "${cmd}" >/dev/null 2>&1; then
        MISSING_DEPS+=("${cmd}")
    fi
done

if [[ ${#MISSING_DEPS[@]} -gt 0 ]]; then
    echo "[!] Missing required host binaries: ${MISSING_DEPS[*]}"
    echo "Install them using:"
    echo "  sudo apt update && sudo apt install -y ${MISSING_DEPS[*]}"
    exit 1
fi
echo "[+] Base host binaries verified."

# Verify usbmuxd daemon
if systemctl is-active --quiet usbmuxd; then
    echo "[+] usbmuxd systemd daemon is active."
else
    echo "[!] usbmuxd is not active. Attempting to start..."
    sudo systemctl start usbmuxd || echo "[Warning] Unable to start usbmuxd automatically."
fi

# Verify pymobiledevice3
if command -v pymobiledevice3 >/dev/null 2>&1 || [[ -x "${HOME}/.local/bin/pymobiledevice3" ]]; then
    echo "[+] pymobiledevice3 is available."
else
    echo "[!] pymobiledevice3 not detected. Installing via pip3..."
    pip3 install --user --break-system-packages pymobiledevice3
fi

# Verify connected devices
echo "==> Inspecting connected iOS devices..."
if command -v pymobiledevice3 >/dev/null 2>&1; then
    pymobiledevice3 usbmux list
elif [[ -x "${HOME}/.local/bin/pymobiledevice3" ]]; then
    "${HOME}/.local/bin/pymobiledevice3" usbmux list
fi

echo "==> Setup verification complete."
