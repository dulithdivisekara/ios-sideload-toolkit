#!/usr/bin/env bash
# ==============================================================================
# Universal IPA Tweak Injector
# Injects .deb, .dylib, or .framework tweaks into an unsigned/decrypted IPA.
# ==============================================================================

set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") -i <input.ipa> -f <tweak1 [tweak2 ...]> -o <output.ipa> [options]

Required Arguments:
  -i, --input     Path to decrypted base application .ipa
  -f, --files     Tweak file(s) to inject (.deb, .dylib, .framework)
  -o, --output    Output path for the modified .ipa

Optional Arguments:
  -n, --name      Custom application display name
  -b, --bundle-id Custom bundle identifier
  -h, --help      Display this help menu
EOF
    exit 1
}

CYAN_CMD="cyan"
if ! command -v "${CYAN_CMD}" >/dev/null 2>&1; then
    if [[ -x "${HOME}/.local/bin/cyan" ]]; then
        CYAN_CMD="${HOME}/.local/bin/cyan"
    else
        echo "[!] Cyan tweak injector is not installed."
        echo "Installing Cyan via pip3..."
        pip3 install --user --break-system-packages "git+https://github.com/asdfzxcvbn/pyzule-rw.git"
        CYAN_CMD="${HOME}/.local/bin/cyan"
    fi
fi

if [[ $# -eq 0 ]]; then
    usage
fi

exec "${CYAN_CMD}" "$@"
