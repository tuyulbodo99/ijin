<div align="center">

<img src="https://raw.githubusercontent.com/tuyulbodo99/devculture-vps/main/assets/cyberpunk-typing.png" width="100%" alt="DevCulture Ijin - Cyberpunk" />

<br/>

[![Typing SVG](https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=700&size=28&pause=1000&color=A855F7&center=true&vCenter=true&width=600&lines=DevCulture+Ijin+System;VPS+License+%26+Permission;Admin+Terminal+Tool;Auto+Push+to+GitHub)](https://git.io/typing-svg)

<br/>

![GitHub Stars](https://img.shields.io/github/stars/tuyulbodo99/ijin?style=for-the-badge&color=a855f7&labelColor=0d0d0d)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%2022.04-a855f7?style=for-the-badge&logo=ubuntu&logoColor=white&labelColor=0d0d0d)
![Shell](https://img.shields.io/badge/Shell-Bash%205-7c3aed?style=for-the-badge&logo=gnubash&logoColor=white&labelColor=0d0d0d)

</div>

---

<div align="center">

### 🔑 Sistem Lisensi & Perizinan VPS

Sistem kontrol akses berbasis GitHub — VPS yang terdaftar bisa menjalankan script DevCulture, yang tidak terdaftar otomatis ditolak.

</div>

---

## 📦 Fitur

<table>
<tr>
<td width="50%">

**🔐 Manajemen Lisensi**
- Tambah IP VPS baru
- Hapus lisensi VPS
- Perpanjang masa aktif
- Cek status lisensi
- List semua VPS terdaftar

</td>
<td width="50%">

**⚡ Otomasi**
- Auto-push ke GitHub setelah perubahan
- Sinkronisasi real-time ke semua VPS
- Validasi format IP otomatis
- Log perubahan tercatat

</td>
</tr>
</table>

---

## 🛠️ Perintah Admin

### Install Tool Admin
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tuyulbodo99/ijin/main/check-ijin.sh)
```

### List Semua VPS Terdaftar
```bash
bash check-ijin.sh list
```

### Tambah Lisensi VPS Baru
```bash
bash check-ijin.sh add [nama] [ip] [tanggal-expired]
# Contoh:
bash check-ijin.sh add warnet1 103.10.10.1 2025-12-31
```

### Hapus Lisensi VPS
```bash
bash check-ijin.sh remove [nama]
```

### Perpanjang Lisensi
```bash
bash check-ijin.sh extend [nama] [hari]
# Contoh: perpanjang 30 hari
bash check-ijin.sh extend warnet1 30
```

### Cek Status Satu VPS
```bash
bash check-ijin.sh check [ip]
```

---

## 📋 Format Database Lisensi

File `youtube` di repo ini menggunakan format:
```
### [nama] [tanggal-expired] [keterangan] [ip-vps]
```

Contoh:
```
### warnet1 2025-12-31 aktif 103.10.10.1
### vpsStore2 2025-06-30 aktif 103.20.20.2
```

---

## 🔒 Cara Kerja Sistem Ijin

```
VPS baru install script
        ↓
Ambil IP publik VPS (ipv4.icanhazip.com)
        ↓
Cek IP di github.com/tuyulbodo99/ijin/youtube
        ↓
IP terdaftar + belum expired → ✅ Permission Accepted
IP tidak ditemukan           → ❌ Permission Denied!
IP expired                   → ❌ Expired
```

---

## 🌐 Ekosistem DevCulture

| Repository | Fungsi |
|------------|--------|
| 🟣 [devculture-vps](https://github.com/tuyulbodo99/devculture-vps) | Core Panel + SSH + WebSocket |
| 🟣 [hokagescript](https://github.com/tuyulbodo99/hokagescript) | Menu Layanan & Services |
| 🟣 [vpnscript](https://github.com/tuyulbodo99/vpnscript) | Full VPN Installer |
| 🟣 [vps-script](https://github.com/tuyulbodo99/vps-script) | SSH Tunnel Setup |
| 🟣 [ijin](https://github.com/tuyulbodo99/ijin) | Sistem Lisensi & Perizinan |

---

<div align="center">

> ⚠️ **Khusus Admin DevCulture** — Akses repo ini dibatasi untuk pengelola script.

**DevCulture VPS Store** · [github.com/tuyulbodo99](https://github.com/tuyulbodo99) · [@devculturebot](https://t.me/devculturebot)

![Footer](https://capsule-render.vercel.app/api?type=waving&color=a855f7&height=80&section=footer)

</div>
