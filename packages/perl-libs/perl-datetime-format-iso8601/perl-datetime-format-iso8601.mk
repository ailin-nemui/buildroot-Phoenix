################################################################################
#
# perl-datetime-format-iso8601
#
################################################################################

PERL_DATETIME_FORMAT_ISO8601_VERSION = 0.15
PERL_DATETIME_FORMAT_ISO8601_SOURCE = DateTime-Format-ISO8601-$(PERL_DATETIME_FORMAT_ISO8601_VERSION).tar.gz
PERL_DATETIME_FORMAT_ISO8601_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_FORMAT_ISO8601_LICENSE = Artistic or GPL-1.0+
PERL_DATETIME_FORMAT_ISO8601_LICENSE_FILES = LICENSE
PERL_DATETIME_FORMAT_ISO8601_DISTNAME = DateTime-Format-ISO8601

$(eval $(perl-package))
