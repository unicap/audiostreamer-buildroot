################################################################################
#
# perl-file_slurp
#
################################################################################

PERL_FILE_SLURP_VERSION = 9999.19
PERL_FILE_SLURP_SOURCE = File-Slurp-$(PERL_FILE_SLURP_VERSION).tar.gz
PERL_FILE_SLURP_SITE = $(BR2_CPAN_MIRROR)/authors/id/U/UR/URI
PERL_FILE_SLURP_LICENSE = Artistic or GPLv1+
PERL_FILE_SLURP_LICENSE_FILES = README

$(eval $(perl-package))
