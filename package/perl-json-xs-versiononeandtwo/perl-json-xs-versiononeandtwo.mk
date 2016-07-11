################################################################################
#
# perl-json_xs_versiononeandtwo
#
################################################################################

PERL_JSON_XS_VERSIONONEANDTWO_VERSION = 0.31
PERL_JSON_XS_VERSIONONEANDTWO_SOURCE = JSON-XS-VersionOneAndTwo-$(PERL_JSON_XS_VERSIONONEANDTWO_VERSION).tar.gz
PERL_JSON_XS_VERSIONONEANDTWO_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LB/LBROCARD
PERL_JSON_XS_VERSIONONEANDTWO_LICENSE = Artistic or GPLv1+
PERL_JSON_XS_VERSIONONEANDTWO_LICENSE_FILES = README

$(eval $(perl-package))
