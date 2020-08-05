################################################################################
#
# duktape-pkgconfig
#
################################################################################

DUKTAPE_PC_VERSION = 2.5.0
DUKTAPE_PC_SITE = $(call github,svaarala,duktape-releases,v$(DUKTAPE_PC_VERSION))
DUKTAPE_PC_LICENSE = MIT
DUKTAPE_PC_LICENSE_FILES = LICENSE.txt
DUKTAPE_PC_INSTALL_STAGING = YES

define DUKTAPE_PC_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary
endef

define DUKTAPE_PC_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary \
		INSTALL_PREFIX=$(STAGING_DIR)/usr install
	$(INSTALL) -D -m 644 $(DUKTAPE_PC_PKGDIR)/duktape-pc.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/duktape.pc
endef

define DUKTAPE_PC_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary \
		INSTALL_PREFIX=$(TARGET_DIR)/usr install
	$(INSTALL) -D -m 644 $(DUKTAPE_PC_PKGDIR)/duktape-pc.pc \
		$(TARGET_DIR)/usr/lib/pkgconfig/duktape.pc
endef

$(eval $(generic-package))
