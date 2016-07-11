################################################################################
#
# perl-extutils_installpaths
#
################################################################################

PERL_EXTUTILS_INSTALLPATHS_VERSION = 0.011
PERL_EXTUTILS_INSTALLPATHS_SOURCE = ExtUtils-InstallPaths-$(PERL_EXTUTILS_INSTALLPATHS_VERSION).tar.gz
PERL_EXTUTILS_INSTALLPATHS_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEONT
PERL_EXTUTILS_INSTALLPATHS_LICENSE = Artistic or GPLv1+
PERL_EXTUTILS_INSTALLPATHS_LICENSE_FILES = README

$(eval $(host-perl-package))
