################################################################################
#
# perl-class_accessor_fast
#
################################################################################

PERL_CLASS_ACCESSOR_FAST_VERSION = 0.34
PERL_CLASS_ACCESSOR_FAST_SOURCE = Class-Accessor-$(PERL_CLASS_ACCESSOR_FAST_VERSION).tar.gz
PERL_CLASS_ACCESSOR_FAST_SITE = $(BR2_CPAN_MIRROR)/authors/id/K/KA/KASEI
PERL_CLASS_ACCESSOR_FAST_LICENSE = Artistic or GPLv1+
PERL_CLASS_ACCESSOR_FAST_LICENSE_FILES = README

$(eval $(perl-package))
