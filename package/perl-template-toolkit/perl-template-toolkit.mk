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
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/Makefile
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/xs/Makefile
	sed "s~x86_64~$(KERNEL_ARCH)~" -i $(@D)/xs/Makefile
	sed "s~host/usr/lib~staging/usr/lib~" -i $(@D)/xs/Makefile
	$(MAKE) $(@D)/Makefile -C $(@D)
endef

$(eval $(perl-package))
