################################################################################
#
# perl-devel_checklib
#
################################################################################

PERL_DEVEL_CHECKLIB_VERSION = 1.07
PERL_DEVEL_CHECKLIB_SOURCE = Devel-CheckLib-$(PERL_DEVEL_CHECKLIB_VERSION).tar.gz
PERL_DEVEL_CHECKLIB_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MA/MATTN
PERL_DEVEL_CHECKLIB_LICENSE = Artistic or GPLv1+
PERL_DEVEL_CHECKLIB_LICENSE_FILES = README

$(eval $(host-perl-package))
