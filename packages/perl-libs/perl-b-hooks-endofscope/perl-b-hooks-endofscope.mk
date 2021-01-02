################################################################################
#
# perl-b-hooks-endofscope
#
################################################################################

PERL_B_HOOKS_ENDOFSCOPE_VERSION = 0.24
PERL_B_HOOKS_ENDOFSCOPE_SOURCE = B-Hooks-EndOfScope-$(PERL_B_HOOKS_ENDOFSCOPE_VERSION).tar.gz
PERL_B_HOOKS_ENDOFSCOPE_SITE = $(BR2_CPAN_MIRROR)/authors/id/E/ET/ETHER
PERL_B_HOOKS_ENDOFSCOPE_LICENSE = Artistic or GPL-1.0+
PERL_B_HOOKS_ENDOFSCOPE_LICENSE_FILES = LICENCE
PERL_B_HOOKS_ENDOFSCOPE_DISTNAME = B-Hooks-EndOfScope

$(eval $(perl-package))
