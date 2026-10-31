import unittest
from csv_to_board import convert


class BoardConversionTests(unittest.TestCase):
    def test_utf8_and_cp932_preserve_text_and_leading_zeroes(self):
        text = '時刻,行先,情報源\r\n09:05,"架空,駅",テスト\r\n'
        for encoding in ("utf-8-sig", "cp932"):
            self.assertEqual(convert(text.encode(encoding), encoding),
                             {"columns": ["時刻", "行先", "情報源"], "rows": [["09:05", "架空,駅", "テスト"]]})

    def test_schema_and_control_characters_rejected(self):
        for text in ("a,a\nx,y", "a, \nx,y", "a,b\nx", 'a\n"line\nbreak"', "a\nx\ty", "a\n\x00"):
            with self.subTest(text=text), self.assertRaises(ValueError):
                convert(text.encode())

    def test_bounds_and_non_bmp_characters(self):
        for text in ("a\n" + "x" * 513, "a\n" + "😀" * 257, "a\n" + "x\n" * 101,
                     ",".join(str(i) for i in range(9)), "a\n" + ("x" * 512 + "\n") * 33):
            with self.subTest(length=len(text)), self.assertRaises(ValueError):
                convert(text.encode())
        self.assertEqual(len(convert(("a\n" + "😀" * 256).encode())["rows"][0][0]), 256)

    def test_input_encoding_and_size_are_explicit(self):
        for data, encoding in ((b"", "utf-8-sig"), (b"\xff", "utf-8-sig"), (b"x" * 1_048_577, "utf-8-sig"), (b"a", "latin1")):
            with self.assertRaises((ValueError, UnicodeError)):
                convert(data, encoding)


if __name__ == "__main__":
    unittest.main()
