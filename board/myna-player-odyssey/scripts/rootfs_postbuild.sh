#!/bin/sh

set -e

# setup machine-id

cp "${BR2_EXTERNAL_MynaPlayer_PATH}"/board/myna-player-odyssey/utilities/machine-id \
	"${TARGET_DIR}"/etc/machine-id
chmod 444 "${TARGET_DIR}"/etc/machine-id

# Moving kernel modules into place

rsync -ar ${BASE_DIR}/../kmod/modules/* \
	${TARGET_DIR}/usr/lib/modules

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

RAUC_KEYRING=$(awk '{print $3}' "${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/certs.txt" | sed -n '1p')
cp "${RAUC_KEYRING}" \
	"${TARGET_DIR}"/etc/rauc/keyring.pem
