#!/usr/bin/env bash
# =============================================================================
# Uzbek New Latin Keyboard Layout - System-wide Secure Installer (Requires sudo)
# =============================================================================

set -euo pipefail
umask 022

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

if [ "${EUID:-$(id -u)}" -ne 0 ]; then
    echo -e "${RED}Xato: Ushbu skript tizim fayllarini o'zgartirishi uchun sudo talab qilinadi:${NC}"
    echo -e "  ${YELLOW}sudo ./install.sh${NC}"
    echo -e "Yoki sudo-siz foydalanuvchi darajasida o'rnatish uchun:"
    echo -e "  ${YELLOW}./setup.sh${NC}"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMBOLS_DIR="/usr/share/X11/xkb/symbols"
RULES_DIR="/usr/share/X11/xkb/rules"

if [ ! -d "$SYMBOLS_DIR" ]; then
    echo -e "${RED}Xato: $SYMBOLS_DIR papkasi topilmadi.${NC}"
    exit 1
fi

echo -e "${BLUE}${BOLD}Tizim miqyosida o'rnatilmoqda...${NC}"

# Backup existing uz symbols safely
if [ -f "$SYMBOLS_DIR/uz" ] && [ ! -f "$SYMBOLS_DIR/uz.backup" ]; then
    cp -p "$SYMBOLS_DIR/uz" "$SYMBOLS_DIR/uz.backup"
    echo -e "${GREEN}✓ Zaxira nusxa yaratildi: $SYMBOLS_DIR/uz.backup${NC}"
fi

cp -p "$SCRIPT_DIR/symbols/uz" "$SYMBOLS_DIR/uz"
chmod 644 "$SYMBOLS_DIR/uz"
echo -e "${GREEN}✓ Yangi klaviatura maketi o'rnatildi: $SYMBOLS_DIR/uz${NC}"

# Update evdev.xml if exists and not already patched
if [ -f "$RULES_DIR/evdev.xml" ]; then
    if ! grep -q "latin_altgr" "$RULES_DIR/evdev.xml"; then
        cp -p "$RULES_DIR/evdev.xml" "$RULES_DIR/evdev.xml.backup"
        python3 -c "
import sys
rules_file = '$RULES_DIR/evdev.xml'
with open(rules_file, 'r', encoding='utf-8') as f:
    content = f.read()

target = '<name>uz</name>'
sub_target = '</variantList>'

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
        with open(rules_file, 'w', encoding='utf-8') as f:
            f.write(content)
        print('evdev.xml muvaffaqiyatli yangilandi')
" || true
    fi
fi

# Clean XKB cache if exists
rm -rf /var/lib/xkb/* 2>/dev/null || true

echo -e "${GREEN}${BOLD}✓ Tizim darajasida muvaffaqiyatli o'rnatildi!${NC}"
echo -e "Endi barcha foydalanuvchilar va tizim kirish ekranida (GDM) ushbu maket mavjud."
