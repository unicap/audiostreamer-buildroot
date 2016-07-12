################################################################################
#
# perl-xml-parser
#
################################################################################

PERL_XML_PARSER_VERSION = 2.44
PERL_XML_PARSER_SOURCE = XML-Parser-$(PERL_XML_PARSER_VERSION).tar.gz
PERL_XML_PARSER_SITE = $(BR2_CPAN_MIRROR)/authors/id/T/TO/TODDR
PERL_XML_PARSER_DEPENDENCIES = perl-libwww-perl
PERL_XML_PARSER_LICENSE = Artistic or GPLv1+
PERL_XML_PARSER_LICENSE_FILES = README

define PERL_XML_PARSER_BUILD_CMDS
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/Makefile
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/Expat/Makefile
	sed "s~x86_64~$(KERNEL_ARCH)~" -i $(@D)/Expat/Makefile
	sed "s~host/usr/lib~staging/usr/lib~" -i $(@D)/Expat/Makefile
	$(MAKE) $(@D)/Makefile -C $(@D)
endef

$(eval $(perl-package))
