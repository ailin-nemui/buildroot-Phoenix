################################################################################
#
# perl-exception-class
#
################################################################################

PERL_EXCEPTION_CLASS_VERSION = 1.44
PERL_EXCEPTION_CLASS_SOURCE = Exception-Class-$(PERL_EXCEPTION_CLASS_VERSION).tar.gz
PERL_EXCEPTION_CLASS_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_EXCEPTION_CLASS_LICENSE = Artistic or GPL-1.0+
PERL_EXCEPTION_CLASS_LICENSE_FILES = LICENSE
PERL_EXCEPTION_CLASS_DISTNAME = Exception-Class

$(eval $(perl-package))
