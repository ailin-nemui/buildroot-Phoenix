
2020-09-06 / 2020-09-06
=======================

  * board/MynaPlayer odyssey: added gptfdisk package (gdisk/sgdisk).
  * board/MynaPlayer odyssey: bump kernel to 5.8.7.
  * board/MynaPlayer odyssey: Allow root to login via ssh (prohibit-password). Disabled clear text password authentification.
  * Merge pull request #12 from LuminaSensum/NM-ipv6-fixups
	  * board/MynaPlayer odyssey: fix IPv6 for the wired connection.
  * Merge pull request #19 from LuminaSensum/WIP_debugging
	  * packages: Enable strace
	  * packages: Enable trace-cmd
	  * linux: Enable tracing kernel config
	  * toolchain: Copy gdbserver to target
  * Merge pull request #16 from LuminaSensum/kernel_improvements
	  * board/MynaPlayer odyssey: disable some more useless kernel drivers.
	  * board/MynaPlayer odyssey: various kernel improvements.
	  * board/MynaPlayer odyssey: build with NEON FPU and THUMB-2 instruction set.
  * Merge pull request #15 from LuminaSensum/lifepo4wered-pi
	  * packages/lifepo4wered-pi: make it possible to select this with or without systemd.
	  * packages/lifepo4wered-pi: remove systemd requirement.
	  * board/MynaPlayer odyssey: select lifepo4wered-pi package.
	  * packages/lifepo4wered-pi: new package.
  * Merge pull request #14 from LuminaSensum/WIP_wifi
	  * board/MynaPlayer odyssey: add wpa_supplicant.
  * Merge pull request #11 from LuminaSensum/WIP_peripherals
	  * linux patches: Add Wi-Fi to the device tree
	  * linux patches: Add i2c patches
	  * linux patches: Rename patches to make updating easier
	  * linux patches: Update to v7 of the stm32mp157c-odyssey patchset
  * Merge pull request #3 from LuminaSensum/WIP_README
	  * README.md: Add instructions for building and installation
	  * buildroot-patches: Add patches needed for Buildroot

2020-08-11 / 2020-08-11
=======================

  * Merge pull request #10 from LuminaSensum/WIP_initramfs-less
	  * board/MynaPlayer odyssey: Add ethernet and machine-id support in barebox.
	  * board/MynaPlayer odyssey: added pivot_root from util-linux.
	  * board/MynaPlayer odyssey: add kernel image and device tree to the target via buildroot.
	  * board/MynaPlayer odyssey: Make ATF much less verbose.
	  * board/MynaPlayer odyssey: modify boot spec entry.
	  * board/MynaPlayer odyssey: removed initramfs.
  * Merge pull request #5 from LuminaSensum/WIP_rauc_fixup
	  * scripts/rauc_fixups.sh: Copy instead of symlinking
	  * external.mk: Fix rauc-fixups makefile race
  * Merge pull request #6 from LuminaSensum/WIP_logcolors
	  * boot: Add systemd.log_color=off to aid serial logging
  * Merge pull request #4 from LuminaSensum/WIP_sshd_cleanup
	  * openssh-systemd: Remove sysvinit files

2020-08-06 / 2020-08-06
=======================

  * Merge branch 'unstable-dev-board' into stable-dev-board
	  * Added LICENSE file. This work is entirely under the GPL 3.0 or later, except where otherwise noted (third party code).
	  * board/MynaPlayer odyssey: only copy machine-id into the target with postbuild scripts. Use a device table file to alter its permissions later -- this avoids getting a permission denied error if you have to run the postbuild script multiple times e.g: build errors with trying multiple fixes.
	  * Reworked certificates handling. The certs.sh.example contains a full example of this, and must be copied to certs.sh, and modified accordingly to reflect the real paths where the certificates are stored. A script that can be called by any board is creating symlinks from the real paths to corresponding statics targets for usage in genimage and postbuild scripts. The certs folder in the external tree must never be distributed in the repository, and is hence ignored via .gitignore.
	  * {Config, board/MynaPlayer odyssey: change kernel compression to lz4 and initramfs compression to none.
	  * board/MynaPlayer odyssey: linux.config: enable schedstats, this is required by systemd-bootchart.
	  * board/MynaPlayer odyssey: create initial empty ext4 filesystem for storing rauc slot status, and add this to the full disk image.
	  * packages/disabled-services: add systemd-bootchart.
	  * Config: configs/myna_player_odyssey_defconfig: remove unneeded firmwares.
	  * Config: board/myna-player-odyssey/configs/linux.config: tweaks for sound drivers and sound support.

2020-08-05 / 2020-08-05
=======================

  * Initial commit.
