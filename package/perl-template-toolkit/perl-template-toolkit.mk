################################################################################
#
# perl-template_toolkit
#
################################################################################

PERL_TEMPLATE_TOOLKIT_VERSION = 2.26
PERL_TEMPLATE_TOOLKIT_SOURCE = Template-Toolkit-$(PERL_TEMPLATE_TOOLKIT_VERSION).tar.gz
PERL_TEMPLATE_TOOLKIT_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AB/ABW
PERL_TEMPLATE_TOOLKIT_LICENSE = Artistic or GPLv1+
PERL_TEMPLATE_TOOLKIT_LICENSE_FILES = README

define PERL_TEMPLATE_TOOLKIT_BUILD_CMDS
	sed "s~/usr/bin/gcc~$(TARGET_CC)~" $(@D)/Makefile > $(@D)/Makefile.tmp
	mv $(@D)/Makefile.tmp $(@D)/Makefile
	sed "s~/usr/bin/gcc~$(TARGET_CC)~" $(@D)/xs/Makefile > $(@D)/xs/Makefile.tmp
	mv $(@D)/xs/Makefile.tmp $(@D)/xs/Makefile
	$(MAKE) $(@D)/Makefile -C $(@D)
endef

$(eval $(perl-package))
