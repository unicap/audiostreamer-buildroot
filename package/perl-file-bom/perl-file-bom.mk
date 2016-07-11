################################################################################
#
# perl-file_bom
#
################################################################################

PERL_FILE_BOM_VERSION = 0.15
PERL_FILE_BOM_SOURCE = File-BOM-$(PERL_FILE_BOM_VERSION).tar.gz
PERL_FILE_BOM_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MA/MATTLAW
PERL_FILE_BOM_LICENSE = Artistic or GPLv1+
PERL_FILE_BOM_LICENSE_FILES = README
PERL_FILE_BOM_DEPENDENCIES = perl-readonly

$(eval $(perl-package))
