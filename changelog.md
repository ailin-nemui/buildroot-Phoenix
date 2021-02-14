
2021-02-14 / 2021-02-14
=======================
  * Important changes:
    * Migrate to a 2x boot/2x rootfs setup. Boot partitions are using ext4, rootfs are using erofs.
      * board/Phoenix: migrate rauc configuration to erofs and kernel in ext4.
      * board/Phoenix: fix pre-init script, overlayfs partition is now p5.
      * board/Phoenix: migrate genimage to erofs for rootfs and ext4 for kernel.
      * board/Phoenix: remove older boot spec from the rootfs.
      * board/Phoenix: add new boot specs.
      * board/Phoenix: create tarball and ext4 filesystem containing kernel, device tree and bootspecs files.
      * board/Phoenix: create erofs filesystem for rootfs.
      * board/Phoenix: remove kernel files from /boot.
      * board/Phoenix: remove ext4 rootfs creation.
      * board/Phoenix: enable erofs filesystem in kernel.
      * board/Phoenix: prepare barebox environment to deal with separate boot and rootfs partitions.
      * board/Phoenix: rename system0.boot and system1.boot in barebox environment to system0 and system1.
  * board/Phoenix: select xz as kernel modules compression.
  * board/Phoenix: make host-kmod support xz-compressed modules.
  * board/Phoenix: compress kernel using zstd.
  * board/Phoenix: select micropython and micropython-libs.
  * board/Phoenix: some more kernel configuration clean ups and tweaks.
  * board/Phoenix: modify PAM configuration to support reading a motd.
  * board/Phoenix: tweak usb subsystem.
  * board/Phoenix: reintroduce kernel patches with standard naming.
  * board/Phoenix: clean up kernel patches.
  * board/Phoenix: clean up kernel config.
  * board/Phoenix: select rtl8821cu package.
  * packages/rtl8821cu: new package.
  * board/Phoenix: added PAM support for gnu screen (allows locking).
  * board/Phoenix: copy the gconv set of charsets to the target.
  * board/Phoenix: tweak pre-init script.
  * packages/perl-datetime-timezone: new package.
  * packages/perl-params-validationcompiler: new package.
  * Changelog: fix formatting.

2021-01-04 / 2021-01-04
=======================

  * Important changes
	  * board/Phoenix: rework the MynaPlayer base to be used on Phoenix instead.
	  * board/Phoenix: enable sudo and disable root login.
	  * board/Phoenix: add default sudo configuration.
	  * board/Phoenix: set path to users table.
  * Language changes
	  * board/Phoenix: set default local time to Europe/Paris.
	  * board/Phoenix: add locale.sh snippet in profile.d.
	  * board/Phoenix: set default system locale from the postbuild script.
  * New/removed softwares in config
	  * board/Phoenix: added gnu screen.
	  * board/Phoenix: added irssi-git in default config.
	  * board/Phoenix: enable systemd-analyze, hwdb installation and random seed support.
	  * board/Phoenix: remove systemd-bootchart.
	  * board/Phoenix: enable basic util-linux set of utilities.
  * README
	  * Merge pull request #33 from LuminaSensum/WIP_EASYRSA
		  * README: Fix easyrsa instructions
	  * README: mention sudo/no root login.
	  * README: added notes about the users table.
	  * README: fix url to changelog.
  * Kernel changes
	  * board/Phoenix: bump kernel to 5.10.4.
	  * board/Phoenix: remove unneeded kernel patches.
	  * board/Phoenix: add a patch to provide thermal support in device tree.
	  * board/Phoenix: minor tweaks to kernel configuration.
  * Packages
	  * board/Phoenix: added perl-libs subdirectory in external.mk.
	  * packages/irssi-git: new package.
	  * packages/libotr: new package.
	  * package/lifepo4wered-pi: remove package.
	  * packages/perl-sub-identify: new package.
	  * packages/perl-specio: new package.
	  * packages/perl-params-validate: new package.
	  * packages/perl-namespace-clean: new package.
	  * packages/perl-namespace-autoclean: new package.
	  * packages/perl-mro-compat: new package.
	  * packages/perl-exception-class: new package.
	  * packages/perl-eval-closure: new package.
	  * packages/perl-datetime-locale: new package.
	  * packages/perl-datetime-format-strptime: new package.
	  * packages/perl-datetime-format-iso8601: new package.
	  * packages/perl-datetime-format-builder: new package.
	  * packages/perl-datetime: new package.
	  * packages/perl-class-singleton: new package.
	  * packages/perl-class-data-inheritable: new package.
	  * packages/perl-b-hooks-endofscope: new package.
  * Misc
	  * board/Phoenix: fix capitalisation in genimage config.
	  * board/Phoenix: fix capitalisation in hostname and banner.
	  * board/Phoenix: fix rauc compatible string.
	  * board/Phoenix: add dt-utils patch to change lock file directory.
	  * board/MynaPlayer odyssey: remove rauc partition from genimage, and reworked the overlay filesystem creation.
	  * board/MynaPlayer odyssey: bump barebox version to 2020.12.0.
	  * board/MynaPlayer odyssey: remove defined partition types in genimage template.
	  * board/MynaPlayer odyssey: disable trace-cmd package since it broke.
	  * board/MynaPlayer odyssey: bump toolchain from bootlin to latest bleeding edge 2020.08-1.

2020-09-22 / 2020-09-22
=======================

  * Merge pull request #30 from LuminaSensum/WIP_barebox-env
	  * board/MynaPlayer odyssey: add default built-in barebox environment.
  * Merge pull request #29 from LuminaSensum/WIP_terminfo-2
	  * board/MynaPlayer odyssey: fix terminfo's additional files to include screen.linux.
  * Merge pull request #28 from LuminaSensum/kernel-bump
	  * board/MynaPlayer odyssey: bump kernel to 5.8.10.
  * Merge pull request #26 from LuminaSensum/WIP_build-id
	  * board/MynaPlayer odyssey: changed the way the file name and metadata of the images are constructed.
  * Merge pull request #27 from LuminaSensum/WIP_changelog
	  * Added the changelog in the readme.
  * Merge pull request #23 from LuminaSensum/WIP_preinit
	  * board/MynaPlayer odyssey: add pre-init script to setup overlay filesystem.
  * Merge pull request #25 from LuminaSensum/WIP_terminfo
	  * board/MynaPlayer odyssey: add screen and tmux terminfo files into the target.
  * Merge pull request #24 from LuminaSensum/WIP_rauc
	  * board/MynaPlayer odyssey: added basic service to mark boot as good with rauc.
  * Merge pull request #22 from LuminaSensum/WIP_squashfs
	  * board/MynaPlayer odyssey: rework squashfs support
  * Merge pull request #21 from LuminaSensum/WIP_ipv6
	  * board/MynaPlayer odyssey: fix networking for good.

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
