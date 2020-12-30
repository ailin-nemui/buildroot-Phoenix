#!/bin/sh

set -e

. "${BR2_EXTERNAL_PHOENIX_PATH}"/scripts/certs.sh

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
