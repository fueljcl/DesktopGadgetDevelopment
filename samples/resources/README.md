# 許可した文章を読む / Read approved text

`ResourcePlugin.cs` をアプリでコンパイルします。種類はPlugin、入口は `Example.ResourcePlugin`、出力はテキスト。必要なデータの宣言でID `document`、操作 `file.text` と用途を追加します。署名・導入後、実行時にUTF-8テキストを選んで許可します。入力と選択した本文を返します。

Compile `ResourcePlugin.cs` in the app. Choose Plugin, entry `Example.ResourcePlugin`, and text output. Declare resource ID `document`, operation `file.text`, and its purpose. After signing and installation, select and allow a UTF-8 text file at execution. The result contains the original input and selected text.

宣言だけでファイルを読めるわけではありません。対象の選択と許可が必要です。本文はUTF-8で2,048バイト以内です。
The declaration alone does not grant file access. The user must select and allow the target. Text is limited to 2,048 UTF-8 bytes.
