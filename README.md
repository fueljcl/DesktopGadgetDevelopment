# DesktopGadget 1.4.0 — Docs and Creator Kit

Ver.1.4.0の公開資料です。公式署名済みZIPと検証ファイルは公開リポジトリの downloads フォルダーで提供します。 / Public documentation for Ver.1.4.0. Officially signed ZIPs and verification files are available in the public repository’s downloads folder.

DesktopGadgetを使う方と、追加作品を作る方のための資料です。
This kit explains how to use DesktopGadget and create add-ons.

[公式サイト / Official website](https://desktopgadget.org/) · [本体のダウンロード / Application download](https://desktopgadget.org/download/) · [公開リポジトリ / Public repository](https://github.com/fueljcl/DesktopGadgetDevelopment)

| はじめに / Start here | 日本語 | English |
|---|---|---|
| 利用・更新 / Use and update | [利用ガイド](docs/ja/user-guide.md) | [User guide](docs/en/user-guide.md) |
| 最初の作品 / First add-on | [制作ガイド](docs/ja/getting-started.md) | [Getting started](docs/en/getting-started.md) |
| データの形式 / Data formats | [短い仕様説明](docs/ja/reference.md) | [Reference](docs/en/reference.md) |
| コマンド・エラー / Commands and errors | [検査ツール](docs/ja/cli.md) | [Check tools](docs/en/cli.md) |
| 公式署名 / Official signature | [確認方法](docs/ja/verify.md) | [Verification](docs/en/verify.md) |
| サンプル / Examples | [サンプル一覧](samples/README.md) | [Sample list](samples/README.md) |
| 利用条件 / Terms | [利用案内](docs/ja/usage-ja.md) | [Use of the software](docs/en/usage-en.md) |
| データの取扱い / Data handling | [説明](docs/ja/data-handling-ja.md) | [Explanation](docs/en/data-handling-en.md) |

対象はWindows 11 x64用のVer.1.4.0です。作品のデータ形式は第1版です。
The target is DesktopGadget 1.4.0 for Windows 11 x64, using version-1 add-on formats.

`tools/` は公式SDKと検査ツール、`samples/` は改造して使える例、`schemas/` は入力形式の補助説明です。
The `tools/` directory holds the SDK and check tool; `samples/` holds editable examples; `schemas/` describes an input format.

SDKの実行には.NET 10 Runtime、外部ビルドには.NET SDKが必要です。本体に付属する.NETは本体用で、SDKツール用のシステム環境を設定しません。アプリ内でソースをコンパイルする方法もあります。
The command-line tool needs the .NET 10 Runtime. External builds need a .NET SDK. The runtime bundled with the app does not set up a system runtime for this tool. You can also compile source files inside the app.

この一式には本体、管理ツール、秘密鍵、モデル、音声は含めません。利用条件は [LICENSE](LICENSE.md)、第三者表記は [NOTICE](NOTICE.md) を参照してください。
The kit does not contain the application, admin tools, private keys, models or voices. See [LICENSE](LICENSE.md) and [NOTICE](NOTICE.md).

SHA-256一覧は `file-manifest.json` にあります。公式の別添署名がZIP全体とこの一覧を保護します。署名ファイルと公開鍵も一緒に保管してください。
`file-manifest.json` lists SHA-256 hashes. The detached official signature protects the ZIP and inventory. Keep the signature file and public key with the ZIP.

今回の資料更新ではSDKの6ファイルを既存の1.2.0公開キットからそのまま保持しています。1.4.0の利用案内に合わせた文書と署名の更新です。
This documentation update retains all six SDK files from the published 1.2.0 kit unchanged. The guides and signed kit are updated for the 1.4.0 application release.
