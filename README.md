# 🇺🇿 O'zbek Tili Yangi Lotin Alifbosi Klaviaturasi (`new_uzb_keyboard_for_linux`)

[![Linux](https://img.shields.io/badge/Platform-Linux%20%7C%20Ubuntu-orange.svg)](https://ubuntu.com)
[![XKB](https://img.shields.io/badge/Layout-XKB%20Native-blue.svg)](https://www.x.org/wiki/XKB/)
[![Wayland / X11](https://img.shields.io/badge/Display-Wayland%20%2F%20X11-green.svg)](https://wayland.freedesktop.org/)
[![Security: Audited](https://img.shields.io/badge/Security-Safe%20%26%20Keylogger--Free-success.svg)](#-xavfsizlik-va-maxfiylik)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3](https://img.shields.io/badge/Python-3.8+-brightgreen.svg)](https://python.org)

O'zbek tilining yangilangan lotin alifbosidagi yangi harflarni (**ö, ğ, ş, ç** va tutuq belgisi **ʻ**) oddiy kompyuter klaviaturasida oson, tez va xavfsiz yozish uchun maxsus klaviatura maketi va boshqaruv dasturi.

> 📖 **To'liq foydalanish qo'llanmasi (3 tilda): [FOYDALANISH.md](FOYDALANISH.md)**  
> *(O'zbekcha, English, Русский)*

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

## ⚡ Asosiy Rejim (Variant A - Qavslar va tinish belgilari o'rnida)

Dunyoda va turkiy tilli davlatlarda (Turkiya, Ozarbayjon) eng keng tarqalgan va qulay usul:
Klaviaturadagi kam ishlatiladigan tugmalar yangi harflarga ajratilgan:

| Klaviaturadagi Tugma | Bosganda (Kichik) | Shift bilan (Katta) | AltGr bilan (Original belgi) |
|:---:|:---:|:---:|:---:|
| **`[`** (P harfi o'ngida) | **ğ** | **Ğ** | `[` &nbsp; (Shift bilan: `{`) |
| **`]`** (Qavs yopish) | **ö** | **Ö** | `]` &nbsp; (Shift bilan: `}`) |
| **`;`** (L harfi o'ngida) | **ş** | **Ş** | `;` &nbsp; (Shift bilan: `:`) |
| **`'`** (Apostrof) | **ç** | **Ç** | `'` &nbsp; (Shift bilan: `"`) |
| **`~`** (Tilda / Esc ostida) | `` ` `` | `~` | **ʻ** (O'zbek tutuq belgisi, `U+02BB`) |

### Nega bu usul eng qulay?
1. **Bitta tugma:** Yangi harf yozish uchun hech qanday 2 ta tugmani baravar bosish shart emas.
2. **Katta harflar buzilmaydi:** `Shift + o` oddiy katta **O**, `Shift + g` katta **G** bo'lib qoladi.
3. **Inglizcha QWERTY to'liq saqlanadi:** Barcha asosiy harflar (a-z, A-Z) va raqamlar (0-9) o'z joyida.

---

## 🚀 O'rnatish (Installation)

### 1-usul: Sudo-siz tezkor o'rnatish (Tavsiya etiladi)
```bash
git clone https://github.com/Azizbek6002/new_uzb_keyboard_for_linux.git
cd new_uzb_keyboard_for_linux
./setup.sh
```

### 2-usul: Butun tizim uchun o'rnatish
```bash
sudo ./install.sh
```

---

## ⌨️ Qanday Ishlatiladi?

O'rnatgandan so'ng klaviatura avtomatik faollashadi. Tilni almashtirish uchun:
**`Super (Windows tugmasi) + Space (Probel)`** tugmalarini bosing.

---

## 🛡 Xavfsizlik va Maxfiylik

1. **0% Keylogger xavfi:** Hech qanday klaviatura tinglovchi fon jarayoni (daemon) ishlamaydi.
2. **Linux Native XKB:** Linux yadrosi va GNOME/Wayland serverining rasmiy xavfsiz standartida ishlaydi.
3. **100% Shaffof Kod:** To'liq ochiq manbali va tekshirish oson.

---

## 🛠 `uzkey.py` Boshqaruv Dasturi

```bash
# Holatni tekshirish
python3 uzkey.py status

# Jonli sinab ko'rish
python3 uzkey.py test

# Tugmalar xaritasini ko'rish
python3 uzkey.py info

# Agar kelgusida boshqa rejimga o'tmoqchi bo'lsangiz:
python3 uzkey.py switch a       # Asosiy Variant A ([ = ğ, ] = ö, ; = ş, ' = ç)
python3 uzkey.py switch altgr   # AltGr rejimi (AltGr + o = ö)
python3 uzkey.py switch shift   # Shift rejimi
```

---

## 📄 Litsenziya
[MIT Litsenziyasi](LICENSE) asosida ochiq tarqatiladi.
