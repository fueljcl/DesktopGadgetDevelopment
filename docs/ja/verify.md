# SDKの署名を確認する

本体とは別のCreator Kitです。本体のSetupへ渡さないでください。
公式の内容署名は、配布元とファイルの一致を確認します。WindowsのAuthenticode署名とは別です。

ZIP、同名の `.signature.json`、`official-release.pub` をそろえます。確認にはPowerShell 7.4以降と、信頼できる公式配布元から別途確認した `Verify-CreatorKit.ps1` を使います。未確認のZIPから取り出したスクリプトを、そのまま信用して実行しないでください。

```powershell
pwsh -NoProfile -File ./Verify-CreatorKit.ps1 -Archive ./DesktopGadget-1.3.5-CreatorKit-win-x64.zip -Signature ./DesktopGadget-1.3.5-CreatorKit-win-x64.signature.json -PublicKey ./official-release.pub
```

`status: PASS` と `officialSignatureVerified: true`、`allFileHashesVerified: true` を確認します。失敗したら使わず、正規のファイルを取得し直してください。確認だけではZIPを展開したりSDKを実行したりしません。

公開鍵の指紋：`BE9B8A2479C3E54E54BC0D077AB21F5F133692713CA2EE5F45859F6346CD4868`

この確認は署名と内容の照合です。最新の失効情報は取得しません。公開時の公式案内と更新情報も確認してください。署名済みの公開版は、公式配布ページまたは公開リポジトリから取得してください。

[目次](../../README.md)
