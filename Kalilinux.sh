#!/bin/sh
# ============================================================
# iSH real-distro launcher
# ------------------------------------------------------------
# Chroots into a genuine copy of Kali Linux or Arch Linux 32
# (i686) downloaded from their official sources. This is not a
# themed shell - once inside, /etc/os-release is the real
# distro's file, so neofetch (installed fresh from that
# distro's own package manager) reports the real thing.
#
# Run this INSIDE the iSH app (Alpine, i386 usermode Linux
# emulator for iOS). Free storage needed: ~700MB-1GB per
# distro. Wi-Fi strongly recommended for the first run.
# ============================================================

BASE="/root/distros"
KALI_DIR="$BASE/kali"
ARCH_DIR="$BASE/arch32"
KALI_FILE="kali-nethunter-rootfs-minimal-i386.tar.xz"
KALI_URL="https://kali.download/nethunter-images/current/rootfs/$KALI_FILE"
KALI_SUMS_URL="https://kali.download/nethunter-images/current/rootfs/SHA256SUMS"
ARCHBOOT_URL="https://raw.githubusercontent.com/tokland/arch-bootstrap/master/arch-bootstrap.sh"

prereqs() {
  echo "==> Installing prerequisites via apk..."
  apk update
  apk add curl tar xz ca-certificates
}

install_kali() {
  mkdir -p "$KALI_DIR"
  cd /root || return 1
  echo "==> Downloading official Kali NetHunter rootfs (i386, ~140MB)..."
  curl -L --fail -O "$KALI_URL" || { echo "Download failed."; return 1; }
  curl -L --fail -O "$KALI_SUMS_URL" || echo "Warning: couldn't fetch SHA256SUMS, skipping verification."
  if [ -f SHA256SUMS ]; then
    echo "==> Verifying checksum..."
    if ! grep "$KALI_FILE" SHA256SUMS | sha256sum -c -; then
      echo "Checksum mismatch - aborting."
      rm -f "$KALI_FILE" SHA256SUMS
      return 1
    fi
  fi
  echo "==> Extracting (slow on a phone CPU - can take several minutes)..."
  tar -xJf "$KALI_FILE" -C "$KALI_DIR" || { echo "Extraction failed."; return 1; }
  rm -f "$KALI_FILE" SHA256SUMS
  echo "==> Kali base filesystem installed at $KALI_DIR"
}

install_arch() {
  mkdir -p "$ARCH_DIR"
  cd /root || return 1
  echo "==> Mainline Arch dropped 32-bit support in 2017, and iSH only"
  echo "    emulates a 32-bit (i386) CPU, so this uses Arch Linux 32"
  echo "    (archlinux32.org), the community i686 continuation."
  echo "==> Fetching arch-bootstrap (the standard community bootstrapper)..."
  curl -L --fail -O "$ARCHBOOT_URL" || { echo "Download failed."; return 1; }
  chmod +x arch-bootstrap.sh
  echo "==> Bootstrapping Arch32 from mirror.archlinux32.org - this pulls"
  echo "    base packages directly and can take a while..."
  ./arch-bootstrap.sh -a i686 "$ARCH_DIR" || { echo "Bootstrap failed."; return 1; }
  rm -f arch-bootstrap.sh
  echo "==> Arch32 base filesystem installed at $ARCH_DIR"
}

enter_kali() {
  D="$KALI_DIR"
  mount -t proc proc "$D/proc" 2>/dev/null
  mount --bind /dev "$D/dev" 2>/dev/null
  cp -L /etc/resolv.conf "$D/etc/resolv.conf" 2>/dev/null
  if ! chroot "$D" /bin/true 2>/dev/null; then
    echo "chroot didn't work on this iSH build. Try: apk add proot"
    echo "then: proot -r $D -b /dev -b /proc -0 /bin/bash"
    return 1
  fi
  chroot "$D" /usr/bin/env -i HOME=/root TERM="$TERM" \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    /bin/bash -c '
      if ! command -v neofetch >/dev/null 2>&1; then
        apt-get update -qq && apt-get install -y -qq neofetch
      fi
      neofetch
      if [ ! -f /root/.tools_prompted ]; then
        touch /root/.tools_prompted
        echo ""
        echo "This rootfs is Kali minimal - real Kali (apt-get is the"
        echo "genuine Kali repo), but tool commands like nmap, sqlmap,"
        echo "hydra, john, aircrack-ng etc. are not installed yet."
        echo "  1) kali-tools-top10     (10 essentials - smallest)"
        echo "  2) kali-linux-headless  (full CLI toolset, no GUI - bigger)"
        echo "  3) skip for now"
        printf "Install which? [1-3]: "
        read toolchoice
        case "$toolchoice" in
          1) apt-get update -qq && apt-get install kali-tools-top10 ;;
          2) apt-get update -qq && apt-get install kali-linux-headless ;;
          *) echo "Skipped. Install anytime with: apt install kali-tools-top10" ;;
        esac
      fi
      exec /bin/bash -l
    '
  umount "$D/dev" 2>/dev/null
  umount "$D/proc" 2>/dev/null
}

enter_arch() {
  D="$ARCH_DIR"
  mount -t proc proc "$D/proc" 2>/dev/null
  mount --bind /dev "$D/dev" 2>/dev/null
  cp -L /etc/resolv.conf "$D/etc/resolv.conf" 2>/dev/null
  if ! chroot "$D" /bin/true 2>/dev/null; then
    echo "chroot didn't work on this iSH build. Try: apk add proot"
    echo "then: proot -r $D -b /dev -b /proc -0 /bin/bash"
    return 1
  fi
  chroot "$D" /usr/bin/env -i HOME=/root TERM="$TERM" \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    /bin/bash -c '
      if ! command -v neofetch >/dev/null 2>&1; then
        pacman -Sy --noconfirm neofetch
      fi
      neofetch
      exec /bin/bash -l
    '
  umount "$D/dev" 2>/dev/null
  umount "$D/proc" 2>/dev/null
}

mkdir -p "$BASE"
prereqs

while true; do
  echo ""
  echo "============================================="
  echo "   iSH real-distro launcher"
  echo "   1) Kali Linux    (official i386 rootfs)"
  echo "   2) Arch Linux 32 (i686 community bootstrap)"
  echo "   3) Exit"
  echo "============================================="
  printf "Choose [1-3]: "
  read choice
  case "$choice" in
    1)
      [ -d "$KALI_DIR/bin" ] || install_kali
      [ -d "$KALI_DIR/bin" ] && enter_kali
      ;;
    2)
      [ -d "$ARCH_DIR/usr" ] || install_arch
      [ -d "$ARCH_DIR/usr" ] && enter_arch
      ;;
    3) exit 0 ;;
    *) echo "Invalid choice." ;;
  esac
done
