#!/bin/sh

set -e

. "${BR2_EXTERNAL_MynaPlayer_PATH}"/scripts/certs.sh

# creating directory to store symlinks in

mkdir -p "${BR2_EXTERNAL_MynaPlayer_PATH}"/certs

# lets create the appropriate symlinks to use later with genimage as well as in rootfs_postbuild.sh

ln -sf "${RAUC_CERTIFICATE_AUTHORITY}" \
	"${BR2_EXTERNAL_MynaPlayer_PATH}"/certs/keyring.pem
ln -sf "${RAUC_PRIVATE_KEY}" \
	"${BR2_EXTERNAL_MynaPlayer_PATH}"/certs/signing.key
ln -sf "${RAUC_PUBLIC_KEY}" \
	"${BR2_EXTERNAL_MynaPlayer_PATH}"/certs/signing.crt
