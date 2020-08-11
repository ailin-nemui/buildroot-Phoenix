
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
