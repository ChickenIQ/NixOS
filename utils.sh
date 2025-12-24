#!/bin/sh
set -e

# Helpers
setHostname() {
  if [ -z "$1" ]; then
    echo -e "\e[31mERROR: Hostname not specified\e[0m"
    exit 1
  fi
  hostname=$1
}

setInstallDisk() {
  if [ -z "$1" ]; then
    echo -e "\e[31mERROR: Install disk not specified\e[0m"
    exit 1
  fi
  
  if [ ! -b "$1" ]; then
    echo -e "\e[31mERROR: Install disk '$1' does not exist\e[0m"
    exit 1
  fi

  ln -sf "$1" /dev/diskoTarget
}

checkRoot() {
  if [ "$(id -u)" -ne 0 ]; then
    echo -e "\e[31mERROR: This script must be run as root\e[0m"
    exit 1
  fi
}

checkMounted() {
  if ! mountpoint -q /mnt; then
    echo -e "\e[31mERROR: /mnt is not mounted. Please run the 'format' or 'mount' command first.\e[0m"
    exit 1
  fi
}

# Wrappers
nix() { $(which nix) --experimental-features "nix-command flakes" "$@"; }

disko() { nix run github:nix-community/disko/latest -- -f ".#$hostname" "$@"; }

# Modes
format() { disko --mode destroy,format,mount; }

mount() { disko --mode mount; }

facter() {
  mkdir -p ./hardware/$hostname/
  nix run github:nix-community/nixos-facter > ./hardware/$hostname/facter.json
  git add ./hardware/$hostname/facter.json
}

vm() { nix run -L ".#nixosConfigurations.$hostname.config.system.build.vm"; }

install() {
  mkdir -p /mnt/data/etc/nixos/
  cp -r ./* /mnt/data/etc/nixos/
  chown -R 1000:1000 /mnt/data/etc/nixos/

  if [ ! -d "/mnt/data/var/lib/sbctl/keys" ]; then
    mkdir -p /mnt/data/var/lib/sbctl
    ln -sf /mnt/data/var/lib/sbctl/ /var/lib/
    nix-shell -p sbctl --run "sbctl create-keys"
  fi

  mkdir -p /mnt/var/lib/sbctl/
  ln -sf /mnt/data/var/lib/sbctl/* /mnt/var/lib/sbctl/

  nixos-install --no-root-passwd --no-channel-copy --flake ".#$hostname"
}


# Main
case "$1" in
  format|mount) 
    checkRoot
    setHostname "$2"
    setInstallDisk "$3"
    "$1"
  ;;

  facter)
    checkRoot
    setHostname "$2"
    "$1"
  ;;

  install)
    checkRoot
    checkMounted
    setHostname "$2"
    facter
    "$1"
  ;;

  vm) 
    setHostname "$2"
    "$1"
    ;;
  *)
    echo "Usage: $0 <mode> <hostname> <disk>"
    echo "Modes: format, mount, facter, install"
    exit 1
    ;;
esac
