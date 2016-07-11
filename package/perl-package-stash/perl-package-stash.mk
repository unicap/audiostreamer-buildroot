################################################################################
#
# perl-package_stash
#
################################################################################

PERL_PACKAGE_STASH_VERSION = 0.37
PERL_PACKAGE_STASH_SOURCE = Package-Stash-$(PERL_PACKAGE_STASH_VERSION).tar.gz
PERL_PACKAGE_STASH_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DO/DOY
PERL_PACKAGE_STASH_LICENSE = Artistic or GPLv1+
PERL_PACKAGE_STASH_LICENSE_FILES = README

$(eval $(perl-package))
