#!/usr/bin/env bash
# =============================================================================
# Uzbek New Latin Keyboard Layout - System-wide Installer (Requires sudo)
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Iltimos, ushbu skriptni sudo bilan ishga tushiring: sudo ./install.sh${NC}"
    echo -e "Yoki parolsiz o'rnatish uchun: ${YELLOW}./setup.sh${NC}"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMBOLS_DIR="/usr/share/X11/xkb/symbols"
RULES_DIR="/usr/share/X11/xkb/rules"

echo -e "${BLUE}${BOLD}Tizim miqyosida o'rnatilmoqda...${NC}"

# Backup existing uz symbols
if [ -f "$SYMBOLS_DIR/uz" ] && [ ! -f "$SYMBOLS_DIR/uz.backup" ]; then
    cp "$SYMBOLS_DIR/uz" "$SYMBOLS_DIR/uz.backup"
    echo -e "${GREEN}✓ Zaxira nusxa yaratildi: $SYMBOLS_DIR/uz.backup${NC}"
fi

cp "$SCRIPT_DIR/symbols/uz" "$SYMBOLS_DIR/uz"
echo -e "${GREEN}✓ Yangi klaviatura maketi o'rnatildi: $SYMBOLS_DIR/uz${NC}"

# Update evdev.xml if not already patched
if [ -f "$RULES_DIR/evdev.xml" ]; then
    if ! grep -q "latin_altgr" "$RULES_DIR/evdev.xml"; then
        cp "$RULES_DIR/evdev.xml" "$RULES_DIR/evdev.xml.backup"
        # Add variants under layout uz
        python3 -c "
with open('$RULES_DIR/evdev.xml', 'r', encoding='utf-8') as f:
    content = f.read()

target = '<name>uz</name>'
sub_target = '</variantList>'

# Find layout uz and insert variants
pos_uz = content.find(target)
if pos_uz != -1:
    pos_vlist = content.find(sub_target, pos_uz)
    if pos_vlist != -1:
        new_variants = '''        <variant>
          <configItem>
            <name>latin_altgr</name>
            <description>Uzbek (New Latin, AltGr Mode)</description>
          </configItem>
        </variant>
        <variant>
          <configItem>
            <name>latin_turkish</name>
            <description>Uzbek (New Latin, Turkish Style)</description>
          </configItem>
        </variant>
'''
        content = content[:pos_vlist] + new_variants + content[pos_vlist:]
        with open('$RULES_DIR/evdev.xml', 'w', encoding='utf-8') as f:
            f.write(content)
        print('evdev.xml patched successfully')
" || true
    fi
fi

# Clean XKB cache if exists
rm -rf /var/lib/xkb/* 2>/dev/null || true

echo -e "${GREEN}${BOLD}✓ Tizim darajasida muvaffaqiyatli o'rnatildi!${NC}"
echo -e "Endi tizim sozlamalaridan yoki Super+Space orqali ishlatishingiz mumkin."
