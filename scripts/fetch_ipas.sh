#!/usr/bin/env bash
# ==============================================================================
# Verified IPA Vault Fetcher
# Downloads official open-source IPA releases directly into the local vault.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
IPAS_DIR="${ROOT_DIR}/ipas"

mkdir -p "${IPAS_DIR}"

echo "===================================================================="
echo "                Verified Open-Source IPA Fetcher"
echo "===================================================================="
echo "Available Open-Source Tools:"
echo "  [1] LiveContainer (Bypasses 3-app limit, runs guest IPAs)"
echo "  [2] Msb App (Telegram to WhatsApp sticker converter)"
echo "  [3] All Recommended Utilities"
echo ""

read -rp "Select utility to download [1/2/3]: " CHOICE

fetch_livecontainer() {
    echo "==> Fetching latest LiveContainer + SideStore bundle..."
    local url="https://github.com/LiveContainer/LiveContainer/releases/latest/download/LiveContainer+SideStore.ipa"
    curl -L -o "${IPAS_DIR}/LiveContainer+SideStore.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/LiveContainer+SideStore.ipa"
}

fetch_msb() {
    echo "==> Fetching Msb App (Sticker Manager)..."
    local url="https://github.com/star-39/msb_app/releases/download/v0.2.1/msb_app.ipa"
    curl -L -o "${IPAS_DIR}/msb_app.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/msb_app.ipa"
}

case "${CHOICE}" in
    1)
        fetch_livecontainer
        ;;
    2)
        fetch_msb
        ;;
    3)
        fetch_livecontainer
        fetch_msb
        ;;
    *)
        echo "Invalid selection."
        exit 1
        ;;
esac

echo ""
echo "Current files in local IPA vault (${IPAS_DIR}):"
ls -lh "${IPAS_DIR}"
