################################################################################
#
# perl-extutils_helpers
#
################################################################################

PERL_EXTUTILS_HELPERS_VERSION = 0.022
PERL_EXTUTILS_HELPERS_SOURCE = ExtUtils-Helpers-$(PERL_EXTUTILS_HELPERS_VERSION).tar.gz
PERL_EXTUTILS_HELPERS_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEONT
PERL_EXTUTILS_HELPERS_LICENSE = Artistic or GPLv1+
PERL_EXTUTILS_HELPERS_LICENSE_FILES = README

$(eval $(host-perl-package))
