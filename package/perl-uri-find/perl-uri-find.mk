################################################################################
#
# perl-uri_find
#
################################################################################

PERL_URI_FIND_VERSION = 20140709
PERL_URI_FIND_SOURCE = URI-Find-$(PERL_URI_FIND_VERSION).tar.gz
PERL_URI_FIND_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MS/MSCHWERN
PERL_URI_FIND_LICENSE = Artistic or GPLv1+
PERL_URI_FIND_LICENSE_FILES = README

$(eval $(perl-package))
