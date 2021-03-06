#!/bin/bash

set -e

# copy boot specs, initramfs, kernel and device tree to a well known location

mkdir -p "${BINARIES_DIR}"/kernel
cp -ar \
	"${BR2_EXTERNAL_PHOENIX_PATH}"/board/Phoenix/utilities/bootspecs/loader \
	"${BINARIES_DIR}"/rootfs.cpio \
	"${BINARIES_DIR}"/stm32mp157c-odyssey.dtb \
	"${BINARIES_DIR}"/zImage \
	"${BINARIES_DIR}"/kernel

# compress them into a tarball for rauc
tar -cJf \
	"${BINARIES_DIR}"/kernel.tar.xz \
	-C "${BINARIES_DIR}"/kernel \
	.

# create a filesystem for the initial image containing them

fallocate -l 32m \
	"${BINARIES_DIR}"/kernel.ext4
mkfs.ext4 -Fd \
	"${BINARIES_DIR}"/kernel \
	"${BINARIES_DIR}"/kernel.ext4

# prepare for genimage

cd "${BINARIES_DIR}"

# use different genimage configuration depending on weather PSLC is used

if [ "${BR2_PHOENIX_PSLC_EMMC}" = 1 ]
then
	export GENIMAGE_TMP=${BR2_EXTERNAL_PHOENIX_PATH}/board/Phoenix/utilities/genimage-pslc.tmp
else
	export GENIMAGE_TMP=${BR2_EXTERNAL_PHOENIX_PATH}/board/Phoenix/utilities/genimage.tmp
fi
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
