################################################################################
#
# perl-proc_background
#
################################################################################

PERL_PROC_BACKGROUND_VERSION = 1.10
PERL_PROC_BACKGROUND_SOURCE = Proc-Background-$(PERL_PROC_BACKGROUND_VERSION).tar.gz
PERL_PROC_BACKGROUND_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BZ/BZAJAC
PERL_PROC_BACKGROUND_LICENSE = Artistic or GPLv1+
PERL_PROC_BACKGROUND_LICENSE_FILES = README

$(eval $(perl-package))
