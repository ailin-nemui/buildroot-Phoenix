################################################################################
#
# perl-params-validate
#
################################################################################

PERL_PARAMS_VALIDATE_VERSION = 1.30
PERL_PARAMS_VALIDATE_SOURCE = Params-Validate-$(PERL_PARAMS_VALIDATE_VERSION).tar.gz
PERL_PARAMS_VALIDATE_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_PARAMS_VALIDATE_DEPENDENCIES = host-perl-module-build
PERL_PARAMS_VALIDATE_LICENSE = Artistic-2.0
PERL_PARAMS_VALIDATE_LICENSE_FILES = LICENSE
PERL_PARAMS_VALIDATE_DISTNAME = Params-Validate

$(eval $(perl-package))
