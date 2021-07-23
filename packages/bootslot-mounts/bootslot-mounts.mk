################################################################################
#
# bootslot-mounts
#
################################################################################

BOOTSLOT_MOUNTS_VERSION = 9ad4d7be9f7f22b31b070d1651c5935fc46e11a0
BOOTSLOT_MOUNTS_SITE = $(call github,KopisMobile,bootslot-mounts,$(BOOTSLOT_MOUNTS_VERSION))
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
