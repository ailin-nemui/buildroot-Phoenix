################################################################################
#
# perl-datetime-format-builder
#
################################################################################

PERL_DATETIME_FORMAT_BUILDER_VERSION = 0.83
PERL_DATETIME_FORMAT_BUILDER_SOURCE = DateTime-Format-Builder-$(PERL_DATETIME_FORMAT_BUILDER_VERSION).tar.gz
PERL_DATETIME_FORMAT_BUILDER_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DR/DROLSKY
PERL_DATETIME_FORMAT_BUILDER_LICENSE = Artistic-2.0
PERL_DATETIME_FORMAT_BUILDER_LICENSE_FILES = LICENSE
PERL_DATETIME_FORMAT_BUILDER_DISTNAME = DateTime-Format-Builder

$(eval $(perl-package))
