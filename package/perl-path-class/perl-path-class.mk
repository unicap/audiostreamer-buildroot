################################################################################
#
# perl-path_class
#
################################################################################

PERL_PATH_CLASS_VERSION = 0.36
PERL_PATH_CLASS_SOURCE = Path-Class-$(PERL_PATH_CLASS_VERSION).tar.gz
PERL_PATH_CLASS_SITE = $(BR2_CPAN_MIRROR)/authors/id/K/KW/KWILLIAMS
PERL_PATH_CLASS_LICENSE = Artistic or GPLv1+
PERL_PATH_CLASS_LICENSE_FILES = README

$(eval $(perl-package))
