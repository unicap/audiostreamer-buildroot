################################################################################
#
# perl-file_next
#
################################################################################

PERL_FILE_NEXT_VERSION = 1.16
PERL_FILE_NEXT_SOURCE = File-Next-$(PERL_FILE_NEXT_VERSION).tar.gz
PERL_FILE_NEXT_SITE = $(BR2_CPAN_MIRROR)/authors/id/P/PE/PETDANCE
PERL_FILE_NEXT_LICENSE = Artistic or GPLv1+
PERL_FILE_NEXT_LICENSE_FILES = README

$(eval $(perl-package))
