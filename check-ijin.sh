#!/bin/bash
# =================================================================
#   DevCulture — Admin Ijin Manager v1.0.0
#   Kelola database ijin VPS langsung dari terminal
#   github.com/tuyulbodo99/ijin | @devculturebot
# =================================================================
set -euo pipefail

RESET="\033[0m"; BOLD="\033[1m"; DIM="\033[2m"
BCYAN="\033[1;36m"; BGREEN="\033[1;32m"; BYELLOW="\033[1;33m"
BRED="\033[1;31m"; BPURPLE="\033[1;35m"; BWHITE="\033[1;37m"

IJIN_VERSION="1.0.0"
REPO_OWNER="tuyulbodo99"
REPO_NAME="ijin"
DB_FILE="youtube"
ALPHA_FILE="alpha"
API_BASE="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents"
RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/main"
TOKEN=""

info()    { echo -e "  ${BCYAN}[INFO]${RESET}  $*"; }
success() { echo -e "  ${BGREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "  ${BYELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "  ${BRED}[ERR]${RESET}   $*"; exit 1; }
sep()     { echo -e "  ${BPURPLE}────────────────────────────────────────────${RESET}"; }

banner() {
  clear
  echo -e "${BPURPLE}"
  echo "   ██████╗ ███████╗██╗   ██╗ ██████╗██╗   ██╗██╗  ████████╗██╗   ██╗██████╗ ███████╗"
  echo "   ██╔══██╗██╔════╝██║   ██║██╔════╝██║   ██║██║  ╚══██╔══╝██║   ██║██╔══██╗██╔════╝"
  echo "   ██║  ██║█████╗  ██║   ██║██║     ██║   ██║██║     ██║   ██║   ██║██████╔╝█████╗  "
  echo "   ██║  ██║██╔══╝  ╚██╗ ██╔╝██║     ██║   ██║██║     ██║   ██║   ██║██╔══██╗██╔══╝  "
  echo "   ██████╔╝███████╗ ╚████╔╝ ╚██████╗╚██████╔╝███████╗██║   ╚██████╔╝██║  ██║███████╗"
  echo "   ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚══════╝╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝"
  echo -e "${RESET}"
  echo -e "   ${BPURPLE}${BOLD}Admin Ijin Manager  v${IJIN_VERSION}${RESET}  ${DIM}│  ${REPO_OWNER}/${REPO_NAME}${RESET}"
  echo ""
}

# ── Load token dari env atau minta input ─────────────────────────
load_token() {
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    TOKEN="$GITHUB_TOKEN"
  elif [[ -n "${GITHUB_PERSONAL_ACCESS_TOKEN:-}" ]]; then
    TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN"
  elif [[ -f "$HOME/.dc-admin-token" ]]; then
    TOKEN=$(cat "$HOME/.dc-admin-token")
  else
    echo -e "  ${BYELLOW}GitHub Token diperlukan untuk menulis ke repo.${RESET}"
    read -rsp "  Masukkan GitHub Token (tersimpan lokal): " TOKEN
    echo ""
    echo "$TOKEN" > "$HOME/.dc-admin-token"
    chmod 600 "$HOME/.dc-admin-token"
    success "Token tersimpan di $HOME/.dc-admin-token"
  fi
  [[ -z "$TOKEN" ]] && error "Token tidak boleh kosong!"
}

# ── Ambil konten file dari GitHub ────────────────────────────────
get_file() {
  local file="$1"
  curl -fsSL "${RAW_BASE}/${file}?$(date +%s)" 2>/dev/null || echo ""
}

# ── Ambil SHA file dari GitHub API ───────────────────────────────
get_sha() {
  local file="$1"
  curl -s -H "Authorization: token ${TOKEN}" \
    "${API_BASE}/${file}" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null || echo ""
}

# ── Upload file ke GitHub ─────────────────────────────────────────
push_file() {
  local file="$1" content="$2" msg="$3"
  local sha; sha=$(get_sha "$file")
  local b64; b64=$(echo "$content" | base64 -w 0)
  local payload
  if [[ -n "$sha" ]]; then
    payload="{\"message\":\"$msg\",\"content\":\"$b64\",\"sha\":\"$sha\"}"
  else
    payload="{\"message\":\"$msg\",\"content\":\"$b64\"}"
  fi
  local result; result=$(curl -s -X PUT \
    -H "Authorization: token ${TOKEN}" \
    -H "Content-Type: application/json" \
    "${API_BASE}/${file}" -d "$payload")
  echo "$result" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('commit',{}).get('sha','ERROR: '+str(d.get('message',''))))" 2>/dev/null || echo "ERROR"
}

# ── Lihat semua ijin aktif ────────────────────────────────────────
cmd_list() {
  banner
  echo -e "  ${BPURPLE}┌─────────────────────────────────────────────────────────────────┐${RESET}"
  echo -e "  ${BPURPLE}│${RESET}  ${BOLD}${BWHITE}DATABASE IJIN AKTIF${RESET}  ${DIM}(${REPO_OWNER}/${REPO_NAME}/${DB_FILE})${RESET}           ${BPURPLE}│${RESET}"
  echo -e "  ${BPURPLE}├─────┬──────────────────────┬────────────┬───────────────┬───────┤${RESET}"
  printf "  ${BPURPLE}│${RESET} ${BOLD}%-3s${RESET} ${BPURPLE}│${RESET} ${BOLD}%-20s${RESET} ${BPURPLE}│${RESET} ${BOLD}%-10s${RESET} ${BPURPLE}│${RESET} ${BOLD}%-13s${RESET} ${BPURPLE}│${RESET} ${BOLD}%-5s${RESET} ${BPURPLE}│${RESET}\n" \
    "No" "Nama" "Exp Date" "IP VPS" "Status"
  echo -e "  ${BPURPLE}├─────┼──────────────────────┼────────────┼───────────────┼───────┤${RESET}"
  local DB; DB=$(get_file "$DB_FILE")
  local IDX=0
  local TODAY; TODAY=$(date '+%Y-%m-%d')
  while IFS= read -r line; do
    [[ "$line" =~ ^###[[:space:]] ]] || continue
    local parts; read -ra parts <<< "${line:4}"
    local nama="${parts[0]:-?}" exp="${parts[1]:-?}" ip="${parts[2]:-?}" status="${parts[3]:-?}"
    IDX=$((IDX + 1))
    local color="$BGREEN"
    local statuslabel="$status"
    if [[ "$exp" < "$TODAY" ]] 2>/dev/null; then
      color="$BRED"; statuslabel="EXPIRED"
    fi
    printf "  ${BPURPLE}│${RESET} ${DIM}%-3s${RESET} ${BPURPLE}│${RESET} ${color}%-20s${RESET} ${BPURPLE}│${RESET} ${color}%-10s${RESET} ${BPURPLE}│${RESET} %-13s ${BPURPLE}│${RESET} ${color}%-5s${RESET} ${BPURPLE}│${RESET}\n" \
      "$IDX" "$nama" "$exp" "$ip" "$statuslabel"
  done <<< "$DB"
  [[ $IDX -eq 0 ]] && echo -e "  ${BPURPLE}│${RESET}  ${DIM}  (Database kosong)${RESET}"
  echo -e "  ${BPURPLE}└─────┴──────────────────────┴────────────┴───────────────┴───────┘${RESET}"
  echo ""
  info "Total: ${BOLD}${IDX}${RESET} entri"
  echo ""
}

# ── Tambah ijin VPS ───────────────────────────────────────────────
cmd_add() {
  load_token
  banner
  sep; echo -e "  ${BOLD}TAMBAH IJIN VPS BARU${RESET}"; sep
  echo ""
  read -rp "  Nama pelanggan : " NAMA
  read -rp "  IP VPS         : " IP
  read -rp "  Tanggal exp    : " EXP
  echo ""
  [[ -z "$NAMA" || -z "$IP" || -z "$EXP" ]] && error "Semua field harus diisi!"
  if ! [[ "$EXP" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    error "Format tanggal salah. Gunakan YYYY-MM-DD (contoh: 2025-12-31)"
  fi
  local ENTRY="### ${NAMA} ${EXP} ${IP} ON"
  local DB_CURRENT; DB_CURRENT=$(get_file "$DB_FILE")
  # Cek duplikat IP
  if echo "$DB_CURRENT" | grep -q "$IP"; then
    warn "IP ${BWHITE}${IP}${RESET} sudah ada di database!"
    echo -e "  Entry yang ada: $(echo "$DB_CURRENT" | grep "$IP")"
    read -rp "  Tetap tambah? [y/N]: " CONF
    [[ "${CONF,,}" == "y" ]] || { info "Dibatalkan."; return; }
  fi
  local NEW_DB; NEW_DB="${DB_CURRENT}
${ENTRY}"
  info "Menambahkan: ${BWHITE}${ENTRY}${RESET}"
  local SHA; SHA=$(push_file "$DB_FILE" "$NEW_DB" "add: ijin ${NAMA} (${IP}) exp ${EXP}")
  if [[ "$SHA" != "ERROR"* ]]; then
    success "Berhasil ditambahkan! Commit: ${DIM}${SHA:0:12}${RESET}"
    # Update alpha juga
    local ALPHA_CURRENT; ALPHA_CURRENT=$(get_file "$ALPHA_FILE")
    local ALPHA_ENTRY="### ${NAMA} ${EXP} ORDER-$(date +%s) ${IP} ON"
    local NEW_ALPHA="${ALPHA_CURRENT}
${ALPHA_ENTRY}"
    push_file "$ALPHA_FILE" "$NEW_ALPHA" "add: alpha record ${NAMA}" >/dev/null
    success "Alpha database diperbarui"
  else
    error "Gagal menambahkan: $SHA"
  fi
  echo ""
}

# ── Hapus ijin VPS ────────────────────────────────────────────────
cmd_remove() {
  load_token
  cmd_list
  sep; echo -e "  ${BOLD}HAPUS IJIN VPS${RESET}"; sep
  echo ""
  read -rp "  Masukkan IP atau Nama yang akan dihapus: " TARGET
  [[ -z "$TARGET" ]] && { info "Dibatalkan."; return; }
  local DB_CURRENT; DB_CURRENT=$(get_file "$DB_FILE")
  if ! echo "$DB_CURRENT" | grep -q "$TARGET"; then
    error "Entri '${TARGET}' tidak ditemukan di database!"
  fi
  echo -e "  ${BRED}Akan dihapus:${RESET}"
  echo "$DB_CURRENT" | grep "$TARGET" | while read -r L; do echo -e "    ${DIM}$L${RESET}"; done
  echo ""
  read -rp "  Konfirmasi hapus? [y/N]: " CONF
  [[ "${CONF,,}" == "y" ]] || { info "Dibatalkan."; return; }
  local NEW_DB; NEW_DB=$(echo "$DB_CURRENT" | grep -v "$TARGET")
  local SHA; SHA=$(push_file "$DB_FILE" "$NEW_DB" "remove: ijin ${TARGET}")
  if [[ "$SHA" != "ERROR"* ]]; then
    success "Berhasil dihapus! Commit: ${DIM}${SHA:0:12}${RESET}"
  else
    error "Gagal menghapus: $SHA"
  fi
  echo ""
}

# ── Perpanjang ijin VPS ───────────────────────────────────────────
cmd_extend() {
  load_token
  cmd_list
  sep; echo -e "  ${BOLD}PERPANJANG IJIN VPS${RESET}"; sep
  echo ""
  read -rp "  Masukkan IP VPS: " IP
  read -rp "  Tanggal exp baru (YYYY-MM-DD): " EXP_NEW
  [[ -z "$IP" || -z "$EXP_NEW" ]] && { info "Dibatalkan."; return; }
  if ! [[ "$EXP_NEW" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    error "Format tanggal salah. Gunakan YYYY-MM-DD"
  fi
  local DB_CURRENT; DB_CURRENT=$(get_file "$DB_FILE")
  if ! echo "$DB_CURRENT" | grep -q "$IP"; then
    error "IP '${IP}' tidak ditemukan di database!"
  fi
  local OLD_LINE; OLD_LINE=$(echo "$DB_CURRENT" | grep "$IP" | head -1)
  local NAMA; NAMA=$(echo "$OLD_LINE" | awk '{print $2}')
  local NEW_LINE; NEW_LINE=$(echo "$OLD_LINE" | awk -v exp="$EXP_NEW" '{$3=exp; print}')
  local NEW_DB; NEW_DB=$(echo "$DB_CURRENT" | sed "s|${OLD_LINE}|${NEW_LINE}|")
  info "Memperbarui: ${DIM}${OLD_LINE}${RESET}"
  info "Menjadi   : ${BWHITE}${NEW_LINE}${RESET}"
  local SHA; SHA=$(push_file "$DB_FILE" "$NEW_DB" "extend: ijin ${NAMA} (${IP}) → ${EXP_NEW}")
  if [[ "$SHA" != "ERROR"* ]]; then
    success "Berhasil diperpanjang! Commit: ${DIM}${SHA:0:12}${RESET}"
  else
    error "Gagal memperpanjang: $SHA"
  fi
  echo ""
}

# ── Cek status satu IP ────────────────────────────────────────────
cmd_check() {
  banner
  sep; echo -e "  ${BOLD}CEK STATUS IP${RESET}"; sep
  echo ""
  read -rp "  Masukkan IP VPS: " IP
  [[ -z "$IP" ]] && { info "Dibatalkan."; return; }
  local DB; DB=$(get_file "$DB_FILE")
  local LINE; LINE=$(echo "$DB" | grep "$IP" || true)
  if [[ -z "$LINE" ]]; then
    warn "IP ${BWHITE}${IP}${RESET} tidak terdaftar di database"
  else
    local NAMA; NAMA=$(echo "$LINE" | awk '{print $2}')
    local EXP; EXP=$(echo "$LINE" | awk '{print $3}')
    local TODAY; TODAY=$(date '+%Y-%m-%d')
    echo ""
    echo -e "  ${BPURPLE}┌──────────────────────────────────────┐${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BOLD}Nama   :${RESET} ${BWHITE}${NAMA}${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BOLD}IP     :${RESET} ${BWHITE}${IP}${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BOLD}Exp    :${RESET} ${BWHITE}${EXP}${RESET}"
    if [[ "$EXP" < "$TODAY" ]] 2>/dev/null; then
      echo -e "  ${BPURPLE}│${RESET}  ${BOLD}Status :${RESET} ${BRED}EXPIRED${RESET}"
    else
      echo -e "  ${BPURPLE}│${RESET}  ${BOLD}Status :${RESET} ${BGREEN}AKTIF ✔${RESET}"
    fi
    echo -e "  ${BPURPLE}└──────────────────────────────────────┘${RESET}"
  fi
  echo ""
}

# ── Menu utama ────────────────────────────────────────────────────
main_menu() {
  while true; do
    banner
    echo -e "  ${BPURPLE}┌─────────────────────────────────────────────────────┐${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BOLD}${BWHITE}MENU ADMIN IJIN${RESET}                                      ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}├─────────────────────────────────────────────────────┤${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BCYAN}[1]${RESET}  Lihat semua ijin aktif                           ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BGREEN}[2]${RESET}  Tambah ijin VPS baru                             ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BYELLOW}[3]${RESET}  Perpanjang ijin VPS                              ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BRED}[4]${RESET}  Hapus ijin VPS                                   ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${BPURPLE}[5]${RESET}  Cek status satu IP                               ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}│${RESET}  ${DIM}[0]  Keluar${RESET}                                              ${BPURPLE}│${RESET}"
    echo -e "  ${BPURPLE}└─────────────────────────────────────────────────────┘${RESET}"
    echo ""
    read -rp "  Pilih menu [0-5]: " CHOICE
    case "$CHOICE" in
      1) cmd_list   ;;
      2) cmd_add    ;;
      3) cmd_extend ;;
      4) cmd_remove ;;
      5) cmd_check  ;;
      0) echo ""; info "Sampai jumpa!"; echo ""; exit 0 ;;
      *) warn "Pilihan tidak valid!" ;;
    esac
    read -rp "  Tekan Enter untuk kembali ke menu..." _
  done
}

# ── Entry point ───────────────────────────────────────────────────
case "${1:-menu}" in
  list|ls)    cmd_list   ;;
  add)        load_token; cmd_add    ;;
  remove|rm)  load_token; cmd_remove ;;
  extend|ext) load_token; cmd_extend ;;
  check)      cmd_check  ;;
  menu|*)     main_menu  ;;
esac
