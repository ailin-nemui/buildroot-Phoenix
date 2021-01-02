################################################################################
#
# perl-datetime-locale
#
################################################################################

PERL_DATETIME_LOCALE_VERSION = 1.28
PERL_DATETIME_LOCALE_SOURCE = DateTime-Locale-$(PERL_DATETIME_LOCALE_VERSION).tar.gz
PERL_DATETIME_LOCALE_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_LOCALE_DEPENDENCIES = \
	host-perl-file-sharedir-install
PERL_DATETIME_LOCALE_LICENSE = Artistic or GPL-1.0+
PERL_DATETIME_LOCALE_LICENSE_FILES = LICENSE LICENSE.cldr
PERL_DATETIME_LOCALE_DISTNAME = DateTime-Locale

$(eval $(perl-package))
