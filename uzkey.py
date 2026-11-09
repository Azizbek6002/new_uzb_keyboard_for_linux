#!/usr/bin/env python3
"""
uzkey - Uzbek New Latin Keyboard Manager CLI
O'zbek tili yangi alifbosi klaviaturasi boshqaruvchisi.
"""

import sys
import os
import argparse
import subprocess
import ast

HOME = os.path.expanduser("~")
XKB_SYMBOLS_DIR = os.path.join(HOME, ".config", "xkb", "symbols")
XKB_UZ_FILE = os.path.join(XKB_SYMBOLS_DIR, "uz")

LAYOUT_TEMPLATES = {
    "shift": """// Shift Mode: Shift+o = ö, Shift+g = ğ, Shift+s = ş, Shift+c = ç
// Katta harflar: AltGr+o = O, AltGr+Shift+o = Ö
default partial alphanumeric_keys
xkb_symbols "latin" {
    include "us(basic)"
    name[Group1] = "Uzbek (New Latin, Shift Mode)";

    include "level3(ralt_switch)"

    key <AD09> { [ o, odiaeresis, O, Odiaeresis ] };
    key <AC05> { [ g, gbreve,     G, Gbreve     ] };
    key <AC02> { [ s, scedilla,   S, Scedilla   ] };
    key <AB03> { [ c, ccedilla,   C, Ccedilla   ] };
    key <AC11> { [ apostrophe, quotedbl, U02BB, U02BC ] };
};
""",
    "altgr": """// AltGr Mode: Oddiy Shift+o = O, AltGr+o = ö, AltGr+Shift+o = Ö
default partial alphanumeric_keys
xkb_symbols "latin" {
    include "us(basic)"
    name[Group1] = "Uzbek (New Latin, AltGr Mode)";

    include "level3(ralt_switch)"

    key <AD09> { [ o, O, odiaeresis, Odiaeresis ] };
    key <AC05> { [ g, G, gbreve,     Gbreve     ] };
    key <AC02> { [ s, S, scedilla,   Scedilla   ] };
    key <AB03> { [ c, C, ccedilla,   Ccedilla   ] };
    key <AC11> { [ apostrophe, quotedbl, U02BB, U02BC ] };
};
""",
    "turkish": """// Turkish Q Style: [ -> ğ, ] -> ö, ; -> ş, ' -> ç
default partial alphanumeric_keys
xkb_symbols "latin" {
    include "us(basic)"
    name[Group1] = "Uzbek (New Latin, Turkish Style)";

    key <AD11> { [ gbreve,   Gbreve,   bracketleft, braceleft ] };
    key <AD12> { [ odiaeresis, Odiaeresis, bracketright, braceright ] };
    key <AC10> { [ scedilla, Scedilla, semicolon, colon ] };
    key <AC11> { [ ccedilla, Ccedilla, apostrophe, quotedbl ] };
};
"""
}

def get_gnome_sources():
    try:
        res = subprocess.run(
            ["gsettings", "get", "org.gnome.desktop.input-sources", "sources"],
            capture_output=True, text=True, check=True
        )
        return ast.literal_eval(res.stdout.strip())
    except Exception:
        return []

def set_gnome_sources(sources):
    try:
        subprocess.run(
            ["gsettings", "set", "org.gnome.desktop.input-sources", "sources", repr(sources)],
            check=True
        )
        return True
    except Exception as e:
        print(f"Xatolik: {e}")
        return False

def detect_current_mode():
    if not os.path.exists(XKB_UZ_FILE):
        return None
    try:
        with open(XKB_UZ_FILE, "r", encoding="utf-8") as f:
            content = f.read()
        if "Turkish Style" in content or "AD11" in content:
            return "turkish"
        elif "AltGr Mode" in content:
            return "altgr"
        elif "Shift Mode" in content:
            return "shift"
        return "custom"
    except Exception:
        return "unknown"

def cmd_status(args):
    print("\n\033[1;34m=== O'zbek Klaviaturasi Holati (Status) ===\033[0m")
    mode = detect_current_mode()
    sources = get_gnome_sources()
    is_in_gnome = any(s == ("xkb", "uz+latin") or s == ("xkb", "uz") for s in sources)

    print(f"O'rnatilgan fayl: {XKB_UZ_FILE}")
    print(f"Fayl mavjudmi:   {'✓ Ha' if mode else '✗ Yo`q'}")
    if mode:
        print(f"Hozirgi rejim:   \033[1;32m{mode.upper()}\033[0m")
    print(f"GNOME tillari:   {sources}")
    print(f"GNOMEda faolmi:  {'\033[1;32m✓ Ha (uz+latin mavjud)\033[0m' if is_in_gnome else '\033[1;31m✗ Faol emas\033[0m'}")
    print("\nTilni almashtirish tugmasi: \033[1;33mSuper (Win) + Space\033[0m\n")

def cmd_setup(args):
    mode = args.mode.lower()
    if mode not in LAYOUT_TEMPLATES:
        print(f"Noma'lum rejim: {mode}. Tanlovlar: shift, altgr, turkish")
        sys.exit(1)

    os.makedirs(XKB_SYMBOLS_DIR, exist_ok=True)
    with open(XKB_UZ_FILE, "w", encoding="utf-8") as f:
        f.write(LAYOUT_TEMPLATES[mode])
    print(f"\033[1;32m✓ {mode.upper()} rejimi faylga yozildi: {XKB_UZ_FILE}\033[0m")

    sources = get_gnome_sources()
    if ("xkb", "uz+latin") not in sources:
        sources.append(("xkb", "uz+latin"))
        set_gnome_sources(sources)
        print("\033[1;32m✓ GNOME klaviatura tillariga 'Uzbek (Latin)' muvaffaqiyatli qo'shildi!\033[0m")
    else:
        # Trigger reload
        set_gnome_sources(sources)
        print("\033[1;32m✓ GNOME sozlamalari yangilandi!\033[0m")

    print("\n\033[1;33mKlaviaturani yoqish uchun: Super (Win) + Space tugmalarini bosing.\033[0m\n")

def cmd_switch(args):
    cmd_setup(args)

def cmd_info(args):
    print("""
\033[1;36m=============================================================================
                O'ZBEK TILI YANGI ALIFBOSI KLAVIATURA XARITASI
=============================================================================\033[0m

1) \033[1mSHIFT REJIMI\033[0m (Foydalanuvchi so'ragan rejim):
   -------------------------------------------------------------------------
   Tugma            Natija          Katta Harf (AltGr)    Katta Harf (AltGr+Shift)
   -------------------------------------------------------------------------
   Shift + o   -->  \033[1;32mö\033[0m               AltGr + o   --> \033[1mO\033[0m     AltGr + Shift + o   --> \033[1;32mÖ\033[0m
   Shift + g   -->  \033[1;32mğ\033[0m               AltGr + g   --> \033[1mG\033[0m     AltGr + Shift + g   --> \033[1;32mĞ\033[0m
   Shift + s   -->  \033[1;32mş\033[0m               AltGr + s   --> \033[1mS\033[0m     AltGr + Shift + s   --> \033[1;32mŞ\033[0m
   Shift + c   -->  \033[1;32mç\033[0m               AltGr + c   --> \033[1mC\033[0m     AltGr + Shift + c   --> \033[1;32mÇ\033[0m
   AltGr + '   -->  \033[1;32mʻ\033[0m (Tutuq)       AltGr + Shift + ' --> \033[1;32mʼ\033[0m

2) \033[1mALTGR REJIMI\033[0m (Standart xalqaro usul):
   -------------------------------------------------------------------------
   Tugma            Kichik Harf                         Katta Harf
   -------------------------------------------------------------------------
   AltGr + o   -->  \033[1;32mö\033[0m               AltGr + Shift + o   --> \033[1;32mÖ\033[0m (Shift+o oddiy 'O')
   AltGr + g   -->  \033[1;32mğ\033[0m               AltGr + Shift + g   --> \033[1;32mĞ\033[0m (Shift+g oddiy 'G')
   AltGr + s   -->  \033[1;32mş\033[0m               AltGr + Shift + s   --> \033[1;32mŞ\033[0m (Shift+s oddiy 'S')
   AltGr + c   -->  \033[1;32mç\033[0m               AltGr + Shift + c   --> \033[1;32mÇ\033[0m (Shift+c oddiy 'C')
   AltGr + '   -->  \033[1;32mʻ\033[0m (Tutuq)       AltGr + Shift + ' --> \033[1;32mʼ\033[0m

3) \033[1mTURKISH Q REJIMI\033[0m (Maxsus tugmalar):
   -------------------------------------------------------------------------
   [  -->  \033[1;32mğ\033[0m  |  {  -->  \033[1;32mĞ\033[0m
   ]  -->  \033[1;32mö\033[0m  |  }  -->  \033[1;32mÖ\033[0m
   ;  -->  \033[1;32mş\033[0m  |  :  -->  \033[1;32mŞ\033[0m
   '  -->  \033[1;32mç\033[0m  |  "  -->  \033[1;32mÇ\033[0m
\033[1;36m=============================================================================\033[0m
""")

def cmd_test(args):
    print("\n\033[1;33mKlaviaturani jonli sinash (Test rejimi):\033[0m")
    print("Klaviaturangizda yangi harflarni yozib ko'ring (ö, ğ, ş, ç, ʻ):")
    print("Chiqish uchun \033[1mCtrl + C\033[0m bosing.\n")
    try:
        while True:
            line = input("Matn kiriting > ")
            print(f"Kiritildi: {line}")
            # Highlight Uzbek new letters
            highlighted = ""
            for ch in line:
                if ch in "öÖğĞşŞçÇʻʼ":
                    highlighted += f"\033[1;32m{ch}\033[0m"
                else:
                    highlighted += ch
            print(f"Tahlil:    {highlighted}\n")
    except (KeyboardInterrupt, EOFError):
        print("\nTest yakunlandi.")

def main():
    parser = argparse.ArgumentParser(
        description="O'zbek tili yangi alifbosi klaviaturasi boshqaruv dasturi."
    )
    subparsers = parser.add_subparsers(dest="command")

    p_status = subparsers.add_parser("status", help="Klaviaturaning joriy holatini ko'rish")
    p_status.set_defaults(func=cmd_status)

    p_setup = subparsers.add_parser("setup", help="Klaviaturani o'rnatish")
    p_setup.add_argument("--mode", default="shift", choices=["shift", "altgr", "turkish"],
                         help="Rejimni tanlash (standart: shift)")
    p_setup.set_defaults(func=cmd_setup)

    p_switch = subparsers.add_parser("switch", help="Rejimni o'zgartirish (shift/altgr/turkish)")
    p_switch.add_argument("mode", choices=["shift", "altgr", "turkish"], help="Yangi rejim")
    p_switch.set_defaults(func=cmd_switch)

    p_info = subparsers.add_parser("info", help="Tugmalar xaritasini ko'rsatish")
    p_info.set_defaults(func=cmd_info)

    p_test = subparsers.add_parser("test", help="Jonli yozib ko'rish testi")
    p_test.set_defaults(func=cmd_test)

    args = parser.parse_args()
    if not args.command:
        parser.print_help()
        sys.exit(0)

    args.func(args)

if __name__ == "__main__":
    main()
