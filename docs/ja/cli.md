# コマンドとエラー

ZIPを展開した一式のルートで実行します。.NET 10 Runtimeが必要です。コマンドは指定したローカルファイルだけを検査し、作品の実行・アップロードをしません。

```powershell
dotnet tools/DesktopGadget.Product.CreatorCli.dll validate schemas/example.manifest.json
dotnet tools/DesktopGadget.Product.CreatorCli.dll inspect-package C:/work/example.zip
```

`validate` はmanifestの形式、`inspect-package` はZIP内のmanifest・名前・容量・ファイルのSHA-256を調べます。通常の `inspect-package` は署名を確認しません。技術検査が通っても、安全・権利・実行許可を保証しません。

提出用ZIPの署名と提出説明をローカルで確認する場合だけ、次を使います。引数は自分のファイルに置き換えます。

```powershell
dotnet tools/DesktopGadget.Product.CreatorCli.dll inspect-submission C:/work/example.zip C:/work/example.signature.json example.author C:/work/creator-public.der VERIFIED_SHA256_FINGERPRINT
```

`VERIFIED_SHA256_FINGERPRINT` は公開鍵の指紋です。ZIPと同じ場所の自己申告を信じず、別の信頼できる経路で確認します。成功しても未投稿・未承認・未実行のままです。

| 終了コード | 意味 | 次の操作 |
|---|---|---|
| 0 | このコマンドの技術検査に合格 | 結果を読み、必要な署名・権利・本体側の確認へ進む |
| 1 | 入力を読めない、または検査不合格 | ファイル、形式、容量、署名と鍵の対応を確認 |
| 2 | コマンドや引数が不正 | 名前と引数の数を確認 |

`manifest.missing` は必須項目不足、`manifest.unknown` は未知の項目、`manifest.duplicate` は重複項目、`manifest.invalid` は値や型の不一致です。`package.inspection-failed`、`submission.inspection-failed` では対象ファイルと形式を見直してください。

ZIPは通常ファイルのみ、最大1,024ファイル、展開後64 MiB、ZIP自体65 MiBです。フォルダーだけの項目、リンク、重複名、外へ出るパスは拒否します。ZIPは展開・実行しません。

開発用の `pack-test`、`verify-package`、`inspect-live2d`、公式配布物用の `verify-release` は、この公開候補のコマンドではありません。署名と作品の導入は [アプリの制作手順](getting-started.md)を使います。

[仕様](reference.md) · [目次](../../README.md)
