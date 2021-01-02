################################################################################
#
# perl-specio
#
################################################################################

PERL_SPECIO_VERSION = 0.46
PERL_SPECIO_SOURCE = Specio-$(PERL_SPECIO_VERSION).tar.gz
PERL_SPECIO_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_SPECIO_LICENSE = Artistic-2.0
PERL_SPECIO_LICENSE_FILES = LICENSE
PERL_SPECIO_DISTNAME = Specio

$(eval $(perl-package))
