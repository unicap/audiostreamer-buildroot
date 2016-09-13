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
define PERL_FONT_FREETYPE_PRE_CONFIGURE_FIXUP
	(cd $(@D); sed -i s+freetype-config+$(STAGING_DIR)/usr/bin/freetype-config+g Makefile.PL)
endef
PERL_FONT_FREETYPE_PRE_CONFIGURE_HOOKS += PERL_FONT_FREETYPE_PRE_CONFIGURE_FIXUP

$(eval $(perl-package))
