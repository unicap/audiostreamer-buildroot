################################################################################
#
# perl-text_unidecode
#
################################################################################

PERL_TEXT_UNIDECODE_VERSION = 1.27
PERL_TEXT_UNIDECODE_SOURCE = Text-Unidecode-$(PERL_TEXT_UNIDECODE_VERSION).tar.gz
PERL_TEXT_UNIDECODE_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SB/SBURKE
PERL_TEXT_UNIDECODE_LICENSE = Artistic or GPLv1+
PERL_TEXT_UNIDECODE_LICENSE_FILES = README

$(eval $(perl-package))
