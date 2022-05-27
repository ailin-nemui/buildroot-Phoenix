################################################################################
#
# irssi-git
#
################################################################################

IRSSI_GIT_VERSION = 3a3b77194ac592bb68d84dbf417b23ed8c29f505
IRSSI_GIT_SITE = $(call github,ailin-nemui,irssi,$(IRSSI_GIT_VERSION))
IRSSI_GIT_LICENSE = GPL-2.0+
IRSSI_GIT_LICENSE_FILES = COPYING
IRSSI_GIT_DEPENDENCIES = host-pkgconf libglib2 ncurses openssl

IRSSI_GIT_CONF_OPTS = \
	-Dinstall-glib=no

ifeq ($(BR2_PACKAGE_IRSSI_GIT_LIBOTR),y)
IRSSI_GIT_DEPENDENCIES += libotr
IRSSI_GIT_CONF_OPTS += -Dwith-otr=yes
else
IRSSI_GIT_CONF_OPTS += -Dwith-otr=no
endif # libotr

ifeq ($(BR2_PACKAGE_IRSSI_GIT_PERL),y)
IRSSI_GIT_DEPENDENCIES += perl
IRSSI_GIT_CONF_OPTS += -Dwith-perl=yes \
	-Dwith-perl-lib=site
IRSSI_GIT_MESON_EXTRA_BINARIES += perl=['$(STAGING_DIR)/usr/bin/miniperl','-I$(STAGING_DIR)/usr/lib/perl5/$(PERL_VERSION)/$(PERL_ARCHNAME)','-I$(STAGING_DIR)/usr/lib/perl5/$(PERL_VERSION)']
else
IRSSI_GIT_CONF_OPTS += -Dwith-perl=no
endif # perl

ifeq ($(BR2_PACKAGE_IRSSI_GIT_PROXY),y)
IRSSI_GIT_CONF_OPTS += -Dwith-proxy=yes
else
IRSSI_GIT_CONF_OPTS += -Dwith-proxy=no
endif # proxy

$(eval $(meson-package))
