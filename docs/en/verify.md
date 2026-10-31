# Verify the SDK signature

The Creator Kit is separate from the app. Do not pass it to the application's Setup.
Its official content signature checks the publisher and file integrity. It is not Windows Authenticode.

Obtain the ZIP, its `.signature.json` file and `official-release.pub`. Use PowerShell 7.4 or later and a copy of `Verify-CreatorKit.ps1` independently checked through a trusted official source. Do not simply trust and run a script extracted from an unverified ZIP.

```powershell
pwsh -NoProfile -File ./Verify-CreatorKit.ps1 -Archive ./DesktopGadget-1.0.0-CreatorKit-win-x64.zip -Signature ./DesktopGadget-1.0.0-CreatorKit-win-x64.signature.json -PublicKey ./official-release.pub
```

Check for `status: PASS`, `officialSignatureVerified: true` and `allFileHashesVerified: true`. If verification fails, do not use the kit; obtain fresh official copies. Verification neither extracts the archive nor executes SDK code.

Public-key fingerprint: `BE9B8A2479C3E54E54BC0D077AB21F5F133692713CA2EE5F45859F6346CD4868`

This checks signature and contents, not current revocation information. Also check the official release and update notices. The publicly released kit includes an official detached signature.

[Contents](../../README.md)
