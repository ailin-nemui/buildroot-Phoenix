#!/bin/sh

set -e

. "${BR2_EXTERNAL_PHOENIX_PATH}"/scripts/certs.sh

# creating a clean directory to store copies of files in

CERTS_DIR="${BR2_EXTERNAL_PHOENIX_PATH}"/certs
test -d "${CERTS_DIR}" && rm -r "${CERTS_DIR}"
mkdir -p "${CERTS_DIR}"

# lets copy the appropriate files to use later with genimage as well as in rootfs_postbuild.sh

cp "${RAUC_CERTIFICATE_AUTHORITY}" "${CERTS_DIR}"/keyring.pem
cp "${RAUC_PRIVATE_KEY}" "${CERTS_DIR}"/signing.key
cp "${RAUC_PUBLIC_KEY}" "${CERTS_DIR}"/signing.crt
