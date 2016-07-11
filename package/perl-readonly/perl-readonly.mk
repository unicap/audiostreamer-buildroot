################################################################################
#
# perl-readonly
#
################################################################################

PERL_READONLY_VERSION = 2.05
PERL_READONLY_SOURCE = Readonly-$(PERL_READONLY_VERSION).tar.gz
PERL_READONLY_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SA/SANKO
PERL_READONLY_LICENSE = Artistic or GPLv1+
PERL_READONLY_LICENSE_FILES = README
PERL_READONLY_DEPENDENCIES = host-perl-module-build-tiny host-perl-extutils-config host-perl-extutils-helpers host-perl-extutils-installpaths

$(eval $(perl-package))
