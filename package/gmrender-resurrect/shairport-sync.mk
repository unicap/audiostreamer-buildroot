################################################################################
#
# gmrender-resurrect
#
################################################################################

GMRENDER_RESURRECT_VERSION = 33ee9e0fd6d0ba469351f26dea44c2c15878f8c5
GMRENDER_RESURRECT_SITE = $(call github,unicap,gmrender-resurrect,$(SHAIRPORT_SYNC_VERSION))

GMRENDER_RESURRECT_LICENSE = GPLv2
GMRENDER_RESURRECT_DEPENDENCIES = gstreamer1 host-pkgconf

# git clone, no configure
GMRENDER_RESURRECT_AUTORECONF = YES

GMRENDER_RESURRECT_CONF_OPTS = --prefix=/usr

$(eval $(autotools-package))
