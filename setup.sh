#!/usr/bin/env bash
# =============================================================================
# Uzbek New Latin Keyboard Layout - User-level Installer (No sudo required)
# O'zbek Tili Yangi Alifbosi - Foydalanuvchi darajasidagi o'rnatuvchi
# =============================================================================

set -e

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

MODE="${1:-shift}"

TARGET_DIR="$HOME/.config/xkb/symbols"
mkdir -p "$TARGET_DIR"

echo -e "Tanlangan rejim: ${YELLOW}${BOLD}$MODE${NC}"

if [ "$MODE" = "altgr" ]; then
    cat << 'LAYOUT_EOF' > "$TARGET_DIR/uz"
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
    cat << 'LAYOUT_EOF' > "$TARGET_DIR/uz"
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
    # Default: shift mode (user requested)
    cat << 'LAYOUT_EOF' > "$TARGET_DIR/uz"
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

# GNOME input sources sozlash
if command -v gsettings >/dev/null 2>&1; then
    CURRENT_SOURCES=$(gsettings get org.gnome.desktop.input-sources sources)
    NEW_SOURCES=$(python3 -c "
import sys, ast
try:
    s = ast.literal_eval(sys.argv[1])
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
echo -e "Klaviatura tilini almashtirish uchun: ${YELLOW}${BOLD}Super (Win) + Space${NC}"
echo ""
if [ "$MODE" = "altgr" ]; then
    echo -e "Tugmalar tartibi (AltGr rejimi):"
    echo -e "  - O'ng Alt + o  -> ${BOLD}ö${NC}  |  O'ng Alt + Shift + o -> ${BOLD}Ö${NC}"
    echo -e "  - O'ng Alt + g  -> ${BOLD}ğ${NC}  |  O'ng Alt + Shift + g -> ${BOLD}Ğ${NC}"
    echo -e "  - O'ng Alt + s  -> ${BOLD}ş${NC}  |  O'ng Alt + Shift + s -> ${BOLD}Ş${NC}"
    echo -e "  - O'ng Alt + c  -> ${BOLD}ç${NC}  |  O'ng Alt + Shift + c -> ${BOLD}Ç${NC}"
    echo -e "  - O'ng Alt + '  -> ${BOLD}ʻ${NC} (Tutuq belgisi)"
else
    echo -e "Tugmalar tartibi (Shift rejimi):"
    echo -e "  - Shift + o  -> ${BOLD}ö${NC}  |  O'ng Alt + o -> ${BOLD}O${NC}  |  O'ng Alt + Shift + o -> ${BOLD}Ö${NC}"
    echo -e "  - Shift + g  -> ${BOLD}ğ${NC}  |  O'ng Alt + g -> ${BOLD}G${NC}  |  O'ng Alt + Shift + g -> ${BOLD}Ğ${NC}"
    echo -e "  - Shift + s  -> ${BOLD}ş${NC}  |  O'ng Alt + s -> ${BOLD}S${NC}  |  O'ng Alt + Shift + s -> ${BOLD}Ş${NC}"
    echo -e "  - Shift + c  -> ${BOLD}ç${NC}  |  O'ng Alt + c -> ${BOLD}C${NC}  |  O'ng Alt + Shift + c -> ${BOLD}Ç${NC}"
    echo -e "  - O'ng Alt + '  -> ${BOLD}ʻ${NC} (Tutuq belgisi)"
fi
echo ""
