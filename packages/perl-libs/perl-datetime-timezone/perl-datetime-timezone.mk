################################################################################
#
# perl-datetime-timezone
#
################################################################################

PERL_DATETIME_TIMEZONE_VERSION = 2.44
PERL_DATETIME_TIMEZONE_SOURCE = DateTime-TimeZone-$(PERL_DATETIME_TIMEZONE_VERSION).tar.gz
PERL_DATETIME_TIMEZONE_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_TIMEZONE_LICENSE = Artistic or GPL-1.0+
PERL_DATETIME_TIMEZONE_LICENSE_FILES = LICENSE
PERL_DATETIME_TIMEZONE_DISTNAME = DateTime-TimeZone

$(eval $(perl-package))
