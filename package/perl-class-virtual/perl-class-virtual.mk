################################################################################
#
# perl-class_virtual
#
################################################################################

PERL_CLASS_VIRTUAL_VERSION = 0.07
PERL_CLASS_VIRTUAL_SOURCE = Class-Virtual-$(PERL_CLASS_VIRTUAL_VERSION).tar.gz
PERL_CLASS_VIRTUAL_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MS/MSCHWERN
PERL_CLASS_VIRTUAL_LICENSE = Artistic or GPLv1+
PERL_CLASS_VIRTUAL_LICENSE_FILES = README
PERL_CLASS_VIRTUAL_DEPENDENCIES = perl-class-isa

$(eval $(perl-package))
