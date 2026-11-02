# 作品の短い仕様説明

対象は1.1.0です。ここでは付属サンプルが使う形式を説明します。将来版の機能を約束するものではありません。

## 入口と種類

C#の入口は `public static string Run(string input)` です。入力も出力も文字列です。

| 種類 | 返す内容 | 例 |
|---|---|---|
| Plugin | 選択した出力種類に合う文字列 | [hello](../../samples/hello/HelloPlugin.cs) |
| Provider | 値を並べたJSON | [provider-renderer](../../samples/provider-renderer/README.md) |
| Renderer | 図形またはHTML表示を指定するJSON | [html](../../samples/html/README.md) |

JSONの名前は大文字・小文字を区別します。通常入力の上限は16,384文字です。大きなデータは分けるか減らしてください。

## Provider：値を渡す

`PluginOutputCodec.ReadProvider` で読めるJSONを返します。UTF-8で最大65,536バイト、`Schema` は1、`Values` は1〜64件です。

```json
{"Schema":1,"Values":[{"Field":"demo.value","Label":"Demo input","Value":37,"Unit":"%","Quality":"Valid","Reason":null}]}
```

`Field` は重複しない識別子、`Label` は128文字以内、`Unit` は32文字以内です。識別子は1〜128文字の半角英数字と `._-:` が使えます。`Quality` は `Valid`、`Unknown`、`Stale`、`Unavailable`。`Valid` の値は有限の数値、それ以外は `null` と256文字以内の理由を指定します。取得できない値を0に置き換えません。

## Renderer：図形を描く

`PluginOutputCodec.ReadScene` で読めるJSONを返します。`Schema=1`、`Width`、`Height`、`Label`、`Description`、`Elements` を指定します。

`Elements` は最大128件。`Kind` は `line` / `circle` / `rect` / `text`。位置は `X`,`Y`、色は `#RRGGBB`。`A`,`B` は線の終点、円の半径（A）、長方形の幅と高さに使います。`Size` は線幅または文字サイズ、`Text` は表示文字です。画面の幅・高さは0より大きく8,192以下。JSON全体は65,536バイト以内です。文字は1要素1,024文字、全体4,096文字まで。数値は有限値にします。動く形は付属サンプルを参照してください。

## HTML表示

`PluginHtmlDocument` と `PluginHtmlCodec.Read` を使います。`Schema=1`、`Format="html"`、`Entry="assets/index.html"` を指定し、そのHTMLとJSを作品へ同梱します。幅120〜2,048、高さ60〜2,048、ラベル128文字、`Data` は8,192文字までです。JSON全体は65,536バイトまで。

JSは `chrome.webview` の `message` イベントから値を受け取ります。文字の表示は `textContent` を使います。外部サイトやローカルファイルへ直接アクセスできません。WebView2 Runtimeが必要です。HTML/JSを変えたら作品を再署名してください。

## ファイルやHTTPSから値を受け取る

`PluginResources.Read` は、利用者が選んで許可した値を読みます。作品は先に `Id`、`Operation`、用途の説明を宣言します。最大4件、操作は `file.text` / `file.length` / `https.text` です。宣言に実際のパスやURLを埋め込みません。

入力は `Schema=1`、`Input`、`Resources`。各値は `Id`、`Operation`、`Text` を持ちます。`Input` は4,096文字、各 `Text` はUTF-8で2,048バイト以内です。ファイルサイズは負でない整数の文字列です。読み取り対象や許可を選び直す必要があるため、PC再起動後に自動で許可を引き継ぎません。

## 同梱する素材

`PluginAssets.Read("message.txt")` は、署名された作品内の素材を読みます。PCの任意ファイルを読む命令ではありません。追加素材・ライブラリーは最大32ファイル、1ファイル8 MiB、合計32 MiB。素材名は半角英数字で始め、半角英数字と `._-` を使います。アプリ内の確認で不適切な名前や未対応の依存物は拒否されます。

## manifest.jsonとSchema

[manifestの例](../../schemas/example.manifest.json)と[Schema](../../schemas/manifest.schema.json)はCLIの `validate` 用です。作品の署名情報や、本体内部の保存形式ではありません。Schemaは編集の補助です。重複キー、両方の権限一覧に同じ値がある場合などは実ツールでも検査してください。権限名を書くだけではアクセス許可は得られません。

[制作ガイド](getting-started.md) · [コマンド](cli.md) · [目次](../../README.md)
