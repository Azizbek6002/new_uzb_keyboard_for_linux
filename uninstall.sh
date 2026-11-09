#!/usr/bin/env bash
# =============================================================================
# Uzbek New Latin Keyboard Layout - Secure Uninstaller
# =============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}${BOLD}O'zbek Yangi Alifbosi klaviaturasini o'chirish...${NC}"

# User level removal
if [ -f "$HOME/.config/xkb/symbols/uz" ]; then
    rm -f "$HOME/.config/xkb/symbols/uz"
    echo -e "${GREEN}✓ Foydalanuvchi maketi o'chirildi: ~/.config/xkb/symbols/uz${NC}"
fi

# GNOME input sources tozalash
if command -v gsettings >/dev/null 2>&1; then
    CURRENT_SOURCES=$(gsettings get org.gnome.desktop.input-sources sources 2>/dev/null || echo "[]")
    NEW_SOURCES=$(python3 -c "
import sys, ast
try:
    s = ast.literal_eval(sys.argv[1])
    s = [item for item in s if item not in [('xkb', 'uz+latin'), ('xkb', 'uz')]]
    print(repr(s))
except Exception:
    print(\"[('xkb', 'us'), ('xkb', 'ru')]\")
" "$CURRENT_SOURCES")
    gsettings set org.gnome.desktop.input-sources sources "$NEW_SOURCES"
    echo -e "${GREEN}✓ GNOME sozlamalaridan olib tashlandi.${NC}"
fi

# System level removal if root
if [ "${EUID:-$(id -u)}" -eq 0 ]; then
    if [ -f "/usr/share/X11/xkb/symbols/uz.backup" ]; then
        mv "/usr/share/X11/xkb/symbols/uz.backup" "/usr/share/X11/xkb/symbols/uz"
        echo -e "${GREEN}✓ Tizim zaxira nusxasi tiklandi: /usr/share/X11/xkb/symbols/uz${NC}"
    fi
    if [ -f "/usr/share/X11/xkb/rules/evdev.xml.backup" ]; then
        mv "/usr/share/X11/xkb/rules/evdev.xml.backup" "/usr/share/X11/xkb/rules/evdev.xml"
        echo -e "${GREEN}✓ evdev.xml zaxira nusxasi tiklandi.${NC}"
    fi
fi

echo -e "${GREEN}${BOLD}✓ To'liq o'chirildi!${NC}"
