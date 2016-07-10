################################################################################
#
# perl-sub_uplevel
#
################################################################################

PERL_SUB_UPLEVEL_VERSION = 0.25
PERL_SUB_UPLEVEL_SOURCE = Sub-Uplevel-$(PERL_SUB_UPLEVEL_VERSION).tar.gz
PERL_SUB_UPLEVEL_SITE = $(BR2_CPAN_MIRROR)/authors/id/D/DA/DAGOLDEN
PERL_SUB_UPLEVEL_LICENSE = Artistic or GPLv1+
PERL_SUB_UPLEVEL_LICENSE_FILES = README

$(eval $(perl-package))
