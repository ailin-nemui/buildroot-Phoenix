################################################################################
#
# disabled-services
#
################################################################################

DISABLED_SERVICES_VERSION = local
DISABLED_SERVICES_SITE = $(DISABLED_SERVICES_PKGDIR)/.
DISABLED_SERVICES_SITE_METHOD = local

define DISABLED_SERVICES_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/etc/systemd/system-preset
	$(INSTALL) -D -m 0644 $(DISABLED_SERVICES_PKGDIR)/70-disabled.preset \
		$(TARGET_DIR)/etc/systemd/system-preset/70-disabled.preset
endef
$(eval $(generic-package))
