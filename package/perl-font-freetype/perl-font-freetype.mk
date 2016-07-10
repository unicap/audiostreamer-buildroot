################################################################################
#
# perl-font_freetype
#
################################################################################

PERL_FONT_FREETYPE_VERSION = 0.07
PERL_FONT_FREETYPE_SOURCE = Font-FreeType-$(PERL_FONT_FREETYPE_VERSION).tar.gz
PERL_FONT_FREETYPE_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DM/DMOL
PERL_FONT_FREETYPE_LICENSE = Artistic or GPLv1+
PERL_FONT_FREETYPE_LICENSE_FILES = README
PERL_FONT_FREETYPE_DEPENDENCIES = freetype host-perl-devel-checklib host-perl-file-which

$(eval $(perl-package))
