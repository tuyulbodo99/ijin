<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=700&size=24&pause=1000&color=9B59B6&center=true&vCenter=true&width=600&lines=DevCulture+Ijin;License+%26+Permission+System;IP+Based+Authorization" alt="Typing SVG" />

<br/>

[![Part of DevCulture](https://img.shields.io/badge/ecosystem-DevCulture-9b59b6?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/tuyulbodo99)
[![Type](https://img.shields.io/badge/type-license--system-1a1a2e?style=for-the-badge&logo=shield&logoColor=white)](https://github.com/tuyulbodo99/ijin)
[![Access](https://img.shields.io/badge/access-admin--only-6c3483?style=for-the-badge)](https://github.com/tuyulbodo99/ijin)

</div>

---

## 🟣 Overview

**DevCulture Ijin** adalah sistem lisensi dan perizinan berbasis IP untuk seluruh ekosistem DevCulture. Setiap script DevCulture memvalidasi IP VPS ke database ini sebelum instalasi diizinkan.

> 🔒 **Repo ini dikelola langsung oleh admin DevCulture**

---

## 🌐 Ekosistem DevCulture

| Repo | Fungsi |
|------|--------|
| [`devculture-vps`](https://github.com/tuyulbodo99/devculture-vps) | 🏠 Core installer & panel |
| [`hokagescript`](https://github.com/tuyulbodo99/hokagescript) | ⚙️ Menu & service scripts |
| [`vpnscript`](https://github.com/tuyulbodo99/vpnscript) | 🔒 VPN installer |
| [`vps-script`](https://github.com/tuyulbodo99/vps-script) | 🔧 SSH tunnel |
| **[`ijin`](https://github.com/tuyulbodo99/ijin)** | 🛡️ **License system** ← Anda di sini |

---

## 🛡️ Cara Kerja

```
VPS (IP Publik)
      │
      ▼
Script cek IP ke database youtube/alpha
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

**Contoh:**
```
### DevCultureLocal 2025-12-30 192.168.1.100 ON
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
# Database utama (digunakan oleh semua script):
https://raw.githubusercontent.com/tuyulbodo99/ijin/main/youtube

# Database alpha (detail order):
https://raw.githubusercontent.com/tuyulbodo99/ijin/main/alpha
```

---

## 🔄 Sinkronisasi Otomatis

Database ijin disinkronkan otomatis ke semua VPS terdaftar via:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/devculture-vps/main/sync.sh)
```

---

## 📞 Registrasi

Untuk mendaftarkan VPS Anda ke sistem ijin DevCulture:

<div align="center">

[![Telegram](https://img.shields.io/badge/Order%20%26%20Registrasi-@devculturebot-9b59b6?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/devculturebot)
[![GitHub](https://img.shields.io/badge/GitHub-tuyulbodo99-1a1a2e?style=for-the-badge&logo=github&logoColor=white)](https://github.com/tuyulbodo99)

<sub>© 2024 DevCulture VPS Store · <a href="https://github.com/tuyulbodo99">tuyulbodo99</a></sub>

</div>
