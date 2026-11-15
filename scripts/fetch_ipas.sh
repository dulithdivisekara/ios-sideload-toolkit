#!/usr/bin/env bash
# ==============================================================================
# Verified IPA Vault Fetcher
# Downloads official open-source and community IPAs directly into the local vault.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
IPAS_DIR="${ROOT_DIR}/ipas"

mkdir -p "${IPAS_DIR}"

echo "===================================================================="
echo "                Verified Power-User IPA Fetcher"
echo "===================================================================="
echo "Available Applications:"
echo "  [1] uYouEnhanced (Ad-free YouTube, SponsorBlock, 4K, Downloads)"
echo "  [2] LiveContainer (Bypasses 3-app limit, runs guest IPAs inside)"
echo "  [3] EeveeSpotify / SpotveeC (Spotify without audio ads, lyrics)"
echo "  [4] Delta (Nintendo GBA, GBC, SNES, NES, N64, NDS Emulator)"
echo "  [5] UTM SE (QEMU Virtual Machine: Run Linux/Windows on iOS without JIT)"
echo "  [6] Msb App (Telegram to WhatsApp sticker converter)"
echo "  [a] Download All Recommended IPAs"
echo ""

TARGET="${1:-}"

if [[ -z "${TARGET}" ]]; then
    read -rp "Select utility to download [1-6 or a]: " TARGET
fi

fetch_uyou() {
    echo "==> Fetching uYouEnhanced (Official AltStore build v21.20.4-3.0.5)..."
    local url="https://archive.org/download/YouTubeRebornPlus_19.10.5-4.2.6/yt-uYE-21204-305.ipa"
    curl -L -C - -o "${IPAS_DIR}/uYouEnhanced.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/uYouEnhanced.ipa"
}

fetch_livecontainer() {
    echo "==> Fetching latest LiveContainer + SideStore bundle..."
    local url="https://github.com/LiveContainer/LiveContainer/releases/latest/download/LiveContainer+SideStore.ipa"
    curl -L -C - -o "${IPAS_DIR}/LiveContainer+SideStore.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/LiveContainer+SideStore.ipa"
}

fetch_spotify() {
    echo "==> Fetching EeveeSpotify (SpotveeC compiled build)..."
    local url="https://archive.org/download/SpotveeCReleases/SpotveeC/v3.2.10/SpotveeC.v3.2.10_v9.0.10_ALTSTORESOURCE_ONLY.ipa"
    curl -L -C - -o "${IPAS_DIR}/EeveeSpotify.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/EeveeSpotify.ipa"
}

fetch_delta() {
    echo "==> Fetching Delta Emulator..."
    local url="https://github.com/swaggyP36000/TrollStore-IPAs/releases/download/Update/Delta-1.4b4.ipa"
    curl -L -C - -o "${IPAS_DIR}/Delta.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/Delta.ipa"
}

fetch_utm() {
    echo "==> Fetching UTM SE (JIT-less Virtualization)..."
    local url="https://github.com/utmapp/UTM/releases/download/v5.0.8/UTM-SE.ipa"
    curl -L -C - -o "${IPAS_DIR}/UTM-SE.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/UTM-SE.ipa"
}

fetch_msb() {
    echo "==> Fetching Msb App (Sticker Manager)..."
    local url="https://github.com/star-39/msb_app/releases/download/v0.2.1/msb_app.ipa"
    curl -L -C - -o "${IPAS_DIR}/msb_app.ipa" "${url}"
    echo "[+] Saved to ${IPAS_DIR}/msb_app.ipa"
}

case "${TARGET}" in
    1) fetch_uyou ;;
    2) fetch_livecontainer ;;
    3) fetch_spotify ;;
    4) fetch_delta ;;
    5) fetch_utm ;;
    6) fetch_msb ;;
    a|A|all|ALL)
        fetch_uyou
        fetch_livecontainer
        fetch_spotify
        fetch_delta
        fetch_utm
        fetch_msb
        ;;
    *)
        echo "Invalid selection: ${TARGET}"
        exit 1
        ;;
esac

echo ""
echo "Current files in local IPA vault (${IPAS_DIR}):"
ls -lh "${IPAS_DIR}"
