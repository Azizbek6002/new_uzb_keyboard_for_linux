# 📖 Foydalanish Qo'llanmasi / User Guide / Руководство пользователя

> **O'zbek tili yangi alifbosi klaviaturasi (Linux / Ubuntu)**  
> Ushbu hujjat dasturni o'rnatish, sozlash, xavfsizlik kafolatlari va to'liq foydalanish bo'yicha 3 tilda batafsil qo'llanmadir.
> 
> 🌐 **Mundarija / Table of Contents / Оглавление:**
> 1. [🇺🇿 O'zbek tili (Qo'llanma)](#1-ozbek-tili-qollanma)
> 2. [🇬🇧 English (User Guide)](#2-english-user-guide)
> 3. [🇷🇺 Русский язык (Руководство)](#3-русский-язык-руководство)

---

# 1. 🇺🇿 O'zbek tili (Qo'llanma)

## 📌 Umumiy Ma'lumot
O'zbekiston Respublikasining lotin yozuviga asoslangan alifbosiga kiritilgan o'zgarishlarga muvofiq, quyidagi harflar yangilangan:
* **o'** ➔ **ö** (kichik) / **Ö** (katta) — `U+00F6` / `U+00D6`
* **g'** ➔ **ğ** (kichik) / **Ğ** (katta) — `U+011F` / `U+011E`
* **sh** ➔ **ş** (kichik) / **Ş** (katta) — `U+015F` / `U+015E`
* **ch** ➔ **ç** (kichik) / **Ç** (katta) — `U+00E7` / `U+00C7`
* **'** ➔ **ʻ** (to'g'ri o'zbek tutuq belgisi) — `U+02BB`

Ushbu dastur Linux (Ubuntu, Debian, Fedora, Arch va boshqa) tizimlarida oddiy klaviaturada mazkur harflarni tez va qulay yozish imkonini beradi.

---

## 🚀 O'rnatish

### 1-usul: Sudo-siz, tezkor o'rnatish (Tavsiya etiladi)
Hech qanday parol kiritmasdan, to'g'ridan-to'g'ri o'zingizning profilingizga o'rnatish:

```bash
cd new_uzb_keyboard_for_linux
./setup.sh
```

### 2-usul: Butun tizim (barcha foydalanuvchilar) uchun o'rnatish
```bash
sudo ./install.sh
```

---

## ⌨️ Qanday Ishlatiladi?

1. Klaviaturada tilni almashtirish uchun **`Super (Win) + Space (Probel)`** tugmalarini bosing.
2. Tizim panelida til indikatori **`uz`** ga o'zgaradi.
3. Yangi harflarni quyidagi tartibda yozishingiz mumkin:

### Tugmalar Jadvali (Shift Rejimi - Standart):

| Kerakli Harf | Bosiladigan Tugma | Katta Harf Uchun | Katta Harf Belgisi |
|:---:|:---:|:---:|:---:|
| **ö** | `Shift + o` | `O'ng Alt + o` ➔ **O** | `O'ng Alt + Shift + o` ➔ **Ö** |
| **ğ** | `Shift + g` | `O'ng Alt + g` ➔ **G** | `O'ng Alt + Shift + g` ➔ **Ğ** |
| **ş** | `Shift + s` | `O'ng Alt + s` ➔ **S** | `O'ng Alt + Shift + s` ➔ **Ş** |
| **ç** | `Shift + c` | `O'ng Alt + c` ➔ **C** | `O'ng Alt + Shift + c` ➔ **Ç** |
| **ʻ** (tutuq) | `O'ng Alt + '` | `O'ng Alt + Shift + '` ➔ **ʼ** | — |

---

## 🔄 Rejimlarni Boshqarish (`uzkey.py`)

Agar sizga Shift o'rniga xalqaro standart (AltGr) yoki Turkish uslubi ma'qul bo'lsa:

```bash
# AltGr rejimiga o'tish (Oddiy Shift+o = O, O'ng Alt+o = ö)
python3 uzkey.py switch altgr

# Qaytadan Shift rejimiga o'tish
python3 uzkey.py switch shift

# Turkish Q rejimiga o'tish ([ = ğ, ] = ö, ; = ş, ' = ç)
python3 uzkey.py switch turkish

# Holatni tekshirish
python3 uzkey.py status

# Jonli yozib sinab ko'rish testi
python3 uzkey.py test
```

---

## 🛡 Xavfsizlik Kafolati (Security)
* **Hech qanday keylogger yo'q:** Dastur klaviatura bosilishlarini ushlab oluvchi fonga yashirin xizmat (daemon) ishlatmaydi.
* **Tizim darajasida xavfsiz:** XKB (X Keyboard Extension) Linux yadrosi va GNOME/Wayland displey serveri ichidagi rasmiy mexanizmdan foydalanadi.
* **100% Ochiq manbali:** Barcha skriptlar atigi bir necha o'n qator ochiq koddan iborat bo'lib, xavfsizlik talablariga to'liq javob beradi.

---

## 🗑 O'chirish (Uninstall)
```bash
./uninstall.sh
```

---
---

# 2. 🇬🇧 English (User Guide)

## 📌 Overview
Following the latest Latin script reform for the Uzbek language, the following updated characters have been introduced:
* **o'** ➔ **ö** / **Ö** (`U+00F6` / `U+00D6`)
* **g'** ➔ **ğ** / **Ğ** (`U+011F` / `U+011E`)
* **sh** ➔ **ş** / **Ş** (`U+015F` / `U+015E`)
* **ch** ➔ **ç** / **Ç** (`U+00E7` / `U+00C7`)
* **'** ➔ **ʻ** (Official Uzbek modifier letter turned comma) (`U+02BB`)

This project provides a native Linux keyboard layout (XKB) and manager CLI to easily type these characters on standard keyboards without latency or security risks.

---

## 🚀 Installation

### Method 1: User-Level Install (No Sudo Required) - Recommended
```bash
cd new_uzb_keyboard_for_linux
./setup.sh
```

### Method 2: System-Wide Install (All users & GDM Login)
```bash
sudo ./install.sh
```

---

## ⌨️ Usage

1. Switch to the Uzbek layout using **`Super (Win key) + Space`**.
2. The language indicator in the top panel will show **`uz`**.
3. Type using the key combinations below:

### Default Keymap (Shift Mode):

| Target Letter | Keystroke | Ordinary Capital | Capital New Letter |
|:---:|:---:|:---:|:---:|
| **ö** | `Shift + o` | `Right Alt + o` ➔ **O** | `Right Alt + Shift + o` ➔ **Ö** |
| **ğ** | `Shift + g` | `Right Alt + g` ➔ **G** | `Right Alt + Shift + g` ➔ **Ğ** |
| **ş** | `Shift + s` | `Right Alt + s` ➔ **S** | `Right Alt + Shift + s` ➔ **Ş** |
| **ç** | `Shift + c` | `Right Alt + c` ➔ **C** | `Right Alt + Shift + c` ➔ **Ç** |
| **ʻ** (apostrophe) | `Right Alt + '` | `Right Alt + Shift + '` ➔ **ʼ** | — |

---

## 🔄 Mode Management (`uzkey.py`)

Easily switch between typing modes:

```bash
# Switch to AltGr Mode (Shift+o = O, Right Alt+o = ö)
python3 uzkey.py switch altgr

# Switch back to Shift Mode (Shift+o = ö)
python3 uzkey.py switch shift

# Switch to Turkish Q Style ([ = ğ, ] = ö, ; = ş, ' = ç)
python3 uzkey.py switch turkish

# Check layout status
python3 uzkey.py status

# Interactive live test
python3 uzkey.py test
```

---

## 🛡 Security & Privacy Guarantee
* **Zero Keylogger Risk:** No background daemon or key interception process runs.
* **Native Kernel/XKB Integration:** Keystrokes are handled directly by the Wayland/X11 display server.
* **Fully Auditable:** 100% open-source transparent Bash and Python scripts with zero external dependencies.

---

## 🗑 Uninstallation
```bash
./uninstall.sh
```

---
---

# 3. 🇷🇺 Русский язык (Руководство пользователя)

## 📌 Общие Сведения
В соответствии с реформой узбекского латинского алфавита, были введены новые буквы:
* **o'** ➔ **ö** (строчная) / **Ö** (заглавная) — `U+00F6` / `U+00D6`
* **g'** ➔ **ğ** (строчная) / **Ğ** (заглавная) — `U+011F` / `U+011E`
* **sh** ➔ **ş** (строчная) / **Ş** (заглавная) — `U+015F` / `U+015E`
* **ch** ➔ **ç** (строчная) / **Ç** (заглавная) — `U+00E7` / `U+00C7`
* **'** ➔ **ʻ** (официальный узбекский апостроф/тутук белгиси) — `U+02BB`

Данный проект предоставляет нативную раскладку клавиатуры Linux (XKB) и инструмент управления для быстрого и удобного набора этих букв.

---

## 🚀 Установка

### Способ 1: Пользовательская установка (Без sudo) — Рекомендуется
```bash
cd new_uzb_keyboard_for_linux
./setup.sh
```

### Способ 2: Общесистемная установка (Для всех пользователей)
```bash
sudo ./install.sh
```

---

## ⌨️ Как Использовать?

1. Переключите раскладку на узбекскую с помощью клавиш **`Super (Win) + Space (Пробел)`**.
2. В системном трее появится индикатор **`uz`**.
3. Набирайте символы согласно таблице:

### Таблица Сочетаний Клавиш (Shift Режим — По Умолчанию):

| Символ | Сочетание клавиш | Обычная заглавная | Заглавная новая буква |
|:---:|:---:|:---:|:---:|
| **ö** | `Shift + o` | `Правый Alt + o` ➔ **O** | `Правый Alt + Shift + o` ➔ **Ö** |
| **ğ** | `Shift + g` | `Правый Alt + g` ➔ **G** | `Правый Alt + Shift + g` ➔ **Ğ** |
| **ş** | `Shift + s` | `Правый Alt + s` ➔ **S** | `Правый Alt + Shift + s` ➔ **Ş** |
| **ç** | `Shift + c` | `Правый Alt + c` ➔ **C** | `Правый Alt + Shift + c` ➔ **Ç** |
| **ʻ** (апостроф) | `Правый Alt + '` | `Правый Alt + Shift + '` ➔ **ʼ** | — |

---

## 🔄 Управление Режимами (`uzkey.py`)

```bash
# Переключение на режим AltGr (Shift+o = O, Правый Alt+o = ö)
python3 uzkey.py switch altgr

# Возврат в режим Shift (Shift+o = ö)
python3 uzkey.py switch shift

# Режим Turkish Q ([ = ğ, ] = ö, ; = ş, ' = ç)
python3 uzkey.py switch turkish

# Проверка текущего статуса
python3 uzkey.py status

# Интерактивное тестирование ввода
python3 uzkey.py test
```

---

## 🛡 Безопасность и Конфиденциальность
* **Никаких кейлоггеров:** Программа не запускает фоновых процессов или демонов для перехвата клавиш.
* **Нативный уровень XKB:** Все комбинации обрабатываются напрямую ядром и дисплейным сервером Wayland/X11.
* **100% Открытый исходный код:** Простые, прозрачные и безопасные скрипты без сторонних зависимостей.

---

## 🗑 Удаление
```bash
./uninstall.sh
```
