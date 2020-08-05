#!/bin/sh

unlink "${TARGET_DIR}"/usr/lib/systemd/system/default.target
unlink "${TARGET_DIR}"/etc/systemd/system/default.target
ln -srf "${TARGET_DIR}"/usr/lib/systemd/system/initrd.target \
	"${TARGET_DIR}"/usr/lib/systemd/system/default.target
ln -srf "${TARGET_DIR}"/lib/systemd/systemd \
	"${TARGET_DIR}"/init

dbus-uuidgen > "${BR2_EXTERNAL_MynaPlayer_PATH}"/board/myna-player-odyssey/utilities/machine-id
cp "${BR2_EXTERNAL_MynaPlayer_PATH}"/board/myna-player-odyssey/utilities/machine-id \
"${TARGET_DIR}"/etc/machine-id
chmod 444 "${TARGET_DIR}"/etc/machine-id

# lets point emergency.target to reboot.target

rm "${TARGET_DIR}"/usr/lib/systemd/system/emergency.target
ln -sr "${TARGET_DIR}"/usr/lib/systemd/system/reboot.target "${TARGET_DIR}"/usr/lib/systemd/system/emergency.target

# lets clean up the initramfs

cleanup() { find "${CLEANUP_DIR}" -depth -name "$1" -exec rm -rv "{}" \; ; }
CLEANUP_DIR="${TARGET_DIR}/usr/bin"
cleanup attr
cleanup busctl
cleanup chacl
cleanup choom
cleanup col
cleanup colcrt
cleanup colrm
cleanup column
cleanup dbus-*
cleanup dmesg
cleanup fincore
cleanup findmnt
cleanup flock
cleanup getfacl
cleanup getfattr
cleanup ipcmk
cleanup isosize
cleanup kernel-install
cleanup kmod
cleanup ldd
cleanup look
cleanup lsblk
cleanup lscpu
cleanup lsipc
cleanup lslocks
cleanup lsns
cleanup mcookie
cleanup namei
cleanup portablectl
cleanup prlimit
cleanup renice
cleanup rev
cleanup script
cleanup scriptlive
cleanup scriptreplay
cleanup setarch
cleanup setfacl
cleanup setsid
cleanup systemd-analyze
cleanup systemd-ask-password
cleanup systemd-cat
cleanup systemd-cgls
cleanup systemd-cgtop
cleanup systemd-delta
cleanup systemd-detect-virt
cleanup systemd-escape
cleanup systemd-id128
cleanup systemd-machine-id-setup
cleanup systemd-mount
cleanup systemd-notify
cleanup systemd-nspawn
cleanup systemd-path
cleanup systemd-run
cleanup systemd-socket-activate
cleanup systemd-stdio-bridge
cleanup systemd-tty-ask-password-agent
cleanup systemd-umount
cleanup uuidgen
cleanup uuidparse
cleanup whereis
cleanup xmlwf

CLEANUP_DIR="${TARGET_DIR}/usr/sbin"
cleanup depmod
cleanup fdisk
cleanup findfs
cleanup insmod
cleanup ldattach
cleanup lsmod
cleanup mkswap
cleanup modinfo
cleanup modprobe
cleanup readprofile
cleanup rmmod
cleanup rtcwake
cleanup sfdisk
cleanup swaplabel
cleanup swapoff
cleanup swapon

CLEANUP_DIR="${TARGET_DIR}/usr/lib/systemd/system"
cleanup multi-user.target.wants
cleanup local-fs.target.wants
cleanup timers.target.wants
cleanup rescue.target.wants
cleanup graphical.target.wants
cleanup "runlevel*.target.wants"
cleanup systemd-ask-password-console.path
cleanup systemd-journal-catalog-update.service
cleanup systemd-journal-flush.service
cleanup systemd-machine-id-commit.service
cleanup systemd-sysctl.service
cleanup systemd-tmpfiles-setup.service
cleanup systemd-update-done.service
cleanup systemd-update-utmp.service
cleanup "*.mount"
cleanup dbus.socket
cleanup systemd-initctl.socket
cleanup "user*"
cleanup systemd-user-sessions.service
cleanup system-update-cleanup.service
cleanup system-update-pre.target
cleanup system-update.target
cleanup time-set.target
cleanup time-sync.target
cleanup systemd-vconsole-setup.service
cleanup systemd-update-done.service
cleanup systemd-update-utmp-runlevel.service
cleanup systemd-update-utmp.service
cleanup systemd-udev-settle.service
cleanup systemd-tmpfiles-setup.service
cleanup systemd-remount-fs.service
cleanup systemd-suspend.service
cleanup systemd-sysctl.service
cleanup systemd-tmpfiles-clean.service
cleanup systemd-tmpfiles-clean.timer
cleanup systemd-nspawn@.service
cleanup systemd-portabled.service
cleanup systemd-poweroff.service
cleanup systemd-pstore.service
cleanup systemd-journal-flush.service
cleanup systemd-kexec.service
cleanup systemd-machine-id-commit.service
cleanup systemd-halt.service
cleanup systemd-initctl.service
cleanup systemd-initctl.socket
cleanup systemd-journal-catalog-update.service
cleanup systemd-exit.service
cleanup systemd-ask-password-console.path
cleanup systemd-ask-password-console.service
cleanup systemd-ask-password-wall.path
cleanup systemd-ask-password-wall.service
cleanup systemd-boot-check-no-failures.service
cleanup syslog.socket
cleanup sound.target
cleanup suspend.target
cleanup smartcard.target
cleanup sigpwr.target
cleanup sleep.target
cleanup "runlevel*.target"
cleanup rpcbind.target
cleanup remote-fs-pre.target
cleanup remote-fs.target
cleanup multi-user.target
cleanup network-online.target
cleanup network-pre.target
cleanup network.target
cleanup nss-lookup.target
cleanup nss-user-lookup.target
cleanup poweroff.target
cleanup printer.target
cleanup rc-local.service
cleanup kexec.target
cleanup graphical.target
cleanup halt.target
cleanup exit.target
cleanup dbus-org.freedesktop.portable1.service
cleanup dbus.service
cleanup debug-shell.service
cleanup bluetooth.target
cleanup boot-complete.target
cleanup console-getty.service
cleanup container-getty@.service
cleanup autovt@.service

CLEANUP_DIR="${TARGET_DIR}/usr/lib/systemd"
cleanup "*user*"
cleanup system-preset
cleanup system-shutdown
cleanup system-sleep
cleanup systemd-update-done
cleanup systemd-update-utmp
cleanup systemd-sleep
cleanup systemd-socket-proxyd
cleanup systemd-portabled
cleanup systemd-pstore
cleanup systemd-remount-fs
cleanup systemd-reply-password
cleanup systemd-makefs
cleanup systemd-growfs
cleanup systemd-initctl
cleanup systemd-ac-power
cleanup systemd-boot-check-no-failures
cleanup systemd-cgroups-agent
cleanup systemd-dissect
cleanup network
cleanup portable
cleanup catalog

CLEANUP_DIR="${TARGET_DIR}/usr/lib"
cleanup tmpfiles.d
cleanup modules-load.d
cleanup sysusers.d
cleanup rpm
cleanup security
cleanup sysctl.d

CLEANUP_DIR="${TARGET_DIR}/etc"
cleanup dbus-1
cleanup environment
cleanup init.d
cleanup kernel
cleanup network
cleanup os-release
cleanup pam.d
cleanup profile
cleanup profile.d
cleanup protocols
cleanup resolv.conf
cleanup security
cleanup services
cleanup shells
cleanup sysctl.d
cleanup timezone
cleanup tmpfiles.d
cleanup udev
cleanup X11
cleanup xattr.conf
cleanup xdg

CLEANUP_DIR="${TARGET_DIR}/etc/systemd"
cleanup *.conf
cleanup user
cleanup tmpfiles.d

CLEANUP_DIR="${TARGET_DIR}/etc/systemd/system"
cleanup boot-complete.target.requires
cleanup ctrl-alt-del.target
cleanup default.target
cleanup multi-user.target.wants
cleanup network.service
cleanup systemd-remount-fs.service.wants

# Moving kernel modules to a well known location

mkdir -p "${BASE_DIR}"/../kmod
mv "${TARGET_DIR}"/usr/lib/modules "${BASE_DIR}"/../kmod/modules ||true
