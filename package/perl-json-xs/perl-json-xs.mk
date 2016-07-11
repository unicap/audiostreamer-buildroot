################################################################################
#
# perl-json-xs
#
################################################################################

PERL_JSON_XS_VERSION = 3.02
PERL_JSON_XS_SOURCE = JSON-XS-$(PERL_JSON_XS_VERSION).tar.gz
PERL_JSON_XS_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_JSON_XS_LICENSE = Artistic or GPLv1+
PERL_JSON_XS_LICENSE_FILES = README
PERL_JSON_XS_DEPENDENCIES = perl-types-serialiser

$(eval $(perl-package))
