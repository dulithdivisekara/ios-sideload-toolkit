# Troubleshooting & Diagnostics Matrix

This document provides resolutions for frequent issues encountered when configuring the Linux-to-iOS sideloading environment, SideStore, and LiveContainer.

## 1. Apple Developer Limits

### Error: `ApplicationVerificationFailed` (App Limit Reached)

```text
ApplicationVerificationFailed: This device has reached the maximum number of installed apps using a free developer profile:
- com.SideStore.SideStore
- com.kdt.livecontainer
- com.adobe.lrmobilephone
```

- **Root Cause:** Free Apple Developer accounts are restricted to 3 active App ID registrations per device. Attempting to install a 4th standalone bundle will be rejected by the device kernel.
- **Resolution:**
  1. Do not install additional standalone apps via SideStore or desktop utilities.
  2. Install remaining applications (such as `uYouEnhanced` and `EeveeSpotify`) as guest apps inside **LiveContainer**.
  3. LiveContainer hosts guest apps via `dlopen`, bypassing the App ID registration limit entirely.

## 2. LiveContainer & Certificate Issues

### Error: `Certificate not found. Did you log into built-in SideStore?`

- **Root Cause:** LiveContainer bundles an integrated SideStore instance that lacks credentials until an Apple ID login occurs inside it.
- **Resolution:**
  1. Do not rely on the built-in SideStore component if you already have standalone SideStore installed.
  2. Open standalone **SideStore > Settings**.
  3. Tap your **Apple ID** account row.
  4. **Long-press** the active certificate and select **Export Certificate**.
  5. Set password `password` and save to Files.
  6. In LiveContainer, go to **Settings > Import Certificate**, select the saved file, and type `password`.

### Error: Missing `ALTCertificate.p12` in the Files App

- **Root Cause:** SideStore maintains cryptographic identities inside the secure iOS Keychain. No `.p12` file exists on disk until explicitly exported.
- **Resolution:** Use the long-press export workflow detailed in [LIVECONTAINER_GUIDE.md](LIVECONTAINER_GUIDE.md).

### Symptom: SideJITServer Reports "Unreachable"

- **Root Cause:** SideJITServer is a network debugger designed for tethered JIT execution on emulators. It is not active on your local network.
- **Resolution:** Toggle **Enable SideJITServer** to **OFF** in SideStore Settings. LiveContainer's JIT-less mode does not depend on SideJITServer.

## 3. Host Workstation & Connection

### Symptom: Developer Mode Toggle Missing in iOS Settings

- **Root Cause:** iOS 16+ conceals the Developer Mode setting until an authenticated workstation transmits an AMFI handshake packet over USB.
- **Resolution:** Run the following command from the host workstation while the device is connected via USB:
  ```bash
  pymobiledevice3 amfi reveal-developer-mode
  ```
  Then navigate to **Settings > Privacy & Security > Developer Mode**, toggle it on, and restart the device.

### Symptom: `iloader` Segfaults on Ubuntu 24.04 / 26.04

- **Root Cause:** AppImage runtime bundling incompatibilities with newer system libraries (`glib`, `WebKitNetworkProcess`).
- **Resolution:** Use the standalone native binary installed at `~/.local/bin/iloader` or execute through the project wrapper `./bin/iloader`.

## 4. On-Device Wireless Refresh

### Error: `DeviceEndpointNotInitialized` in SideStore

- **Root Cause:** SideStore's local loopback tunnel failed to initialize or the pairing file is missing.
- **Resolution:**
  1. Verify that **LocalDevVPN** is installed from the App Store and toggled **ON**.
  2. In SideStore, navigate to **Settings > Pairing File**.
  3. Re-select `config/SideStore.pairingFile` from Files.
  4. Test refresh under **My Apps > Refresh All**.

### Symptom: 2FA Prompt Delays During In-App Login

- **Root Cause:** Apple ID push notifications occasionally fail to trigger while an in-app auth session is waiting.
- **Resolution:**
  1. Open Safari on the iPhone.
  2. Navigate to `appleid.apple.com` and log in to trigger a push authorization prompt.
  3. Copy the 6-digit code and provide it to the SideStore authentication prompt.
