################################################################################
#
# perl-moo
#
################################################################################

PERL_MOO_VERSION = 2.002004
PERL_MOO_SOURCE = Moo-$(PERL_MOO_VERSION).tar.gz
PERL_MOO_SITE = $(BR2_CPAN_MIRROR)/authors/id/H/HA/HAARG
PERL_MOO_LICENSE = Artistic or GPLv1+
PERL_MOO_LICENSE_FILES = README

$(eval $(perl-package))
