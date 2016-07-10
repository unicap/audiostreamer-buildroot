################################################################################
#
# perl-ev
#
################################################################################

PERL_EV_VERSION = 4.22
PERL_EV_SOURCE = EV-$(PERL_EV_VERSION).tar.gz
PERL_EV_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_EV_LICENSE = Artistic or GPLv1+
PERL_EV_LICENSE_FILES = README
PERL_EV_DEPENDENCIES = libev host-perl-canary-stability

$(eval $(perl-package))
