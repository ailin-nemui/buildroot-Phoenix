################################################################################
#
# openssh-systemd
#
################################################################################

OPENSSH_SYSTEMD_VERSION = 8.2p1
OPENSSH_SYSTEMD_SITE = http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable
OPENSSH_SYSTEMD_SOURCE = openssh-$(OPENSSH_SYSTEMD_VERSION).tar.gz
OPENSSH_SYSTEMD_LICENSE = BSD-3-Clause, BSD-2-Clause, Public Domain
OPENSSH_SYSTEMD_LICENSE_FILES = LICENCE
OPENSSH_SYSTEMD_CONF_ENV = \
	LD="$(TARGET_CC)" \
	LDFLAGS="$(TARGET_CFLAGS)" \
	LIBS=`$(PKG_CONFIG_HOST_BINARY) --libs openssl`
OPENSSH_SYSTEMD_CONF_OPTS = \
	--sysconfdir=/etc/ssh \
	--with-default-path=$(BR2_SYSTEM_DEFAULT_PATH) \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-strip \
	--with-lastlog=/var/log/lastlog

define OPENSSH_SYSTEMD_PERMISSIONS
	/var/empty d 755 root root - - - - -
endef

ifeq ($(BR2_TOOLCHAIN_SUPPORTS_PIE),)
OPENSSH_SYSTEMD_CONF_OPTS += --without-pie
endif

OPENSSH_SYSTEMD_DEPENDENCIES = host-pkgconf zlib openssl

ifeq ($(BR2_INIT_SYSTEMD),y)
OPENSSH_SYSTEMD_DEPENDENCIES += systemd
OPENSSH_SYSTEMD_CONF_OPTS += --with-systemd
endif

# --with-systemd option requires reconfigure
OPENSSH_SYSTEMD_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_CRYPTODEV_LINUX),y)
OPENSSH_SYSTEMD_DEPENDENCIES += cryptodev-linux
OPENSSH_SYSTEMD_CONF_OPTS += --with-ssl-engine
else
OPENSSH_SYSTEMD_CONF_OPTS += --without-ssl-engine
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
define OPENSSH_SYSTEMD_INSTALL_PAM_CONF
	$(INSTALL) -D -m 644 $(@D)/contrib/sshd.pam.generic $(TARGET_DIR)/etc/pam.d/sshd
	$(SED) '\%password   required     /lib/security/pam_cracklib.so%d' $(TARGET_DIR)/etc/pam.d/sshd
	$(SED) 's/\#UsePAM no/UsePAM yes/' $(TARGET_DIR)/etc/ssh/sshd_config
endef

OPENSSH_SYSTEMD_DEPENDENCIES += linux-pam
OPENSSH_SYSTEMD_CONF_OPTS += --with-pam
OPENSSH_SYSTEMD_POST_INSTALL_TARGET_HOOKS += OPENSSH_SYSTEMD_INSTALL_PAM_CONF
else
OPENSSH_SYSTEMD_CONF_OPTS += --without-pam
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
OPENSSH_SYSTEMD_DEPENDENCIES += libselinux
OPENSSH_SYSTEMD_CONF_OPTS += --with-selinux
else
OPENSSH_SYSTEMD_CONF_OPTS += --without-selinux
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS),y)
define OPENSSH_SYSTEMD_INSTALL_SYSTEMD_SYSUSERS
	$(INSTALL) -m 0644 -D package/openssh/sshd-sysusers.conf \
		$(TARGET_DIR)/usr/lib/sysusers.d/sshd.conf
endef
else
define OPENSSH_SYSTEMD_USERS
	sshd -1 sshd -1 * /var/empty - - SSH drop priv user
endef
endif

define OPENSSH_SYSTEMD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/openssh/sshd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/sshd.service
	$(OPENSSH_SYSTEMD_INSTALL_SYSTEMD_SYSUSERS)
endef

define OPENSSH_SYSTEMD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/openssh/S50sshd \
		$(TARGET_DIR)/etc/init.d/S50sshd
endef

define OPENSSH_SYSTEMD_INSTALL_SSH_COPY_ID
	$(INSTALL) -D -m 755 $(@D)/contrib/ssh-copy-id $(TARGET_DIR)/usr/bin/ssh-copy-id
endef

OPENSSH_SYSTEMD_POST_INSTALL_TARGET_HOOKS += OPENSSH_SYSTEMD_INSTALL_SSH_COPY_ID

$(eval $(autotools-package))
