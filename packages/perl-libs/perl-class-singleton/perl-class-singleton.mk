################################################################################
#
# perl-class-singleton
#
################################################################################

PERL_CLASS_SINGLETON_VERSION = 1.6
PERL_CLASS_SINGLETON_SOURCE = Class-Singleton-$(PERL_CLASS_SINGLETON_VERSION).tar.gz
PERL_CLASS_SINGLETON_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SH/SHAY
PERL_CLASS_SINGLETON_LICENSE = Artistic or GPL-1.0+
PERL_CLASS_SINGLETON_LICENSE_FILES = Artistic Copying LICENCE
PERL_CLASS_SINGLETON_DISTNAME = Class-Singleton

$(eval $(perl-package))
