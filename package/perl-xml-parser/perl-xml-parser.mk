################################################################################
#
# perl-xml_parser
#
################################################################################

PERL_XML_PARSER_VERSION = 2.44
PERL_XML_PARSER_SOURCE = XML-Parser-$(PERL_XML_PARSER_VERSION).tar.gz
PERL_XML_PARSER_SITE = $(BR2_CPAN_MIRROR)/authors/id/T/TO/TODDR
PERL_XML_PARSER_LICENSE = Artistic or GPLv1+
PERL_XML_PARSER_LICENSE_FILES = README

define PERL_XML_PARSER_BUILD_CMDS
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" $(@D)/Makefile > $(@D)/Makefile.tmp
	mv $(@D)/Makefile.tmp $(@D)/Makefile
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" $(@D)/Expat/Makefile > $(@D)/Expat/Makefile.tmp
	mv $(@D)/Expat/Makefile.tmp $(@D)/Expat/Makefile
	$(MAKE) $(@D)/Makefile -C $(@D)
endef


$(eval $(perl-package))
