################################################################################
#
# LiFePo4wered-Pi
#
################################################################################

LIFEPO4WERED_PI_VERSION = c89ff52177e62c5a121a64c0c8b6d478529068f6
LIFEPO4WERED_PI_SITE = $(call github,xorbit,LiFePO4wered-Pi,$(LIFEPO4WERED_PI_VERSION))
LIFEPO4WERED_PI_SOURCE = LiFePO4wered-Pi-$(LIFEPO4WERED_PI_VERSION).tar.gz
LIFEPO4WERED_PI_LICENSE = GPL-2.0
LIFEPO4WERED_PI_LICENSE_FILES = LICENSE
LIFEPO4WERED_PI_DEPENDENCIES = systemd

define LIFEPO4WERED_PI_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define LIFEPO4WERED_PI_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR) -C $(@D)
endef

ifneq ($(BR2_INIT_SYSTEMD),y)
LIFEPO4WERED_PI_DEPENDENCIES -= systemd
LIFEPO4WERED_PI_MAKE_OPTS += USE_SYSTEMD=0
endif
$(eval $(generic-package))
