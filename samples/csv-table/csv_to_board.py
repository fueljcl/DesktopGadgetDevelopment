"""Convert a user-selected CSV snapshot to DesktopGadget columns/rows JSON.

No network, scheduling, credential use or command execution. Data rights and
provider-specific conversion belong to the adapter author.
"""
import argparse
import csv
import io
import json
import pathlib
import sys
import unicodedata


def convert(data: bytes, encoding: str = "utf-8-sig") -> dict:
    if not 0 < len(data) <= 1_048_576:
        raise ValueError("CSV must be 1..1048576 bytes")
    if encoding not in ("utf-8-sig", "cp932"):
        raise ValueError("Unsupported encoding")
    rows = list(csv.reader(io.StringIO(data.decode(encoding, errors="strict")), strict=True))
    if not 1 <= len(rows) <= 101 or not 1 <= len(rows[0]) <= 8:
        raise ValueError("Use a header and at most 100 rows / 8 columns")
    columns = rows[0]
    if any(not cell.strip() for cell in columns) or len(set(columns)) != len(columns):
        raise ValueError("Column names must be nonblank and unique")
    for row in rows:
        if len(row) != len(columns):
            raise ValueError("Every row must match the header")
        for cell in row:
            if len(cell.encode("utf-16-le")) // 2 > 512 or any(unicodedata.category(c) == "Cc" for c in cell):
                raise ValueError("Cells must be at most 512 UTF-16 units without control characters")
    table = "\n".join("\t".join(row) for row in rows)
    if len(table.encode("utf-16-le")) // 2 > 16384:
        raise ValueError("Board snapshot exceeds 16384 UTF-16 units")
    return {"columns": columns, "rows": rows[1:]}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=pathlib.Path)
    parser.add_argument("--encoding", choices=("utf-8-sig", "cp932"), default="utf-8-sig")
    args = parser.parse_args()
    try:
        with args.csv.open("rb") as source:
            data = source.read(1_048_577)
        result = convert(data, args.encoding)
    except (OSError, ValueError, UnicodeError, csv.Error) as error:
        print("Conversion failed: " + str(error), file=sys.stderr)
        return 1
    sys.stdout.reconfigure(encoding="utf-8")
    print(json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
