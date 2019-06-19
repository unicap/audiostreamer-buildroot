################################################################################
#
# squeezelite
#
################################################################################

SQUEEZELITE_VERSION = c503edc9acb203f0c12865447fe6963fd8220fb8
#SQUEEZELITE_VERSION = 451cad8da651073d18118fb9ca39faef550825ff
SQUEEZELITE_SITE = $(call github,ralph-irving,squeezelite,$(SQUEEZELITE_VERSION))
#SQUEEZELITE_SITE = git@github.com:ralph-irving/squeezelite.git
SQUEEZELITE_LICENSE = GPL-3.0
SQUEEZELITE_LICENSE_FILES = LICENSE.txt
SQUEEZELITE_DEPENDENCIES = alsa-lib flac libmad libvorbis faad2 mpg123
SQUEEZELITE_MAKE_OPTS = -DLINKALL

ifeq ($(BR2_PACKAGE_SQUEEZELITE_FFMPEG),y)
SQUEEZELITE_DEPENDENCIES += ffmpeg
SQUEEZELITE_MAKE_OPTS += -DFFMPEG
endif

ifeq ($(BR2_PACKAGE_SQUEEZELITE_DSD),y)
SQUEEZELITE_MAKE_OPTS += -DDSD
endif

ifeq ($(BR2_PACKAGE_SQUEEZELITE_RESAMPLE),y)
SQUEEZELITE_DEPENDENCIES += libsoxr
SQUEEZELITE_MAKE_OPTS += -DRESAMPLE
endif

ifeq ($(BR2_PACKAGE_SQUEEZELITE_VISEXPORT),y)
SQUEEZELITE_MAKE_OPTS += -DVISEXPORT
endif

define SQUEEZELITE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		OPTS="$(SQUEEZELITE_MAKE_OPTS)" -C $(@D) all
endef

define SQUEEZELITE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/squeezelite \
		$(TARGET_DIR)/usr/bin/squeezelite
endef

$(eval $(generic-package))
