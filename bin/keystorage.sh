#! /usr/bin/env bash

set -o posix
set -o nounset
set -o pipefail
set -o errexit


usage() {
  cat <<EOB
$0 <mount|unmount> [all]

Mounts or unmounts the keystorage partition of the USB stick, or additionally
/boot and /efi if [all] parameter is given.
EOB
}

################################################################################
#
# Variables
#
################################################################################

KEYSTORAGE_DEVICE_UUID="abebf4fa-1ea4-43b0-b4cb-5c28387ecc74"
KEYSTORAGE_LUKS_NAME="luks_keys"
KEYSTORAGE_VOLGROUP_NAME="vg_key_storage"
KEYSTORAGE_MOUNT_POINT="/home/bln/.keystorage"

BOOT_DEVICE_UUID="c8f23956-7f2e-4fda-acf5-85bb43905a58"
BOOT_LUKS_NAME="luks_boot"
BOOT_VOLGROUP_NAME="vg_boot"

EFI_DEVICE_UUID="71A3-D4C8"


################################################################################
#
# Helper functions for mounting
#
################################################################################

mount_keystorage() {
  if [[ ! $(mount | grep "$KEYSTORAGE_MOUNT_POINT") ]] && [ -e "/dev/disk/by-uuid/${KEYSTORAGE_DEVICE_UUID}" ]; then
    echo "Mounting keystorage ..."
    sudo cryptsetup luksOpen /dev/disk/by-uuid/${KEYSTORAGE_DEVICE_UUID} $KEYSTORAGE_LUKS_NAME
    mkdir --parent "$KEYSTORAGE_MOUNT_POINT"
    while [ ! -e "/dev/mapper/${KEYSTORAGE_VOLGROUP_NAME}-key_storage" ]; do
      sleep 1
    done
    sudo mount "/dev/mapper/${KEYSTORAGE_VOLGROUP_NAME}-key_storage" "$KEYSTORAGE_MOUNT_POINT"
  fi
}

mount_boot() {
  if [ -e "/dev/disk/by-uuid/${BOOT_DEVICE_UUID}" ]; then
    if mount | grep '/boot '; then
      echo "boot already mounted [SKIP]"
    else
      echo "Mounting boot ..."
      sudo cryptsetup luksOpen --key-file="${KEYSTORAGE_MOUNT_POINT}/luks_boot_keyfile" /dev/disk/by-uuid/${BOOT_DEVICE_UUID} $BOOT_LUKS_NAME

      while [ ! -e "/dev/mapper/${BOOT_VOLGROUP_NAME}-boot" ]; do
        sleep 1
      done
      sudo mount /dev/mapper/${BOOT_VOLGROUP_NAME}-boot /boot

      echo -n "[OK]"
    fi
  fi
}

mount_efi() {
  if mount | grep '/efi '; then
    echo "EFI already mounted [SKIP]"
  else
    echo -n "Mounting EFI ... "
    sudo mount /dev/disk/by-uuid/${EFI_DEVICE_UUID} /efi
    echo "[OK]"
  fi
}

mount_all() {
  mount_keystorage
  mount_boot
  mount_efi
}

################################################################################
#
# Helper functions for unmounting
#
################################################################################

unmount_keystorage() {
  if [ -e "/dev/mapper/$KEYSTORAGE_VOLGROUP_NAME-key_storage" ] && [ -e "$KEYSTORAGE_MOUNT_POINT" ]; then
    echo -n "Unmounting keystorage ..."
    if mount | grep "$KEYSTORAGE_MOUNT_POINT"; then
      sudo umount "$KEYSTORAGE_MOUNT_POINT" >/dev/null
    fi
    sudo vgchange --activate n $KEYSTORAGE_VOLGROUP_NAME >/dev/null
    rm -r "$KEYSTORAGE_MOUNT_POINT" >/dev/null
    sudo cryptsetup luksClose "$KEYSTORAGE_LUKS_NAME" >/dev/null
    echo "[OK]"
  else
    echo "Keystorage does not seem to be mounted ... [SKIP]"
  fi
}

unmount_boot() {
  if [ -e "/dev/mapper/$BOOT_VOLGROUP_NAME-boot" ] && [ -e "/boot" ]; then
    echo -n "Unmounting boot ..."
    if mount | grep /boot; then
      sudo umount "/boot" >/dev/null
    fi

    sudo vgchange --activate n $BOOT_VOLGROUP_NAME >/dev/null
    sudo cryptsetup luksClose "$BOOT_LUKS_NAME" >/dev/null
    echo "[OK]"
  else
    echo "/boot does not seem to be mounted ... [SKIP]"
  fi
}

unmount_efi() {
  if [ -e "/efi" ]; then
    echo -n "Unmounting EFI ..."
    sudo umount "/efi" >/dev/null
    echo "[OK]"
  else
    echo "/efi does not seem to be mounted ... [SKIP]"
  fi
}

unmount_all() {
  unmount_keystorage
  unmount_boot
  unmount_efi
}

################################################################################
#
# Argument handling
#
################################################################################

while [ $# -gt 0 ]; do
  case "$1" in
    mount)
      shift
      if [ $# -gt 0 ] && [ "$1" == "all" ]; then
        mount_all
        shift
      else
        mount_keystorage
      fi
      ;;
    unmount|umount)
      shift
      if [ $# -gt 0 ] && [ "$1" == "all" ]; then
        unmount_all
        shift
      else
        unmount_keystorage
      fi
      ;;
    *)
      usage
      exit 1
  esac
done
