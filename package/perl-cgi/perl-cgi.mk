################################################################################
#
# perl-cgi
#
################################################################################

PERL_CGI_VERSION = 4.31
PERL_CGI_SOURCE = CGI-$(PERL_CGI_VERSION).tar.gz
PERL_CGI_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LE/LEEJO
PERL_CGI_LICENSE = Artistic or GPLv1+
PERL_CGI_LICENSE_FILES = README

$(eval $(perl-package))
