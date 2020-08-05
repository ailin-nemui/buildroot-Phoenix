#!/bin/bash

# copy kernel, bootloader and device tree to a well known location

mkdir -p "${BASE_DIR}"/../kernel
cp -a "${BINARIES_DIR}"/zImage \
	"${BINARIES_DIR}"/stm32mp157c-odyssey.dtb \
	"${BINARIES_DIR}"/barebox.bin \
	"${BASE_DIR}"/../kernel
