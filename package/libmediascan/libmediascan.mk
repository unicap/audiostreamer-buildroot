################################################################################
#
# libmediascan
#
################################################################################

LIBMEDIASCAN_VERSION = 0.1
LIBMEDIASCAN_SOURCE = libmediascan-$(LIBMEDIASCAN_VERSION).tar.gz
LIBMEDIASCAN_SITE = https://github.com/Logitech/slimserver-vendor/raw/public/7.9/CPAN
LIBMEDIASCAN_INSTALL_STAGING = YES
LIBMEDIASCAN_INSTALL_TARGET = YES
LIBMEDIASCAN_CONF_OPTS = 
LIBMEDIASCAN_DEPENDENCIES = libexif
LIBMEDIASCAN_AUTORECONF = YES
LIBMEDIASCAN_AUTORECONF_OPTS = -i
define LIBMEDIASCAN_PRE_CONFIGURE_FIXUP
	mkdir -p $(@D)/m4
endef
LIBMEDIASCAN_PRE_CONFIGURE_HOOKS += LIBMEDIASCAN_PRE_CONFIGURE_FIXUP

$(eval $(autotools-package))

