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
echo -e "${BLUE}${BOLD}   (Uzbek New Latin Keyboard Layout Installer)       ${NC}"
echo -e "${BLUE}${BOLD}======================================================${NC}"
echo ""

# Input sanitization and validation
INPUT_MODE="${1:-shift}"
MODE=$(echo "$INPUT_MODE" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]_')

case "$MODE" in
    shift|altgr|turkish)
        ;;
    *)
        echo -e "${RED}Xato: Noto'g'ri rejim ko'rsatildi: '$INPUT_MODE'.${NC}"
        echo -e "Ruxsat etilgan rejimlar: ${YELLOW}shift${NC}, ${YELLOW}altgr${NC}, ${YELLOW}turkish${NC}"
        exit 1
        ;;
esac

TARGET_DIR="$HOME/.config/xkb/symbols"
mkdir -p "$TARGET_DIR"

echo -e "Tanlangan rejim: ${YELLOW}${BOLD}$MODE${NC}"

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
elif [ "$MODE" = "turkish" ]; then
    cat << 'LAYOUT_EOF' > "$TARGET_FILE"
// Turkish Q Style: [ -> ğ, ] -> ö, ; -> ş, ' -> ç
default partial alphanumeric_keys
xkb_symbols "latin" {
    include "us(basic)"
    name[Group1] = "Uzbek (New Latin, Turkish Style)";

    key <AD11> { [ gbreve,   Gbreve,   bracketleft, braceleft ] };
    key <AD12> { [ odiaeresis, Odiaeresis, bracketright, braceright ] };
    key <AC10> { [ scedilla, Scedilla, semicolon, colon ] };
    key <AC11> { [ ccedilla, Ccedilla, apostrophe, quotedbl ] };
};
LAYOUT_EOF
    echo -e "${GREEN}✓ Turkish Q rejimi o'rnatildi!${NC}"
else
    cat << 'LAYOUT_EOF' > "$TARGET_FILE"
// Shift Mode: Shift+o = ö, Shift+g = ğ, Shift+s = ş, Shift+c = ç
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
LAYOUT_EOF
    echo -e "${GREEN}✓ Shift rejimi o'rnatildi!${NC}"
fi

chmod 644 "$TARGET_FILE"

# GNOME input sources sozlash
if command -v gsettings >/dev/null 2>&1; then
    CURRENT_SOURCES=$(gsettings get org.gnome.desktop.input-sources sources 2>/dev/null || echo "[]")
    NEW_SOURCES=$(python3 -c "
import sys, ast
try:
    s = ast.literal_eval(sys.argv[1])
    if not isinstance(s, list):
        s = [('xkb', 'us')]
    if ('xkb', 'uz+latin') not in s:
        s.append(('xkb', 'uz+latin'))
    print(repr(s))
except Exception:
    print(\"[('xkb', 'us'), ('xkb', 'uz+latin'), ('xkb', 'ru')]\")
" "$CURRENT_SOURCES")
    gsettings set org.gnome.desktop.input-sources sources "$NEW_SOURCES"
    echo -e "${GREEN}✓ GNOME klaviatura tillariga 'Uzbek (Latin)' ulandi!${NC}"
fi

echo ""
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo -e "${GREEN}${BOLD}   Muvaffaqiyatli o'rnatildi! (Installation Complete) ${NC}"
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo ""
echo -e "Klaviatura tilini almashtirish: ${YELLOW}${BOLD}Super (Win) + Space${NC}"
echo ""
if [ "$MODE" = "altgr" ]; then
    echo -e "Tugmalar tartibi (AltGr rejimi):"
    echo -e "  - O'ng Alt + o  -> ${BOLD}ö${NC}  |  O'ng Alt + Shift + o -> ${BOLD}Ö${NC}"
    echo -e "  - O'ng Alt + g  -> ${BOLD}ğ${NC}  |  O'ng Alt + Shift + g -> ${BOLD}Ğ${NC}"
    echo -e "  - O'ng Alt + s  -> ${BOLD}ş${NC}  |  O'ng Alt + Shift + s -> ${BOLD}Ş${NC}"
    echo -e "  - O'ng Alt + c  -> ${BOLD}ç${NC}  |  O'ng Alt + Shift + c -> ${BOLD}Ç${NC}"
    echo -e "  - O'ng Alt + '  -> ${BOLD}ʻ${NC} (Tutuq belgisi)"
elif [ "$MODE" = "turkish" ]; then
    echo -e "Tugmalar tartibi (Turkish Q rejimi):"
    echo -e "  - [  -> ${BOLD}ğ${NC}  |  {  -> ${BOLD}Ğ${NC}"
    echo -e "  - ]  -> ${BOLD}ö${NC}  |  }  -> ${BOLD}Ö${NC}"
    echo -e "  - ;  -> ${BOLD}ş${NC}  |  :  -> ${BOLD}Ş${NC}"
    echo -e "  - '  -> ${BOLD}ç${NC}  |  \"  -> ${BOLD}Ç${NC}"
else
    echo -e "Tugmalar tartibi (Shift rejimi):"
    echo -e "  - Shift + o  -> ${BOLD}ö${NC}  |  O'ng Alt + o -> ${BOLD}O${NC}  |  O'ng Alt + Shift + o -> ${BOLD}Ö${NC}"
    echo -e "  - Shift + g  -> ${BOLD}ğ${NC}  |  O'ng Alt + g -> ${BOLD}G${NC}  |  O'ng Alt + Shift + g -> ${BOLD}Ğ${NC}"
    echo -e "  - Shift + s  -> ${BOLD}ş${NC}  |  O'ng Alt + s -> ${BOLD}S${NC}  |  O'ng Alt + Shift + s -> ${BOLD}Ş${NC}"
    echo -e "  - Shift + c  -> ${BOLD}ç${NC}  |  O'ng Alt + c -> ${BOLD}C${NC}  |  O'ng Alt + Shift + c -> ${BOLD}Ç${NC}"
    echo -e "  - O'ng Alt + '  -> ${BOLD}ʻ${NC} (Tutuq belgisi)"
fi
echo ""
