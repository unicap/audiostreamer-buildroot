################################################################################
#
# perl-compress-raw-zlib
#
################################################################################

PERL_COMPRESS_RAW_ZLIB_VERSION = 2.069
PERL_COMPRESS_RAW_ZLIB_SOURCE = Compress-Raw-Zlib-$(PERL_COMPRESS_RAW_ZLIB_VERSION).tar.gz
PERL_COMPRESS_RAW_ZLIB_SITE = $(BR2_CPAN_MIRROR)/authors/id/P/PM/PMQS
PERL_COMPRESS_RAW_ZLIB_LICENSE = Artistic or GPLv1+
PERL_COMPRESS_RAW_ZLIB_LICENSE_FILES = README

$(eval $(perl-package))
