# 🇺🇿 O'zbek Tili Yangi Lotin Alifbosi Klaviaturasi (Uzbek New Latin Keyboard Layout)

[![Linux](https://img.shields.io/badge/Platform-Linux%20%7C%20Ubuntu-orange.svg)](https://ubuntu.com)
[![XKB](https://img.shields.io/badge/Layout-XKB%20Native-blue.svg)](https://www.x.org/wiki/XKB/)
[![Wayland / X11](https://img.shields.io/badge/Display-Wayland%20%2F%20X11-green.svg)](https://wayland.freedesktop.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3](https://img.shields.io/badge/Python-3.8+-brightgreen.svg)](https://python.org)

O'zbek tilining yangilangan lotin alifbosidagi yangi harflarni (**ö, ğ, ş, ç** va tutuq belgisi **ʻ**) oddiy kompyuter klaviaturasida oson, tez va qulay yozish uchun maxsus klaviatura maketi va boshqaruv dasturi.

---

## 📌 Yangi Alifbodagi O'zgarishlar

| Eski yozuv | Yangi harf (kichik) | Yangi harf (katta) | Unicode kodi |
|:----------:|:-------------------:|:------------------:|:------------:|
| **o'**     | **ö**               | **Ö**              | `U+00F6` / `U+00D6` |
| **g'**     | **ğ**               | **Ğ**              | `U+011F` / `U+011E` |
| **sh**     | **ş**               | **Ş**              | `U+015F` / `U+015E` |
| **ch**     | **ç**               | **Ç**              | `U+00E7` / `U+00C7` |
| **'**      | **ʻ** (tutuq)       | **ʼ**              | `U+02BB` / `U+02BC` |

---

## ⚡ Mavjud Rejimlar (Modes)

Dastur sizning xohishingizga ko'ra **3 xil rejimda** ishlay oladi:

### 1️⃣ Shift Rejimi (Standart sozlama)
Klaviaturadagi eng tezkor usul:
* `Shift + o` ➔ **ö**
* `Shift + g` ➔ **ğ**
* `Shift + s` ➔ **ş**
* `Shift + c` ➔ **ç**

> **Katta harflar qanday yoziladi?**
> * `O'ng Alt + o` ➔ **O** | `O'ng Alt + Shift + o` ➔ **Ö**
> * `O'ng Alt + g` ➔ **G** | `O'ng Alt + Shift + g` ➔ **Ğ**
> * `O'ng Alt + s` ➔ **S** | `O'ng Alt + Shift + s` ➔ **Ş**
> * `O'ng Alt + c` ➔ **C** | `O'ng Alt + Shift + c` ➔ **Ç**
> * `O'ng Alt + '` ➔ **ʻ** (To'g'ri o'zbek tutuq belgisi)

---

### 2️⃣ AltGr Rejimi (Xalqaro standart)
Oddiy katta **O, G, S, C** harflarini o'zgartirmasdan, qo'shimcha harflarni o'ng Alt (`AltGr`) orqali yozish:
* `O'ng Alt + o` ➔ **ö** | `O'ng Alt + Shift + o` ➔ **Ö**
* `O'ng Alt + g` ➔ **ğ** | `O'ng Alt + Shift + g` ➔ **Ğ**
* `O'ng Alt + s` ➔ **ş** | `O'ng Alt + Shift + s` ➔ **Ş**
* `O'ng Alt + c` ➔ **ç** | `O'ng Alt + Shift + c` ➔ **Ç**
* `O'ng Alt + '` ➔ **ʻ**

---

### 3️⃣ Turkish Q Rejimi (Maxsus tugmalar)
Qavslar va tinish belgilari o'rnida yangi harflar joylashadi:
* `[` ➔ **ğ** | `{` ➔ **Ğ**
* `]` ➔ **ö** | `}` ➔ **Ö**
* `;` ➔ **ş** | `:` ➔ **Ş**
* `'` ➔ **ç** | `"` ➔ **Ç**

---

## 🚀 O'rnatish (Installation)

### 1-usul: Foydalanuvchi darajasida (Sudo / Parol talab qilinmaydi!) - TAVSIYA ETILADI
Terminalda quyidagi bitta buyruqni bering:

```bash
./setup.sh
```

Yoki AltGr rejimida o'rnatish uchun:
```bash
./setup.sh altgr
```

### 2-usul: Butun tizim (System-wide) uchun o'rnatish
```bash
sudo ./install.sh
```

---

## ⌨️ Qanday Ishlatiladi?

1. O'rnatgandan so'ng klaviatura tilini almashtirish uchun:
   **`Super (Windows tugmasi) + Space (Bo'sh joy)`** tugmalarini bosing.
2. Yuqori o'ng burchakda **`uz`** tili paydo bo'ladi.
3. Yangi harflarni xohlagan dasturda (Brauzer, Telegram, VS Code, Word, Terminal va boshqalar) bemalol yozaverasiz!

---

## 🛠 `uzkey.py` Boshqaruv Dasturi

Dasturda qulay CLI boshqaruv vositasi mavjud:

```bash
# Holatni tekshirish
python3 uzkey.py status

# Rejimni o'zgartirish (shift, altgr yoki turkish)
python3 uzkey.py switch altgr
python3 uzkey.py switch shift

# Jonli yozib sinab ko'rish (Test rejimi)
python3 uzkey.py test

# Tugmalar xaritasini ko'rish
python3 uzkey.py info
```

---

## 🧪 Testlarni Ishga Tushirish

Klaviaturaning to'g'ri sozlanganligi va kompilatsiyasini tekshirish:

```bash
python3 tests/test_layouts.py
```

---

## 📦 GitHub-ga Yuklash (Publish to GitHub)

Ushbu loyihani o'zingizning GitHub profilingizga joylash uchun:

1. [GitHub.com](https://github.com) saytiga kiring va yangi repository oching (masalan, `uzbek-latin-keyboard`).
2. Terminalda quyidagi buyruqlarni bajaring:

```bash
cd "uzbek-latin-keyboard"

# O'z GitHub manzilingizni qo'shing:
git remote add origin https://github.com/USERNAME/uzbek-latin-keyboard.git

# GitHub-ga yuklash:
git push -u origin main
```

*(USERNAME o'rniga o'z GitHub foydalanuvchi nomingizni yozing).*

---

## 🗑 O'chirish (Uninstall)

Klaviaturani tizimdan butunlay olib tashlash:

```bash
./uninstall.sh
```

---

## 📄 Litsenziya

Ushbu loyiha [MIT Litsenziyasi](LICENSE) asosida ochiq manbali tarzda tarqatiladi.
