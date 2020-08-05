#!/bin/bash

set -e

# copy bootloader

cp "${BASE_DIR}"/../kernel/barebox.bin \
	"${BINARIES_DIR}"/barebox.bin

# prepare for genimage

export GENIMAGE_TMP=${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/genimage.tmp
GENIMAGE_CFG="${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/genimage.cfg"
export GENIMAGE_DATE=$(date -Idate)
export GENIMAGE_USER=$(whoami)
export GENIMAGE_HOST=$(hostname)
export GENIMAGE_BUILD_ID=$(uuidgen)
export GENIMAGE_CERTIFICATE_AUTHORITY=$(awk '{print $3}' "${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/certs.txt" | sed -n '1p')
export GENIMAGE_PRIVATE_KEY=$(awk '{print $3}' "${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/certs.txt" | sed -n '2p')
export GENIMAGE_PUBLIC_KEY=$(awk '{print $3}' "${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/certs.txt" | sed -n '3p')

envsubst \
\$GENIMAGE_DATE,\
\$GENIMAGE_USER,\
\$GENIMAGE_HOST,\
\$GENIMAGE_BUILD_ID,\
\$GENIMAGE_CERTIFICATE_AUTHORITY,\
\$GENIMAGE_PRIVATE_KEY,\
\$GENIMAGE_PUBLIC_KEY \
< ${GENIMAGE_TMP} \
> ${GENIMAGE_CFG}
