################################################################################
#
# perl-eval-closure
#
################################################################################

PERL_EVAL_CLOSURE_VERSION = 0.14
PERL_EVAL_CLOSURE_SOURCE = Eval-Closure-$(PERL_EVAL_CLOSURE_VERSION).tar.gz
PERL_EVAL_CLOSURE_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DO/DOY
PERL_EVAL_CLOSURE_LICENSE = Artistic or GPL-1.0+
PERL_EVAL_CLOSURE_LICENSE_FILES = LICENSE
PERL_EVAL_CLOSURE_DISTNAME = Eval-Closure

$(eval $(perl-package))
