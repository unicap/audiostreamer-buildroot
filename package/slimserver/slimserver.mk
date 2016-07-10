################################################################################
#
# slimserver
#
################################################################################

SLIMSERVER_VERSION = 6e530508d14cce84d7eae8c08799198eab0639bf
SLIMSERVER_SITE = $(call github,Logitech,slimserver,$(SLIMSERVER_VERSION))

SLIMSERVER_LICENSE = GPL, 
SLIMSERVER_LICENSE_FILES = Licenses.txt
SLIMSERVER_DEPENDENCIES = perl expat \
	perl-audio-cuefile-parser \
	perl-audio-scan \
	perl-class-c3-xs \
	perl-class-xsaccessor \
	perl-common-sense \
	perl-compress-raw-zlib \
	perl-data-dump \
	perl-dbd-mysql \
	perl-dbd-sqlite \
	perl-digest-sha1 \
	perl-encode-detect \
	perl-extutils-cbuilder \
	perl-ev \
	perl-font-freetype \
	perl-html-parser \
	perl-html-tagset \
	perl-image-scale \
	perl-io-aio \
	perl-io-interface \
	perl-json-xs \
	perl-linux-inotify2 \
	perl-mp3-cut-gapless \
	perl-sub-name \
	perl-sub-uplevel \
	perl-template-toolkit \
	perl-tree-dag_node \
	perl-xml-parser

SLIMSERVER_INSTALL_EXTENSIONS = pl txt html dat conf
SLIMSERVER_INSTALL_DIRECTORIES = Graphics HTML IR lib MySQL Slim SQL

define SLIMSERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/slimserver
	for ext in $(SLIMSERVER_INSTALL_EXTENSIONS); do \
		cp -a $(@D)/*.$${ext} $(TARGET_DIR)/opt/slimserver/ \
	;done
	for d in $(SLIMSERVER_INSTALL_DIRECTORIES); do \
		cp -ar $(@D)/$${d} $(TARGET_DIR)/opt/slimserver/ \
	;done
endef

$(eval $(generic-package))
