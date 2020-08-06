#!/bin/sh

set -e

. "${BR2_EXTERNAL_MynaPlayer_PATH}"/scripts/certs.sh

# copy machine-id into the target

cp "${BR2_EXTERNAL_MynaPlayer_PATH}"/board/myna-player-odyssey/utilities/machine-id \
	"${TARGET_DIR}"/etc/machine-id

# Moving kernel modules into place

rsync -ar "${BASE_DIR}"/../kmod/modules/* \
	"${TARGET_DIR}"/usr/lib/modules

# lets point emergency.target to reboot.target

rm "${TARGET_DIR}"/usr/lib/systemd/system/emergency.target
ln -sr "${TARGET_DIR}"/usr/lib/systemd/system/reboot.target \
	"${TARGET_DIR}"/usr/lib/systemd/system/emergency.target

# copy changelog into the target

cp "${BR2_EXTERNAL_MynaPlayer_PATH}"/changelog.md \
	"${TARGET_DIR}"/etc/changelog.md

# copy the kernel and device tree

mkdir -p "${TARGET_DIR}"/boot
cp -a "${BASE_DIR}"/../kernel/stm32mp157c-odyssey.dtb \
	"${BASE_DIR}"/../kernel/zImage \
	"${TARGET_DIR}"/boot

# grab keyring needed for rauc

cp "${BR2_EXTERNAL_MynaPlayer_PATH}"/certs/keyring.pem \
	"${TARGET_DIR}"/etc/rauc/keyring.pem
