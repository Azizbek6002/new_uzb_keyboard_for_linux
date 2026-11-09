#!/usr/bin/env python3
"""
Unit tests for Uzbek New Latin Keyboard Layouts (Variant A)
"""

import unittest
import os
import subprocess
import shutil

class TestUzbekLayout(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.repo_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        cls.symbols_file = os.path.join(cls.repo_dir, "symbols", "uz")
        cls.xkbcli = shutil.which("xkbcli")
        if not cls.xkbcli:
            conda_xkbcli = "/home/azizbek/miniconda3/libexec/xkbcommon/xkbcli-compile-keymap"
            if os.path.exists(conda_xkbcli):
                cls.xkbcli = conda_xkbcli

    def test_symbols_file_exists(self):
        self.assertTrue(os.path.exists(self.symbols_file), "symbols/uz fayli mavjud bo'lishi kerak")

    def test_xkb_compilation_variants(self):
        if not self.xkbcli:
            self.skipTest("xkbcli topilmadi, test o'tkazib yuborildi")

        variants = ["latin", "latin_altgr", "latin_shift"]
        for variant in variants:
            with self.subTest(variant=variant):
                cmd = [
                    self.xkbcli, "compile-keymap" if "libexec" not in self.xkbcli else "",
                    "--include", os.path.join(self.repo_dir),
                    "--include-defaults",
                    "--layout", "uz",
                    "--variant", variant,
                    "--test"
                ]
                cmd = [c for c in cmd if c]
                res = subprocess.run(cmd, capture_output=True, text=True)
                self.assertEqual(res.returncode, 0, f"Variant {variant} kompilatsiya qilinmadi:\n{res.stderr}")

    def test_variant_a_keysyms(self):
        if not self.xkbcli:
            self.skipTest("xkbcli topilmadi")

        cmd = [
            self.xkbcli, "compile-keymap" if "libexec" not in self.xkbcli else "",
            "--include", os.path.join(self.repo_dir),
            "--include-defaults",
            "--layout", "uz",
            "--variant", "latin"
        ]
        cmd = [c for c in cmd if c]
        res = subprocess.run(cmd, capture_output=True, text=True)
        self.assertEqual(res.returncode, 0)
        output = res.stdout

        # Verify key definitions on brackets and semicolons
        self.assertIn("key <AD11>", output, "AD11 ([) mavjud bo'lishi kerak")
        self.assertIn("gbreve", output, "[ -> ğ bo'lishi kerak")
        self.assertIn("odiaeresis", output, "] -> ö bo'lishi kerak")
        self.assertIn("scedilla", output, "; -> ş bo'lishi kerak")
        self.assertIn("ccedilla", output, "' -> ç bo'lishi kerak")

if __name__ == "__main__":
    unittest.main()
