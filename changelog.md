
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
