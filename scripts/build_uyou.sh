#!/usr/bin/env bash
# ==============================================================================
# uYouEnhanced DIY Build Workflow Helper
# Facilitates compiling customized uYouEnhanced IPAs without distributing
# copyrighted YouTube base binaries.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
IPAS_DIR="${ROOT_DIR}/ipas"

echo "===================================================================="
echo "          uYouEnhanced DIY Build Workflow Generator"
echo "===================================================================="
echo ""
echo "Because pre-built YouTube IPAs cannot be distributed legally under"
echo "DMCA guidelines, uYouEnhanced must be compiled using one of two methods:"
echo ""
echo "  [1] GitHub Actions Cloud Builder (Recommended — 100% Automated)"
echo "  [2] Local CLI Patching via Cyan (Requires Decrypted Base IPA)"
echo ""

read -rp "Select your preferred build mode [1/2]: " BUILD_MODE

case "${BUILD_MODE}" in
    1)
        echo ""
        echo "--> Workflow: GitHub Actions Cloud Build"
        echo "1. Fork the official repository:"
        echo "   https://github.com/arichornlover/uYouEnhanced"
        echo "2. Obtain a direct URL to a clean, decrypted YouTube IPA"
        echo "   (e.g., from decrypt.day or your personal dump)."
        echo "3. In your forked repository on GitHub, open the 'Actions' tab."
        echo "4. Select the 'Build and Release uYouEnhanced' workflow."
        echo "5. Click 'Run workflow' and paste the direct YouTube IPA download URL."
        echo "6. When the build completes (approx. 5 minutes), download the artifact"
        echo "   into your local vault: ${IPAS_DIR}/"
        echo ""
        if command -v gh >/dev/null 2>&1; then
            echo "[Notice] You can also trigger this via GitHub CLI once forked:"
            echo "  gh workflow run \"Build and Release uYouEnhanced\" -f decrypted_youtube_url=\"<URL>\""
        fi
        ;;
    2)
        echo ""
        echo "--> Workflow: Local CLI Tweak Injection"
        echo "Ensuring Cyan tweak injector is present..."
        if ! command -v cyan >/dev/null 2>&1 && ! [[ -x "${HOME}/.local/bin/cyan" ]]; then
            echo "Installing Cyan via pipx/pip3..."
            pip3 install --user --break-system-packages "git+https://github.com/asdfzxcvbn/pyzule-rw.git" || true
        fi
        echo ""
        echo "Usage for manual injection:"
        echo "  cyan -i YouTube_Decrypted.ipa -f uYou.deb uYouEnhanced.dylib -o ${IPAS_DIR}/uYouEnhanced.ipa"
        ;;
    *)
        echo "Invalid selection. Exiting."
        exit 1
        ;;
esac
