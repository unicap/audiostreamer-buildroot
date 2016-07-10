################################################################################
#
# perl-extutils_cbuilder
#
################################################################################

PERL_EXTUTILS_CBUILDER_VERSION = 0.280224
PERL_EXTUTILS_CBUILDER_SOURCE = ExtUtils-CBuilder-$(PERL_EXTUTILS_CBUILDER_VERSION).tar.gz
PERL_EXTUTILS_CBUILDER_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AM/AMBS
PERL_EXTUTILS_CBUILDER_LICENSE = Artistic or GPLv1+
PERL_EXTUTILS_CBUILDER_LICENSE_FILES = README

$(eval $(perl-package))
