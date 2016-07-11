################################################################################
#
# perl-tie_cache_lru_expires
#
################################################################################

PERL_TIE_CACHE_LRU_EXPIRES_VERSION = 0.55
PERL_TIE_CACHE_LRU_EXPIRES_SOURCE = Tie-Cache-LRU-Expires-$(PERL_TIE_CACHE_LRU_EXPIRES_VERSION).tar.gz
PERL_TIE_CACHE_LRU_EXPIRES_SITE = $(BR2_CPAN_MIRROR)/authors/id/O/OE/OESTERHOL
PERL_TIE_CACHE_LRU_EXPIRES_LICENSE = Artistic or GPLv1+
PERL_TIE_CACHE_LRU_EXPIRES_LICENSE_FILES = README

$(eval $(perl-package))
