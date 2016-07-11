################################################################################
#
# perl-yaml_xs
#
################################################################################

PERL_YAML_XS_VERSION = 0.63
PERL_YAML_XS_SOURCE = YAML-LibYAML-$(PERL_YAML_XS_VERSION).tar.gz
PERL_YAML_XS_SITE = $(BR2_CPAN_MIRROR)/authors/id/T/TI/TINITA
PERL_YAML_XS_LICENSE = Artistic or GPLv1+
PERL_YAML_XS_LICENSE_FILES = README

define PERL_YAML_XS_BUILD_CMDS
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/Makefile
	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/LibYAML/Makefile
	sed "s~x86_64~$(KERNEL_ARCH)~" -i $(@D)/LibYAML/Makefile
	sed "s~host/usr/lib~staging/usr/lib~" -i $(@D)/LibYAML/Makefile
	$(MAKE) $(@D)/Makefile -C $(@D)
endef

$(eval $(perl-package))
