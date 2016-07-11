################################################################################
#
# perl-xml_simple
#
################################################################################

PERL_XML_SIMPLE_VERSION = 2.22
PERL_XML_SIMPLE_SOURCE = XML-Simple-$(PERL_XML_SIMPLE_VERSION).tar.gz
PERL_XML_SIMPLE_SITE = $(BR2_CPAN_MIRROR)/authors/id/G/GR/GRANTM
PERL_XML_SIMPLE_LICENSE = Artistic or GPLv1+
PERL_XML_SIMPLE_LICENSE_FILES = README

$(eval $(perl-package))
