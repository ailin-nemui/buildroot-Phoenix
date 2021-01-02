################################################################################
#
# perl-params-validationcompiler
#
################################################################################

PERL_PARAMS_VALIDATIONCOMPILER_VERSION = 0.30
PERL_PARAMS_VALIDATIONCOMPILER_SOURCE = Params-ValidationCompiler-$(PERL_PARAMS_VALIDATIONCOMPILER_VERSION).tar.gz
PERL_PARAMS_VALIDATIONCOMPILER_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_PARAMS_VALIDATIONCOMPILER_LICENSE = Artistic-2.0
PERL_PARAMS_VALIDATIONCOMPILER_LICENSE_FILES = LICENSE
PERL_PARAMS_VALIDATIONCOMPILER_DISTNAME = Params-ValidationCompiler

$(eval $(perl-package))
