################################################################################
#
# perl-mozilla-ca
#
################################################################################

PERL_MOZILLA_CA_VERSION = 20160104
PERL_MOZILLA_CA_SOURCE = Mozilla-CA-$(PERL_MOZILLA_CA_VERSION).tar.gz
PERL_MOZILLA_CA_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AB/ABH
PERL_MOZILLA_CA_LICENSE_FILES = README

$(eval $(perl-package))
