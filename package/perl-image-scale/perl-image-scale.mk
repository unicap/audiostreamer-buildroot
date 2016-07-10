################################################################################
#
# perl-image_scale
#
################################################################################

PERL_IMAGE_SCALE_VERSION = 0.12
PERL_IMAGE_SCALE_SOURCE = Image-Scale-$(PERL_IMAGE_SCALE_VERSION).tar.gz
PERL_IMAGE_SCALE_SITE = $(BR2_CPAN_MIRROR)/authors/id/A/AG/AGRUNDMA
PERL_IMAGE_SCALE_LICENSE = Artistic or GPLv1+
PERL_IMAGE_SCALE_LICENSE_FILES = README
PERL_IMAGE_SCALE_DEPENDENCIES = giflib jpeg libpng
PERL_IMAGE_SCALE_CONF_OPTS = \
	--with-jpeg-includes=$(STAGING_DIR)/usr/include \
	--with-jpeg-libs=$(TARGET_DIR)/usr/lib \
	--with-png-includes=$(STAGING_DIR)/usr/include \
	--with-png-libs=$(TARGET_DIR)/usr/lib \
	--with-gif-includes=$(STAGING_DIR)/usr/include \
	--with-gif-libs=$(TARGET_DIR)/usr/lib

$(eval $(perl-package))
