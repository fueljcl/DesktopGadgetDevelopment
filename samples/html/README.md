# HTML表示 / HTML display

`HtmlRenderer.cs` をアプリでコンパイルします。種類はRenderer、入口は `HtmlRenderer`。素材に `index.html` と `display.js` を加え、確認・署名します。入力が画面に表示され、`+1` ボタンで数字が増えます。

Compile `HtmlRenderer.cs` in the app. Choose Renderer, entry `HtmlRenderer`. Add `index.html` and `display.js` as assets, review and sign. The input appears on screen; the `+1` button increments a counter.

WebView2 Runtimeが必要です。通常のブラウザで直接開く動作確認ではありません。アプリが値を渡し、外部通信や任意ファイルへのアクセスを制限します。素材を変えたら再署名してください。
WebView2 Runtime is required. Test inside the app, not by opening the HTML in an ordinary browser. The app supplies data and restricts external connections and arbitrary file access. Sign again after changing assets.
