<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=700&size=24&pause=1000&color=9B59B6&center=true&vCenter=true&width=600&lines=DevCulture+Ijin;License+%26+Permission+System;IP+Based+Authorization" alt="Typing SVG" />

<br/>

[![Part of DevCulture](https://img.shields.io/badge/ecosystem-DevCulture-9b59b6?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/tuyulbodo99)
[![Type](https://img.shields.io/badge/type-license--system-1a1a2e?style=for-the-badge&logo=shield&logoColor=white)](https://github.com/tuyulbodo99/ijin)
[![Access](https://img.shields.io/badge/access-admin--only-6c3483?style=for-the-badge)](https://github.com/tuyulbodo99/ijin)

</div>

---

## ⚡ Admin — Kelola Ijin Satu Perintah

> **Khusus Admin DevCulture**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh)
```

**Menu yang tersedia:**
```
[1] Lihat semua ijin aktif
[2] Tambah ijin VPS baru
[3] Perpanjang ijin VPS
[4] Hapus ijin VPS
[5] Cek status satu IP
```

**Atau langsung via argumen:**
```bash
# Lihat semua ijin
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh) list

# Cek status IP tertentu
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh) check

# Tambah ijin baru
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh) add
```

---

## 🟣 Overview

**DevCulture Ijin** adalah sistem lisensi dan perizinan berbasis IP untuk seluruh ekosistem DevCulture. Setiap script DevCulture memvalidasi IP VPS ke database ini sebelum instalasi diizinkan.

> 🔒 **Repo ini dikelola langsung oleh admin DevCulture**

---

## 🌐 Ekosistem DevCulture

| Repo | Fungsi | One-Click Install |
|------|--------|-------------------|
| [`devculture-vps`](https://github.com/tuyulbodo99/devculture-vps) | 🏠 Core installer | `bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/devculture-vps/main/install.sh)` |
| [`hokagescript`](https://github.com/tuyulbodo99/hokagescript) | ⚙️ Menu scripts | `bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/hokagescript/main/setup.sh)` |
| [`vpnscript`](https://github.com/tuyulbodo99/vpnscript) | 🔒 VPN installer | `bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/vpnscript/main/premi.sh)` |
| [`vps-script`](https://github.com/tuyulbodo99/vps-script) | 🔧 SSH tunnel | lihat README vps-script |
| **[`ijin`](https://github.com/tuyulbodo99/ijin)** | 🛡️ **License system** ← ini | `bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh)` |

---

## 🛡️ Cara Kerja

```
VPS (IP Publik)
      │
      ▼
Script cek IP → database youtube
      │
      ├── IP terdaftar & belum expired → ✅ Permission Accepted
      └── IP tidak terdaftar / expired → ❌ Permission Denied
```

---

## 📄 Format Database (`youtube`)

```
## NAMA-TAHUN EXP-BULAN EXP-TGL EXP.

### NamaUser YYYY-MM-DD IP.VPS.ANDA ON
```

| Field | Keterangan |
|-------|------------|
| `NamaUser` | Nama/label pelanggan |
| `YYYY-MM-DD` | Tanggal kadaluarsa lisensi |
| `IP.VPS` | IP publik VPS yang diizinkan |
| `ON` | Status aktif |

---

## 🔗 URL Database

```bash
# Database utama (digunakan semua script):
https://raw.githubusercontent.com/tuyulbodo99/ijin/main/youtube

# Database alpha (detail order):
https://raw.githubusercontent.com/tuyulbodo99/ijin/main/alpha
```

---

## 🔄 Sync Otomatis ke Semua VPS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/devculture-vps/main/sync.sh)
```

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Order%20%26%20Registrasi-@devculturebot-9b59b6?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/devculturebot)
[![GitHub](https://img.shields.io/badge/GitHub-tuyulbodo99-1a1a2e?style=for-the-badge&logo=github&logoColor=white)](https://github.com/tuyulbodo99)

<sub>© 2024 DevCulture VPS Store · <a href="https://github.com/tuyulbodo99">tuyulbodo99</a></sub>

</div>
