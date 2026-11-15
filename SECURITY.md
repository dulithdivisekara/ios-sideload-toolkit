# Security Policy

## Threat Model and Operating System Guarantees

This toolkit operates strictly within Apple's official Developer Testing and Provisioning Frameworks. It does not employ jailbreaking or kernel vulnerabilities.

### Signed System Volume (SSV)
Since iOS 15, the core operating system resides on an immutable, cryptographically sealed APFS snapshot. The kernel enforces hardware-backed cryptographic verification against the system manifest at boot. Sideloaded applications run entirely in userland partitions and cannot alter system binaries, baseband firmware, or boot stages.

### Application Sandboxing
Every application provisioned through this toolkit is placed in a sandboxed container:
`/private/var/mobile/Containers/Data/Application/<UUID>`

The iOS sandbox blocks unauthorized IPC, inter-application filesystem access, and hardware peripheral access unless explicitly granted by the user via system TCC (Transparency, Consent, and Control) dialogs.

### Clean Deletion
Deleting an application from the home screen automatically purges both the application bundle and its sandboxed data container. No residual cache or system hooks persist after uninstallation.

## Credential and Pairing Record Protection

1. **Local Authentication:** Signing utilities (`iloader`, `SideStore`) communicate directly with Apple's official authentication gateways (`gsa.apple.com`, `developer.apple.com`) over TLS. Credentials are never proxied through untrusted intermediaries.
2. **Repository Hygiene:** All device lockdown records (`*.pairingFile`, `*.plist`, `*.mobiledevicepairing`) and private signing keys are strictly excluded from version control via `.gitignore`.
3. **Burner Account Best Practice:** While standard Apple IDs protected by Two-Factor Authentication (2FA) are secure, using a dedicated secondary Apple ID for developer provisioning provides complete credential isolation from personal iCloud accounts.

## Tweak Injection and Account Safety Rules

1. **Financial Applications:** Never inject modifications into banking, payment, or cryptocurrency applications. Financial tools must always be sourced directly from the official Apple App Store.
2. **Platform Terms of Service Risks:** Modifying social messaging clients (such as WhatsApp or Snapchat) can trigger automated server-side fraud flags. Sideloading modified clients on primary telephone numbers carries a risk of account suspension by the service provider.
3. **Binary Verification:** When sourcing third-party `.ipa` files, verify checksums against official developer release tags where available.

## Reporting Security Issues

To report a vulnerability or credential leak within this repository, open an issue or contact the repository owner directly.
