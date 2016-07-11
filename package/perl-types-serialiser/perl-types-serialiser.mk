################################################################################
#
# perl-types_serialiser
#
################################################################################

PERL_TYPES_SERIALISER_VERSION = 1.0
PERL_TYPES_SERIALISER_SOURCE = Types-Serialiser-$(PERL_TYPES_SERIALISER_VERSION).tar.gz
PERL_TYPES_SERIALISER_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_TYPES_SERIALISER_LICENSE = Artistic or GPLv1+
PERL_TYPES_SERIALISER_LICENSE_FILES = README

$(eval $(perl-package))
