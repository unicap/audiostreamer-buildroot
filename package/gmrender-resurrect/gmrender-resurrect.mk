################################################################################
#
# gmrender-resurrect
#
################################################################################

GMRENDER_RESURRECT_VERSION = 04390e4dade8595527dd157dddeb98a6c6047871
GMRENDER_RESURRECT_SITE = $(call github,unicap,gmrender-resurrect,$(GMRENDER_RESURRECT_VERSION))
# Original distribution does not have default configure,
# so we need to autoreconf:
GMRENDER_RESURRECT_AUTORECONF = YES
GMRENDER_RESURRECT_LICENSE = GPLv2+
GMRENDER_RESURRECT_LICENSE_FILES = COPYING
GMRENDER_RESURRECT_DEPENDENCIES = gstreamer1 libupnp jack2

$(eval $(autotools-package))
