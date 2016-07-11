################################################################################
#
# perl-anyevent
#
################################################################################

PERL_ANYEVENT_VERSION = 7.12
PERL_ANYEVENT_SOURCE = AnyEvent-$(PERL_ANYEVENT_VERSION).tar.gz
PERL_ANYEVENT_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_ANYEVENT_LICENSE = Artistic or GPLv1+
PERL_ANYEVENT_LICENSE_FILES = README

$(eval $(perl-package))
