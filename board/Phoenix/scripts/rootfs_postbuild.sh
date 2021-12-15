#!/bin/sh

set -e

. "${BR2_EXTERNAL_PHOENIX_PATH}"/scripts/certs.sh

# create an empty /boot directory to be used as mountpoint for either of the boot partitions

mkdir -p "${TARGET_DIR}"/boot

# creating locale config

echo "LANG=en_US.UTF-8" > "${TARGET_DIR}"/etc/locale.conf

# lets point emergency.target to reboot.target

rm "${TARGET_DIR}"/usr/lib/systemd/system/emergency.target
ln -sr "${TARGET_DIR}"/usr/lib/systemd/system/reboot.target \
	"${TARGET_DIR}"/usr/lib/systemd/system/emergency.target

# copy changelog into the target

cp "${BR2_EXTERNAL_PHOENIX_PATH}"/changelog.md \
	"${TARGET_DIR}"/etc/changelog.md

# grab keyring needed for rauc

cp "${BR2_EXTERNAL_PHOENIX_PATH}"/certs/keyring.pem \
	"${TARGET_DIR}"/etc/rauc/keyring.pem

# copy journald drop-in if eMMC is in PSLC mode

if [ "${BR2_PHOENIX_PSLC_EMMC}" = 1 ]
then
	mkdir -p "${TARGET_DIR}"/etc/systemd/journald.conf.d
	cp "${BR2_EXTERNAL_PHOENIX_PATH}"/board/Phoenix/utilities/00-size-limit.conf \
		"${TARGET_DIR}"/etc/systemd/journald.conf.d/00-size-limit.conf
fi
