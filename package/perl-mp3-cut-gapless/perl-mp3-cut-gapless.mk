################################################################################
#
# perl-mp3_cut_gapless
#
################################################################################

PERL_MP3_CUT_GAPLESS_VERSION = 0.03
PERL_MP3_CUT_GAPLESS_SOURCE = MP3-Cut-Gapless-$(PERL_MP3_CUT_GAPLESS_VERSION).tar.gz
PERL_MP3_CUT_GAPLESS_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AG/AGRUNDMA
PERL_MP3_CUT_GAPLESS_LICENSE = Artistic or GPLv1+
PERL_MP3_CUT_GAPLESS_LICENSE_FILES = README

$(eval $(perl-package))
