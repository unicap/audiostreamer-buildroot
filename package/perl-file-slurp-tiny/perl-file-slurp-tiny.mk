################################################################################
#
# perl-file_slurp_tiny
#
################################################################################

PERL_FILE_SLURP_TINY_VERSION = 0.004
PERL_FILE_SLURP_TINY_SOURCE = File-Slurp-Tiny-$(PERL_FILE_SLURP_TINY_VERSION).tar.gz
PERL_FILE_SLURP_TINY_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEONT
PERL_FILE_SLURP_TINY_LICENSE = Artistic or GPLv1+
PERL_FILE_SLURP_TINY_LICENSE_FILES = README

$(eval $(host-perl-package))
$(eval $(perl-package))
