#!/bin/bash

set -e

# prepare for genimage
cd "${BINARIES_DIR}"
export GENIMAGE_TMP=${BR2_EXTERNAL_PHOENIX_PATH}/board/Phoenix/utilities/genimage.tmp
GENIMAGE_CFG="${BR2_EXTERNAL_PHOENIX_PATH}/board/Phoenix/utilities/genimage.cfg"
export GENIMAGE_USER=$(whoami)
export GENIMAGE_HOST=$(hostname)
export GENIMAGE_BUILD_ID=$(git describe --dirty --broken)

envsubst \
\$GENIMAGE_USER,\
\$GENIMAGE_HOST,\
\$GENIMAGE_BUILD_ID \
< ${GENIMAGE_TMP} \
> ${GENIMAGE_CFG}
