################################################################################
#
# libotr
#
################################################################################

LIBOTR_VERSION = 4.1.1
LIBOTR_SITE = https://otr.cypherpunks.ca
LIBOTR_LICENSE = LGPL
LIBOTR_LICENSE_FILES = COPYING COPYING.LIB
LIBOTR_DEPENDENCIES = libgcrypt libgpg-error
LIBOTR_INSTALL_STAGING = YES
LIBOTR_AUTORECONF = YES
LIBOTR_CONF_ENV += LIBGCRYPT_CONFIG="$(STAGING_DIR)/usr/bin/libgcrypt-config"
#LIBOTR_CONF_OPTS = \
#	--oldincludedir=$(STAGING_DIR)/usr/include \
#	--includedir=$(STAGING_DIR)/usr/include

$(eval $(autotools-package))
