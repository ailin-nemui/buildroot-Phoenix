################################################################################
#
# perl-namespace-autoclean
#
################################################################################

PERL_NAMESPACE_AUTOCLEAN_VERSION = 0.29
PERL_NAMESPACE_AUTOCLEAN_SOURCE = namespace-autoclean-$(PERL_NAMESPACE_AUTOCLEAN_VERSION).tar.gz
PERL_NAMESPACE_AUTOCLEAN_SITE = $(BR2_CPAN_MIRROR)/authors/id/E/ET/ETHER
PERL_NAMESPACE_AUTOCLEAN_LICENSE = Artistic or GPL-1.0+
PERL_NAMESPACE_AUTOCLEAN_LICENSE_FILES = LICENCE
PERL_NAMESPACE_AUTOCLEAN_DISTNAME = namespace-autoclean

$(eval $(perl-package))
