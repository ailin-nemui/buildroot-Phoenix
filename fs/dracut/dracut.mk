################################################################################
#
# Build the dracut initramfs image
#
################################################################################

# Dracut requires realpath from coreutils
ROOTFS_DRACUT_DEPENDENCIES += \
	host-dracut \
	host-kmod \
	dracut

ROOTFS_DRACUT_MODULES_INCLUDE = \
	base \
	dbus \
	rootfs-block \
	systemd \
	systemd-initrd \
	dracut-systemd \
	udev-rules
ROOTFS_DRACUT_MODULES_OMIT = dbus-broker

# Environment variables used to execute dracut
# We have to unset "prefix" as dracut uses it to move files around.
# Dracut doesn't support decimal points for the systemd version.
ROOTFS_DRACUT_SYSTEMD_VERSION_SANATIZED=`echo $(SYSTEMD_VERSION) |cut -d . -f 1`
ROOTFS_DRACUT_TARGET_DIR="$(ROOTFS_DRACUT_DIR)/target
ROOTFS_DRACUT_FS_ENV = \
	prefix="" \
	DESTROOTDIR="$(ROOTFS_DRACUT_TARGET_DIR)" \
	DRACUT_ARCH=$(BR2_ARCH) \
	DRACUT_COMPRESS_BZIP2="$(HOST_DIR)/bin/bzip2" \
	DRACUT_COMPRESS_GZIP="$(HOST_DIR)/bin/gzip" \
	DRACUT_COMPRESS_LZMA="$(HOST_DIR)/bin/lzma" \
	DRACUT_FIRMWARE_PATH="$(ROOTFS_DRACUT_TARGET_DIR)/usr/lib/firmware" \
	DRACUT_INSTALL="$(HOST_DIR)/bin/dracut-install" \
	DRACUT_INSTALL_PATH="$(ROOTFS_DRACUT_TARGET_DIR)/usr/bin:$(ROOTFS_DRACUT_TARGET_DIR)/usr/sbin:$(ROOTFS_DRACUT_TARGET_DIR)/usr/lib" \
	DRACUT_LDCONFIG=/bin/true \
	DRACUT_LDD="$(HOST_DIR)/sbin/prelink-rtld --root=$(ROOTFS_DRACUT_TARGET_DIR)/" \
	DRACUT_MODPROBE="$(HOST_DIR)/sbin/modprobe" \
	DRACUT_PATH="/bin /sbin" \
	STRIP_CMD="$(TARGET_CROSS)strip" \
	SYSTEMCTL="$(HOST_DIR)/bin/systemctl" \
	systemctlpath="$(HOST_DIR)/bin/systemctl" \
	systemdsystemconfdir="$(ROOTFS_DRACUT_TARGET_DIR)/etc/systemd/system" \
	systemdsystemunitdir="$(ROOTFS_DRACUT_TARGET_DIR)/lib/systemd/system" \
	systemdutildir="$(ROOTFS_DRACUT_TARGET_DIR)/lib/systemd/" \
	SYSTEMD_VERSION=$(ROOTFS_DRACUT_SYSTEMD_VERSION_SANATIZED) \
	udevdir="$(ROOTFS_DRACUT_TARGET_DIR)/usr/lib/udev" \
	UDEVVERSION=$(ROOTFS_DRACUT_SYSTEMD_VERSION_SANATIZED)

ROOTFS_DRACUT_MKFS_CONF_OPTS = \
	--force \
	--fstab \
	--noprefix \
	--sysroot=$(ROOTFS_DRACUT_TARGET_DIR) \
	--tmpdir=$(ROOTFS_DRACUT_DIR)/rootfs.dracut.tmp \
	--verbose

ifeq ($(BR2_ROOTFS_DEVICE_TABLE_SUPPORTS_EXTENDED_ATTRIBUTES),y)
ROOTFS_DRACUT_FS_ENV += DRACUT_NO_XATTR=true
else
ROOTFS_DRACUT_FS_ENV += DRACUT_NO_XATTR=false
endif

ifeq ($(BR2_PACKAGE_BASH),y)
ROOTFS_DRACUT_MODULES_INCLUDE += bash
else
ROOTFS_DRACUT_MODULES_OMIT += bash
endif

# Dracut typically executes busybox --list to get a list of installed busybox
# applets. Without a qemu wrapper, executing the busybox binary won't work in a
# cross-compiled environment. To avoid using a qemu-wrapper, we manually pass
# the list to Dracut using the busybox.links file that busybox creates when
# compiling.
ifeq ($(BR2_PACKAGE_BUSYBOX)$(BR2_PACKAGE_BUSYBOX_INDIVIDUAL_BINARIES),y)
ROOTFS_DRACUT_FS_ENV += \
	BUSYBOX_LIST=`sed -r -e s%.*/%%  $(BUSYBOX_DIR)/busybox.links;`
ROOTFS_DRACUT_MODULES_INCLUDE += busybox
else
ROOTFS_DRACUT_MODULES_OMIT += busybox
endif

ifeq ($(BR2_PACKAGE_MKSH),y)
ROOTFS_DRACUT_MODULES_INCLUDE += mksh
else
ROOTFS_DRACUT_MODULES_OMIT += mksh
endif

ifeq ($(BR2_PACKAGE_BTRFS_PROGS),y)
ROOTFS_DRACUT_MODULES_INCLUDE += btrfs
else
ROOTFS_DRACUT_MODULES_OMIT += btrfs
endif

ifeq ($(BR2_PACKAGE_DASH),y)
ROOTFS_DRACUT_MODULES_INCLUDE += dash
else
ROOTFS_DRACUT_MODULES_OMIT += dash
endif

ifeq ($(BR2_PACKAGE_PERL_I18N),y)
ROOTFS_DRACUT_MODULES_INCLUDE += i18n
else
ROOTFS_DRACUT_MODULES_OMIT += i18n
endif

ifeq ($(BR2_PACKAGE_RNG_TOOLS),y)
ROOTFS_DRACUT_MODULES_INCLUDE += rngd
else
ROOTFS_DRACUT_MODULES_OMIT += rngd
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
ROOTFS_DRACUT_MODULES_INCLUDE += securityfs selinux
else
ROOTFS_DRACUT_MODULES_OMIT += securityfs selinux
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_COREDUMP),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-coredump
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-coredump
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS)$(BR2_PACKAGE_SYSTEMD_HOSTNAMED),yy)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-hostnamed
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-hostnamed
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_INITRD),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-initrd
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-initrd
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_REPART),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-repart
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-repart
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_RFKILL),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-rfkill
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-rfill
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS)$(BR2_PACKAGE_SYSTEMD_RESOLVED),yy)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-resolved
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-resolved
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-sysusers
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-sysusers
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS)$(BR2_PACKAGE_SYSTEMD_NETWORKD),yy)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-networkd
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-networkd
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TIMEDATED),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-timedated
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-timedated
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TIMEDATED)$(BR2_PACKAGE_SYSTEMD_TIMESYNCD),yy)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-timesyncd
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-timesyncd
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_TMPFILES),y)
ROOTFS_DRACUT_MODULES_INCLUDE += systemd-tmpfiles
else
ROOTFS_DRACUT_MODULES_OMIT += systemd-tmpfiles
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_HWCLOCK),y)
ROOTFS_DRACUT_MODULES_INCLUDE += warpclock
else
ROOTFS_DRACUT_MODULES_OMIT += warpclock
endif

ifeq ($(BR2_PACKAGE_PLYMOUTH),y)
ROOTFS_DRACUT_DEPENDENCIES += plymouth
ROOTFS_DRACUT_MODULES_INCLUDE += plymouth
ROOTFS_DRACUT_FS_ENV += \
	PLYMOUTH_CONFDIR=$(ROOTFS_DRACUT_TARGET_DIR)/etc/plymouth \
	PLYMOUTH_DATADIR=$(ROOTFS_DRACUT_TARGET_DIR)//usr/share \
	PLYMOUTH_POLICYDIR=$(ROOTFS_DRACUT_TARGET_DIR)/usr/share/plymouth/ \
	PLYMOUTH_LOGO_FILE=$(ROOTFS_DRACUT_TARGET_DIR)/etc/plymouth/bizcom.png \
	PLYMOUTH_LIBEXECDIR=$(ROOTFS_DRACUT_TARGET_DIR)/usr/libexec \
	PLYMOUTH_LDD="$(HOST_DIR)/sbin/prelink-rtld --root=$(ROOTFS_DRACUT_TARGET_DIR)/" \
	PLYMOUTH_LDD_PATH=/bin/true \
	PLYMOUTH_PLUGIN_PATH=$(ROOTFS_DRACUT_TARGET_DIR)/usr/lib/plymouth \
	PLYMOUTH_THEME_NAME="spinner" \
	PLYMOUTH_THEME="spinner"
else
ROOTFS_DRACUT_MODULES_OMIT += plymouth
endif

ifeq ($(BR2_TARGET_ROOTFS_DRACUT_MOD_SIG),y)
ROOTFS_DRACUT_DEPENDENCIES += keyutils
ROOTFS_DRACUT_MODULES_INCLUDE += modsign
else
ROOTFS_DRACUT_MODULES_OMIT += modsign
endif

ROOTFS_DRACUT_KERNEL_MODULES = $(call qstrip,$(BR2_TARGET_ROOTFS_DRACUT_KERNEL_MODULES))
ROOTFS_DRACUT_MODULES_INCLUDE += $(call qstrip,$(BR2_TARGET_ROOTFS_DRACUT_MODULES))
ROOTFS_DRACUT_CUSTOM_KERNEL_CMDLINE = $(call qstrip,$(BR2_TARGET_ROOTFS_DRACUT_CUSTOM_KERNEL_CMDLINE))
ROOTFS_DRACUT_COMPRESSION_METHOD = $(call qstrip,$(BR2_TARGET_ROOTFS_DRACUT_COMPRESSION_METHOD))
ROOTFS_DRACUT_CONF_PATH = $(call qstrip,$(BR2_TARGET_ROOTFS_DRACUT_CONF_PATH))
ROOTFS_DRACUT_MKFS_CONF_OPTS += \
	--modules="$(ROOTFS_DRACUT_MODULES_INCLUDE)" \
	--omit="$(ROOTFS_DRACUT_MODULES_OMIT)" \
	--drivers=$(ROOTFS_DRACUT_KERNEL_MODULES) \
	--$(ROOTFS_DRACUT_COMPRESSION_METHOD)

ifneq ($(ROOTFS_DRACUT_CONF_PATH),)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --conf=$(ROOTFS_DRACUT_CONF_PATH)
endif

ifneq ($(ROOTFS_DRACUT_CUSTOM_KERNEL_CMDLINE),)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --kernel-cmdline=$(ROOTFS_DRACUT_CUSTOM_KERNEL_CMDLINE)
endif

ifeq ($(BR2_LINUX_KERNEL),y)
ROOTFS_DRACUT_KERNEL_IMAGE_PATH=$(BINARIES_DIR)/$(LINUX_TARGET_NAME)
ROOTFS_DRACUT_KERNEL_VERSION=$(LINUX_VERSION_PROBED)

ROOTFS_DRACUT_MKFS_CONF_OPTS += \
	--kver=$(ROOTFS_DRACUT_KERNEL_VERSION) \
	--kernel-image=$(ROOTFS_DRACUT_KERNEL_IMAGE_PATH) \
	--kmoddir="$(ROOTFS_DRACUT_TARGET_DIR)/lib/modules/$(ROOTFS_DRACUT_KERNEL_VERSION)"

ROOTFS_DRACUT_FS_ENV += KERNEL_VERSION=$(ROOTFS_DRACUT_KERNEL_VERSION)
ROOTFS_DRACUT_MODULES_INCLUDE += kernel-modules
endif

ifeq ($(BR2_TARGET_ROOTFS_DRACUT_HOST_ONLY),y)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --hostonly
ROOTFS_DRACUT_MKFS_CONF_OPTS += --no-hostonly-cmdline
ifeq ($(BR2_TARGET_ROOTFS_DRACUT_HOST_ONLY_SLOPPY),y)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --hostonly-mode=sloppy
else
ROOTFS_DRACUT_MKFS_CONF_OPTS += --hostonly-mode=strict
endif
else
ROOTFS_DRACUT_MKFS_CONF_OPTS += --no-hostonly
endif

ifeq ($(BR2_STRIP_strip),y)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --strip
else
ROOTFS_DRACUT_MKFS_CONF_OPTS += --nostrip
endif

ifeq ($(BR2_REPRODUCIBLE),y)
ROOTFS_DRACUT_MKFS_CONF_OPTS += --reproducible
else
ROOTFS_DRACUT_MKFS_CONF_OPTS += --no-reproducible
endif

define ROOTFS_DRACUT_CMD
	(mkdir -p $(ROOTFS_DRACUT_DIR)/rootfs.dracut.tmp && \
		$(ROOTFS_DRACUT_FS_ENV) \
		$(HOST_DIR)/bin/dracut \
		$(ROOTFS_DRACUT_MKFS_CONF_OPTS) \
		$(BINARIES_DIR)/rootfs.cpio)
endef

$(eval $(rootfs))
