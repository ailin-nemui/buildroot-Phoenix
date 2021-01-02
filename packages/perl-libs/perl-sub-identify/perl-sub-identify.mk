################################################################################
#
# perl-sub-identify
#
################################################################################

PERL_SUB_IDENTIFY_VERSION = 0.14
PERL_SUB_IDENTIFY_SOURCE = Sub-Identify-$(PERL_SUB_IDENTIFY_VERSION).tar.gz
PERL_SUB_IDENTIFY_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RG/RGARCIA
PERL_SUB_IDENTIFY_LICENSE = Artistic or GPL-1.0+
PERL_SUB_IDENTIFY_DISTNAME = Sub-Identify

$(eval $(perl-package))
