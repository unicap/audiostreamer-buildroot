################################################################################
#
# perl-archive-zip
#
################################################################################

PERL_ARCHIVE_ZIP_VERSION = 1.57
PERL_ARCHIVE_ZIP_SOURCE = Archive-Zip-$(PERL_ARCHIVE_ZIP_VERSION).tar.gz
PERL_ARCHIVE_ZIP_SITE = $(BR2_CPAN_MIRROR)/authors/id/P/PH/PHRED
PERL_ARCHIVE_ZIP_LICENSE = Artistic or GPLv1+

$(eval $(perl-package))
