################################################################################
#
# gmrender-resurrect
#
################################################################################
# original aus buildroot
GMRENDER_RESURRECT_VERSION = 33600ab663f181c4f4f5c48aba25bf961760a300
# 2/2019 git
#GMRENDER_RESURRECT_VERSION = a7b0b1b9ca482d2d34ac62c2f2dc0cf0dfbb702b
# uralt
#GMRENDER_RESURRECT_VERSION = 400361649f3d540c08001c0ad68222388e65be67
GMRENDER_RESURRECT_SITE = $(call github,hzeller,gmrender-resurrect,$(GMRENDER_RESURRECT_VERSION))

# 8/2018
GMRENDER_RESURRECT_VERSION = a7b0b1b9ca482d2d34ac62c2f2dc0cf0dfbb702b

# Original distribution does not have default configure,
# so we need to autoreconf:
GMRENDER_RESURRECT_AUTORECONF = YES
GMRENDER_RESURRECT_LICENSE = GPL-2.0+
GMRENDER_RESURRECT_LICENSE_FILES = COPYING
GMRENDER_RESURRECT_DEPENDENCIES = gstreamer1 libupnp

$(eval $(autotools-package))
