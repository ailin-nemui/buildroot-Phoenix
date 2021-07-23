################################################################################
#
# bootslot-mounts
#
################################################################################

BOOTSLOT_MOUNTS_VERSION = 2021-07-23
BOOTSLOT_MOUNTS_SITE = https://git.lumina-sensum.com/LuminaSensum/bootslot-mounts/archive
BOOTSLOT_MOUNTS_SOURCE = $(BOOTSLOT_MOUNTS_VERSION).tar.gz
BOOTSLOT_MOUNTS_LICENSE = GPL-3.0
BOOTSLOT_MOUNTS_LICENSE_FILES = LICENSE
BOOTSLOT_MOUNTS_DEPENDENCIES = systemd

define BOOTSLOT_MOUNTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bootslot-mounts \
	$(TARGET_DIR)/usr/lib/systemd/system-generators/bootslot-mounts
	$(INSTALL) -D -m 0644 $(BOOTSLOT_MOUNTS_PKGDIR)/sample_etc_bootslot-mounts.conf \
	$(TARGET_DIR)/etc/bootslot-mounts.conf
endef

$(eval $(generic-package))
