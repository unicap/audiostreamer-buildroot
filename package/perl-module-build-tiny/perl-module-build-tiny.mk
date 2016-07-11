################################################################################
#
# perl-module_build_tiny
#
################################################################################

PERL_MODULE_BUILD_TINY_VERSION = 0.039
PERL_MODULE_BUILD_TINY_SOURCE = Module-Build-Tiny-$(PERL_MODULE_BUILD_TINY_VERSION).tar.gz
PERL_MODULE_BUILD_TINY_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEONT
PERL_MODULE_BUILD_TINY_LICENSE = Artistic or GPLv1+
PERL_MODULE_BUILD_TINY_LICENSE_FILES = README
PERL_MODULE_BUILD_TINY_DEPENDENCIES = 

$(eval $(host-perl-package))
