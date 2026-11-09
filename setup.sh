#!/usr/bin/env bash
# =============================================================================
# Uzbek New Latin Keyboard Layout - User-level Secure Installer
# O'zbek Tili Yangi Alifbosi - Xavfsiz Foydalanuvchi O'rnatuvchisi
# =============================================================================

set -euo pipefail
umask 022

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}${BOLD}======================================================${NC}"
echo -e "${BLUE}${BOLD}   O'zbek Tili Yangi Lotin Alifbosi Klaviaturasi      ${NC}"
echo -e "${BLUE}${BOLD}   (Uzbek New Latin Keyboard Layout - Variant A)     ${NC}"
echo -e "${BLUE}${BOLD}======================================================${NC}"
echo ""

# Input sanitization and validation (standart: a)
INPUT_MODE="${1:-a}"
MODE=$(echo "$INPUT_MODE" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]_')

case "$MODE" in
    a|primary|turkish|brackets)
        MODE="a"
        ;;
    altgr)
        MODE="altgr"
        ;;
    shift)
        MODE="shift"
        ;;
    *)
        echo -e "${RED}Xato: Noto'g'ri rejim ko'rsatildi: '$INPUT_MODE'.${NC}"
        echo -e "Ruxsat etilgan rejimlar: ${YELLOW}a${NC} (asosiy/qavslar), ${YELLOW}altgr${NC}, ${YELLOW}shift${NC}"
        exit 1
        ;;
esac

TARGET_DIR="$HOME/.config/xkb/symbols"
mkdir -p "$TARGET_DIR"

TARGET_FILE="$TARGET_DIR/uz"

if [ "$MODE" = "altgr" ]; then
    cat << 'LAYOUT_EOF' > "$TARGET_FILE"
// AltGr Mode: Oddiy Shift+o = O, AltGr+o = ö, AltGr+Shift+o = Ö
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
LAYOUT_EOF
    echo -e "${GREEN}✓ AltGr rejimi o'rnatildi!${NC}"
elif [ "$MODE" = "shift" ]; then
    cat << 'LAYOUT_EOF' > "$TARGET_FILE"
// Shift Mode: Shift+o = ö, Shift+g = ğ, Shift+s = ş, Shift+c = ç
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
LAYOUT_EOF
    echo -e "${GREEN}✓ Shift rejimi o'rnatildi!${NC}"
else
    # Asosiy: Variant A (Qavslar va tinish belgilari o'rnida)
    cat << 'LAYOUT_EOF' > "$TARGET_FILE"
// Asosiy Tartib (Variant A):
// [ -> ğ, ] -> ö, ; -> ş, ' -> ç
default partial alphanumeric_keys
xkb_symbols "latin" {
    include "us(basic)"
    name[Group1] = "Uzbek (New Latin, Variant A - Primary)";

    include "level3(ralt_switch)"

    // [ key (AD11): ğ, Ğ, [, {
    key <AD11> { [ gbreve,     Gbreve,     bracketleft,  braceleft  ] };

    // ] key (AD12): ö, Ö, ], }
    key <AD12> { [ odiaeresis, Odiaeresis, bracketright, braceright ] };

    // ; key (AC10): ş, Ş, ;, :
    key <AC10> { [ scedilla,   Scedilla,   semicolon,    colon      ] };

    // ' key (AC11): ç, Ç, ', "
    key <AC11> { [ ccedilla,   Ccedilla,   apostrophe,   quotedbl   ] };

    // Qo'shimcha qulaylik: AltGr orqali ham ishlashi:
    key <AD09> { [ o, O, odiaeresis, Odiaeresis ] };
    key <AC05> { [ g, G, gbreve,     Gbreve     ] };
    key <AC02> { [ s, S, scedilla,   Scedilla   ] };
    key <AB03> { [ c, C, ccedilla,   Ccedilla   ] };

    // Tutuq belgisi (ʻ / ʼ):
    key <TLDE> { [ grave, asciitilde, U02BB, U02BC ] };
    key <BKSL> { [ backslash, bar, U02BB, U02BC ] };
};
LAYOUT_EOF
    echo -e "${GREEN}✓ Asosiy A-Variant (Qavslar o'rnida yangi harflar) o'rnatildi!${NC}"
fi

chmod 644 "$TARGET_FILE"

# GNOME input sources sozlash - uz+latin ni birinchi o'ringa qo'yamiz (birlamchi til qilish)
if command -v gsettings >/dev/null 2>&1; then
    CURRENT_SOURCES=$(gsettings get org.gnome.desktop.input-sources sources 2>/dev/null || echo "[]")
    NEW_SOURCES=$(python3 -c "
import sys, ast
try:
    s = ast.literal_eval(sys.argv[1])
    if not isinstance(s, list):
        s = []
    # uz+latin ni birinchi o'ringa joylaymiz
    s = [item for item in s if item not in [('xkb', 'uz+latin'), ('xkb', 'uz')]]
    s.insert(0, ('xkb', 'uz+latin'))
    if ('xkb', 'us') not in s:
        s.append(('xkb', 'us'))
    if ('xkb', 'ru') not in s:
        s.append(('xkb', 'ru'))
    print(repr(s))
except Exception:
    print(\"[('xkb', 'uz+latin'), ('xkb', 'us'), ('xkb', 'ru')]\")
" "$CURRENT_SOURCES")
    gsettings set org.gnome.desktop.input-sources sources "$NEW_SOURCES"
    gsettings set org.gnome.desktop.input-sources current 0 2>/dev/null || true
    echo -e "${GREEN}✓ GNOME klaviatura tillariga 'Uzbek (Latin)' birlamchi qilib ulandi!${NC}"
fi

echo ""
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo -e "${GREEN}${BOLD}   Muvaffaqiyatli o'rnatildi va faollashtirildi!      ${NC}"
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo ""
echo -e "Tugmalar tartibi (A-Variant):"
echo -e "  - ${BOLD}[${NC} tugmasi ➔ ${GREEN}${BOLD}ğ${NC}  |  ${BOLD}Shift + [${NC} ➔ ${GREEN}${BOLD}Ğ${NC}  (AltGr + [ ➔ [)"
echo -e "  - ${BOLD}]${NC} tugmasi ➔ ${GREEN}${BOLD}ö${NC}  |  ${BOLD}Shift + ]${NC} ➔ ${GREEN}${BOLD}Ö${NC}  (AltGr + ] ➔ ])"
echo -e "  - ${BOLD};${NC} tugmasi ➔ ${GREEN}${BOLD}ş${NC}  |  ${BOLD}Shift + ;${NC} ➔ ${GREEN}${BOLD}Ş${NC}  (AltGr + ; ➔ ;)"
echo -e "  - ${BOLD}'${NC} tugmasi ➔ ${GREEN}${BOLD}ç${NC}  |  ${BOLD}Shift + '${NC} ➔ ${GREEN}${BOLD}Ç${NC}  (AltGr + ' ➔ ')"
echo -e "  - ${BOLD}O'ng Alt + ~${NC} (Tilda) ➔ ${GREEN}${BOLD}ʻ${NC} (O'zbek tutuq belgisi)"
echo ""
echo -e "Inglizcha QWERTY (a-z, A-Z) to'liq saqlangan!"
echo -e "Tilni almashtirish uchun: ${YELLOW}${BOLD}Super (Win) + Space${NC}"
echo ""
