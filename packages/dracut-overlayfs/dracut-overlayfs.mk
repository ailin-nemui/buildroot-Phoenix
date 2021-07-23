################################################################################
#
# dracut-overlayfs
#
################################################################################

DRACUT_OVERLAYFS_VERSION = 2021-07-22
DRACUT_OVERLAYFS_SITE = https://git.lumina-sensum.com/LuminaSensum/dracut-overlayfs/archive
DRACUT_OVERLAYFS_SOURCE = $(DRACUT_OVERLAYFS_VERSION).tar.gz
DRACUT_OVERLAYFS_LICENSE = GPL-2.0
DRACUT_OVERLAYFS_LICENSE_FILES = COPYING
DRACUT_OVERLAYFS_DEPENDENCIES = dracut

define DRACUT_OVERLAYFS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/dracut/modules.d/90overlay
	$(INSTALL) -m 755 $(@D)/90overlay/*.sh \
		$(TARGET_DIR)/usr/lib/dracut/modules.d/90overlay
endef

$(eval $(generic-package))
