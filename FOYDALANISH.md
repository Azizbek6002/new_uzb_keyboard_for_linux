# 📖 Foydalanish Qo'llanmasi / User Guide / Руководство пользователя

> **O'zbek tili yangi alifbosi klaviaturasi (Linux / Ubuntu)**  
> Variant A (Asosiy tartib) bo'yicha to'liq qo'llanma.
> 
> 🌐 **Mundarija / Table of Contents / Оглавление:**
> 1. [🇺🇿 O'zbek tili (Qo'llanma)](#1-ozbek-tili-qollanma)
> 2. [🇬🇧 English (User Guide)](#2-english-user-guide)
> 3. [🇷🇺 Русский язык (Руководство)](#3-русский-язык-руководство)

---

# 1. 🇺🇿 O'zbek tili (Qo'llanma)

## 📌 Umumiy Ma'lumot
O'zbek tilining yangi lotin alifbosidagi harflarni oddiy QWERTY klaviaturasida eng tez va qulay yozish uchun **Variant A** (kam ishlatiladigan to'rtburchak qavslar va tinish belgilari o'rniga yangi harflarni joylash) tanlandi:

* **[** tugmasi ➔ **ğ** (kichik)  |  **Shift + [** ➔ **Ğ** (katta)
* **]** tugmasi ➔ **ö** (kichik)  |  **Shift + ]** ➔ **Ö** (katta)
* **;** tugmasi ➔ **ş** (kichik)  |  **Shift + ;** ➔ **Ş** (katta)
* **'** tugmasi ➔ **ç** (kichik)  |  **Shift + '** ➔ **Ç** (katta)
* **AltGr + ~** ➔ **ʻ** (O'zbek tutuq belgisi, `U+02BB`)

---

## ⌨️ Tugmalar Jadvali (Variant A):

| Klaviaturadagi Tugma | Oddiy bosganda | Shift bilan | AltGr (O'ng Alt) bilan |
|:---:|:---:|:---:|:---:|
| **`[`** (P harfining o'ngida) | **ğ** | **Ğ** | `[` &nbsp; (Shift bilan: `{`) |
| **`]`** (Qavs yopish) | **ö** | **Ö** | `]` &nbsp; (Shift bilan: `}`) |
| **`;`** (L harfining o'ngida) | **ş** | **Ş** | `;` &nbsp; (Shift bilan: `:`) |
| **`'`** (Apostrof) | **ç** | **Ç** | `'` &nbsp; (Shift bilan: `"`) |
| **`~`** (Tilda) | `` ` `` | `~` | **ʻ** (O'zbek tutuq belgisi) |

> **Muhim afzalliklari:**
> 1. Oddiy **O, G, S, C** harflarini yozish hech qachon buzilmaydi (`Shift + o` = **O**).
> 2. Yangi harflar uchun bittagina tugmani bosish kifoya (qo'shimcha kombinatsiya shart emas).
> 3. Dasturchilar uchun original belgilar (`[`, `]`, `;`, `'`) O'ng Alt (`AltGr`) orqali saqlab qolingan.

---

## 🚀 O'rnatish
```bash
./setup.sh
```
O'rnatilgach, klaviatura avtomatik ravishda birlamchi til qilib ulanadi.

---

## 🔄 Boshqa Rejimlar (`uzkey.py`)
```bash
python3 uzkey.py status       # Holatni tekshirish
python3 uzkey.py test         # Jonli yozib ko'rish
python3 uzkey.py switch a     # Asosiy A-Variant
python3 uzkey.py switch altgr # AltGr rejimi
```

---
---

# 2. 🇬🇧 English (User Guide)

## 📌 Overview
This project provides a native Linux keyboard layout (XKB) for typing the newly reformed Uzbek Latin alphabet characters (**ö, ğ, ş, ç, ʻ**) using **Variant A** (dedicated keys at brackets and punctuation):

* **[** key ➔ **ğ**  |  **Shift + [** ➔ **Ğ**
* **]** key ➔ **ö**  |  **Shift + ]** ➔ **Ö**
* **;** key ➔ **ş**  |  **Shift + ;** ➔ **Ş**
* **'** key ➔ **ç**  |  **Shift + '** ➔ **Ç**
* **AltGr + ~** ➔ **ʻ** (Official Uzbek apostrophe modifier)

---

## ⌨️ Keymap Table (Variant A):

| Physical Key | Normal Press | With Shift | With AltGr (Original) |
|:---:|:---:|:---:|:---:|
| **`[`** (Next to P) | **ğ** | **Ğ** | `[` &nbsp; (`{` with Shift) |
| **`]`** (Bracket right) | **ö** | **Ö** | `]` &nbsp; (`}` with Shift) |
| **`;`** (Next to L) | **ş** | **Ş** | `;` &nbsp; (`:` with Shift) |
| **`'`** (Quote) | **ç** | **Ç** | `'` &nbsp; (`"` with Shift) |
| **`~`** (Tilde) | `` ` `` | `~` | **ʻ** (Uzbek apostrophe) |

---

## 🚀 Installation
```bash
./setup.sh
```

---
---

# 3. 🇷🇺 Русский язык (Руководство пользователя)

## 📌 Общие Сведения
Раскладка для набора новых букв узбекского латинского алфавита (**ö, ğ, ş, ç, ʻ**) по схеме **Вариант А** (клавиши скобок и знаков препинания):

* **[** клавиша ➔ **ğ**  |  **Shift + [** ➔ **Ğ**
* **]** клавиша ➔ **ö**  |  **Shift + ]** ➔ **Ö**
* **;** клавиша ➔ **ş**  |  **Shift + ;** ➔ **Ş**
* **'** клавиша ➔ **ç**  |  **Shift + '** ➔ **Ç**
* **AltGr + ~** ➔ **ʻ** (Узбекский апостроф)

---

## ⌨️ Таблица Клавиш (Вариант А):

| Физическая клавиша | Обычное нажатие | С Shift | С AltGr (Исходный) |
|:---:|:---:|:---:|:---:|
| **`[`** (Справа от P) | **ğ** | **Ğ** | `[` &nbsp; (`{` с Shift) |
| **`]`** (Закрывающая скобка) | **ö** | **Ö** | `]` &nbsp; (`}` с Shift) |
| **`;`** (Справа от L) | **ş** | **Ş** | `;` &nbsp; (`:` с Shift) |
| **`'`** (Апостроф) | **ç** | **Ç** | `'` &nbsp; (`"` с Shift) |
| **`~`** (Тильда) | `` ` `` | `~` | **ʻ** (Узбекский апостроф) |

---

## 🚀 Установка
```bash
./setup.sh
```
