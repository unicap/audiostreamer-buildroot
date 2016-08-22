################################################################################
#
# swh-ladspa-plugins
#
################################################################################

SWH_LADSPA_PLUGINS_VERSION = 110374f69c4ce30d38b50b99a92d0420d8753f15
SWH_LADSPA_PLUGINS_SITE = $(call github,swh,ladspa,$(SWH_LADSPA_PLUGINS_VERSION))
SWH_LADSPA_PLUGINS_LICENSE = GPLv2
SWH_LADSPA_PLUGINS_LICENSE_FILES = COPYING
SWH_LADSPA_PLUGINS_DEPENDENCIES = gettext
SWH_LADSPA_PLUGINS_AUTORECONF = YES
SWH_LADSPA_PLUGINS_AUTORECONF_OPTS = -i -I m4

define SWH_LADSPA_PLUGINS_PRE_CONFIGURE_FIXUP
	mkdir -p $(@D)/m4
	touch $(@D)/config.rpath
	(cd $(@D) && $(HOST_DIR)/usr/bin/intltoolize)
endef

SWH_LADSPA_PLUGINS_PRE_CONFIGURE_HOOKS += SWH_LADSPA_PLUGINS_PRE_CONFIGURE_FIXUP

$(eval $(autotools-package))
