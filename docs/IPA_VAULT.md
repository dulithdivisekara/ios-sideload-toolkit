# Local IPA Vault & Build Automation

This document outlines the organization, automation scripts, and sources powering the local IPA vault located at `ipas/`.

## Vault Directory Layout

```text
ipas/
├── EeveeSpotify.ipa           # SpotveeC v3.2.10 (Unlimited skips, ad-free)
├── Lightroom.ipa              # Adobe Lightroom AI (Premium unlocked)
├── LiveContainer+SideStore.ipa # LiveContainer multi-app host container
└── uYouEnhanced.ipa           # YouTube v21.20.4-3.0.5 (Ad-free, SponsorBlock)
```

> [!NOTE]
> All binary `.ipa` files in `ipas/` are explicitly excluded from Git version control via `.gitignore` to maintain repository size constraints and avoid exceeding GitHub's 100 MB per-file push boundary.

## Build Scripts

### 1. `scripts/build_uyou.sh`
Dispatches automated builds of uYouEnhanced using either GitHub Actions cloud runners or local `cyan` patching.

Usage:
```bash
./scripts/build_uyou.sh
```

### 2. `scripts/patch_ipa.sh`
Universal CLI tweak injector powered by `cyan` (`pyzule-rw`). Injects `.deb` or `.dylib` modifications directly into target IPAs.

Usage:
```bash
./scripts/patch_ipa.sh -i base.ipa -f tweak.deb -o output.ipa
```

### 3. `scripts/fetch_ipas.sh`
Automated CLI downloader that synchronizes the latest verified releases from upstream GitHub repositories into `ipas/`.

Usage:
```bash
./scripts/fetch_ipas.sh
```

## Community Source Catalogs

The toolkit includes a pre-configured community source profile at `profiles/sources.json`. You can import these feeds directly into SideStore's **Sources** tab:

- **SwaggyP124 Tweaked Apps:** `https://raw.githubusercontent.com/swaggyP36000/TrollStore-IPAs/main/apps.json`
- **SideStore Community Catalog:** `https://community-sources.sidestore.io/`
- **WuChang Tweaks Hub:** `https://raw.githubusercontent.com/wuchang-repo/wuchang-repo.github.io/main/apps.json`
