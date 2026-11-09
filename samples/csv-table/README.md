# CSVを表示用に変換 / Convert a CSV table

Python 3を用意します。次のコマンドは、選んだCSVを読み、JSONを表示するだけです。通信しません。
Install Python 3. This command reads the selected CSV and prints JSON; it makes no network requests.

```powershell
python csv_to_board.py example.csv
```

出力は `columns` と `rows` を持つJSONです。UTF-8で保存し、アプリの「外部データ取込」で内容を確認して使います。Windows PowerShellで保存するときは出力の文字コードにも注意してください。例：
The output has `columns` and `rows`. Save as UTF-8 and review it in the app's external data import. In Windows PowerShell, set the output encoding explicitly:

```powershell
python csv_to_board.py example.csv | Set-Content -Encoding UTF8 example.json
```

先頭行は重複しない列名（1〜8列）、以降は最大100行、セルは512文字相当以内です。日本語WindowsのCSVには `--encoding cp932` を指定できます。上限を超えると切り捨てず失敗します。
The first row has 1–8 unique headers, followed by at most 100 rows. Cells allow 512 UTF-16 units. Use `--encoding cp932` for that encoding. Oversized input fails rather than being silently truncated.

この例は固定データです。実際の情報源を使うときは出典・更新時刻と利用条件を確認してください。
This example uses fixed data. Check source, update time and terms before using real data.
