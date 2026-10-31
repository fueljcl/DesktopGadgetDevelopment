# Commands and errors

Run these from the extracted kit's root. The .NET 10 Runtime is required. Commands inspect explicit local files; they do not run or upload works.

```powershell
dotnet tools/DesktopGadget.Product.CreatorCli.dll validate schemas/example.manifest.json
dotnet tools/DesktopGadget.Product.CreatorCli.dll inspect-package C:/work/example.zip
```

`validate` checks the manifest format. `inspect-package` checks the manifest, file names, sizes and SHA-256 hashes inside a ZIP. Ordinary package inspection does not verify a signature. Passing technical checks does not establish safety, rights or permission to run.

To check a submission ZIP's signature and declaration locally, replace the example arguments with your own files:

```powershell
dotnet tools/DesktopGadget.Product.CreatorCli.dll inspect-submission C:/work/example.zip C:/work/example.signature.json example.author C:/work/creator-public.der VERIFIED_SHA256_FINGERPRINT
```

The last argument is the public-key fingerprint, checked through a separate trusted channel rather than accepted from the ZIP's own claims. Success still does not upload, approve or run the work.

| Exit code | Meaning | Next step |
|---|---|---|
| 0 | This command's technical checks passed | Read the report; continue the required signature, rights and app checks |
| 1 | Input could not be read or failed checks | Check file, format, size, signature and key pairing |
| 2 | Invalid command or arguments | Check spelling and argument count |

`manifest.missing` means a required field is absent; `manifest.unknown`, an unknown field; `manifest.duplicate`, a repeated field; `manifest.invalid`, an invalid type or value. For `package.inspection-failed` or `submission.inspection-failed`, review the selected files and format.

ZIP limits are 1,024 regular files, 64 MiB expanded and 65 MiB archive size. Directory-only entries, links, duplicate names and escaping paths are rejected. The ZIP is not extracted or executed.

Development commands `pack-test`, `verify-package`, `inspect-live2d`, and official-release command `verify-release` are not offered in this public candidate. Use the [app's authoring steps](getting-started.md) to sign and install works.

[Reference](reference.md) · [Contents](../../README.md)
