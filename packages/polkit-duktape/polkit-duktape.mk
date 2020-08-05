################################################################################
#
# polkit-duktape
#
################################################################################

POLKIT_DUKTAPE_VERSION = 0.116
POLKIT_DUKTAPE_SITE = http://www.freedesktop.org/software/polkit/releases
POLKIT_DUKTAPE_SOURCE = polkit-$(POLKIT_DUKTAPE_VERSION).tar.gz
POLKIT_DUKTAPE_LICENSE = GPL-2.0
POLKIT_DUKTAPE_LICENSE_FILES = COPYING
POLKIT_DUKTAPE_AUTORECONF = YES
POLKIT_DUKTAPE_INSTALL_STAGING = YES

POLKIT_DUKTAPE_DEPENDENCIES = \
	libglib2 host-intltool expat duktape-pc $(TARGET_NLS_DEPENDENCIES)

# spidermonkey needs C++11
POLKIT_DUKTAPE_CONF_ENV = \
#	CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11" \
	LIBS=$(TARGET_NLS_LIBS)

POLKIT_DUKTAPE_CONF_OPTS = \
	--with-os-type=unknown \
	--disable-man-pages \
	--disable-examples \
	--disable-libelogind \
	--disable-libsystemd-login \
	--with-duktape

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
POLKIT_DUKTAPE_CONF_OPTS += --enable-introspection
POLKIT_DUKTAPE_DEPENDENCIES += gobject-introspection
else
POLKIT_DUKTAPE_CONF_OPTS += --disable-introspection
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
POLKIT_DUKTAPE_DEPENDENCIES += linux-pam
POLKIT_DUKTAPE_CONF_OPTS += --with-authfw=pam
else
POLKIT_DUKTAPE_CONF_OPTS += --with-authfw=shadow
endif

define POLKIT_DUKTAPE_USERS
	polkitd -1 polkitd -1 * - - - Polkit Daemon
endef

define POLKIT_DUKTAPE_PERMISSIONS
	/etc/polkit-1 r 750 root polkitd - - - - -
	/usr/share/polkit-1 r 750 root polkitd - - - - -
	/usr/bin/pkexec f 4755 root root - - - - -
endef

define POLKIT_DUKTAPE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(POLKIT_DUKTAPE_PKGDIR)/polkit.service \
		$(TARGET_DIR)/usr/lib/systemd/system/polkit.service

endef

$(eval $(autotools-package))
