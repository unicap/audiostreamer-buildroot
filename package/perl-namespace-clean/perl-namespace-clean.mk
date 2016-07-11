################################################################################
#
# perl-namespace_clean
#
################################################################################

PERL_NAMESPACE_CLEAN_VERSION = 0.27
PERL_NAMESPACE_CLEAN_SOURCE = namespace-clean-$(PERL_NAMESPACE_CLEAN_VERSION).tar.gz
PERL_NAMESPACE_CLEAN_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RI/RIBASUSHI
PERL_NAMESPACE_CLEAN_LICENSE = Artistic or GPLv1+
PERL_NAMESPACE_CLEAN_LICENSE_FILES = README

$(eval $(perl-package))
