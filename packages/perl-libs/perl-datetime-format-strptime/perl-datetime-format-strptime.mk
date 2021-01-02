################################################################################
#
# perl-datetime-format-strptime
#
################################################################################

PERL_DATETIME_FORMAT_STRPTIME_VERSION = 1.77
PERL_DATETIME_FORMAT_STRPTIME_SOURCE = DateTime-Format-Strptime-$(PERL_DATETIME_FORMAT_STRPTIME_VERSION).tar.gz
PERL_DATETIME_FORMAT_STRPTIME_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_FORMAT_STRPTIME_LICENSE = Artistic-2.0
PERL_DATETIME_FORMAT_STRPTIME_LICENSE_FILES = LICENSE
PERL_DATETIME_FORMAT_STRPTIME_DISTNAME = DateTime-Format-Strptime

$(eval $(perl-package))
