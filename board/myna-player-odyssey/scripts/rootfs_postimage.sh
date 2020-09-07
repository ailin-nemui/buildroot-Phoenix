#!/bin/bash

set -e

# create filesystem for rauc slot status

fallocate -l 2m "${BINARIES_DIR}/rauc.ext4"
mkfs.ext4 -F "${BINARIES_DIR}/rauc.ext4"

# prepare for genimage
cd "${BINARIES_DIR}"
export GENIMAGE_TMP=${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/genimage.tmp
GENIMAGE_CFG="${BR2_EXTERNAL_MynaPlayer_PATH}/board/myna-player-odyssey/utilities/genimage.cfg"
export GENIMAGE_USER=$(whoami)
export GENIMAGE_HOST=$(hostname)
export GENIMAGE_BUILD_ID=$(git describe --dirty --broken)

envsubst \
\$GENIMAGE_USER,\
\$GENIMAGE_HOST,\
\$GENIMAGE_BUILD_ID \
< ${GENIMAGE_TMP} \
> ${GENIMAGE_CFG}
