################################################################################
#
# perl-datetime
#
################################################################################

PERL_DATETIME_VERSION = 1.54
PERL_DATETIME_SOURCE = DateTime-$(PERL_DATETIME_VERSION).tar.gz
PERL_DATETIME_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_DEPENDENCIES = perl-dist-checkconflicts
PERL_DATETIME_LICENSE = Artistic-2.0
PERL_DATETIME_LICENSE_FILES = LICENSE
PERL_DATETIME_DISTNAME = DateTime

$(eval $(perl-package))
