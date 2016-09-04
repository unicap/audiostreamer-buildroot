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
LIBMEDIASCAN_DEPENDENCIES = libexif perl
LIBMEDIASCAN_AUTORECONF = YES
LIBMEDIASCAN_AUTORECONF_OPTS = -i
define LIBMEDIASCAN_PRE_CONFIGURE_FIXUP
	mkdir -p $(@D)/m4
endef
define LIBMEDIASCAN_BUILD_PERL_MODULE_FIXUP
	PERL_ARCHNAME=$(ARCH)-linux
	PERL_RUN=$(HOST_DIR)/usr/bin/perl
	PERL_MM_USE_DEFAULT=1
	PERL_AUTOINSTALL=--skipdeps
	(cd $(@D)/bindings/perl && $(PERL_RUN) Makefile.PL \
			AR="$(TARGET_AR)" \
			FULL_AR="$(TARGET_AR)" \
			CC="$(TARGET_CC)" \
			CCFLAGS="$(TARGET_CFLAGS)" \
			OPTIMIZE=" " \
			LD="$(TARGET_CC)" \
			LDDLFLAGS="-shared $(TARGET_LDFLAGS)" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			DESTDIR=$(TARGET_DIR) \
			INSTALLDIRS=vendor \
			INSTALLVENDORLIB=/usr/lib/perl5/site_perl/$(PERL_VERSION) \
			INSTALLVENDORARCH=/usr/lib/perl5/site_perl/$(PERL_VERSION)/$(PERL_ARCHNAME) \
			INSTALLVENDORBIN=/usr/bin \
			INSTALLVENDORSCRIPT=/usr/bin \
			INSTALLVENDORMAN1DIR=/usr/share/man/man1 \
			INSTALLVENDORMAN3DIR=/usr/share/man/man3 \
			--with-lms-includes=../../include \
			--with-lms-libs=../../src/.libs \
	);

	sed "s~/usr/bin/gcc~$(TARGET_CC) -Os~" -i $(@D)/bindings/perl/Makefile
	sed "s~x86_64~$(KERNEL_ARCH)~" -i $(@D)/bindings/perl/Makefile
	sed "s~host/usr/lib~staging/usr/lib~" -i $(@D)/bindings/perl/Makefile
	$(MAKE) $(@D)/bindings/perl/Makefile -C $(@D)/bindings/perl
	$(MAKE) $(@D)/bindings/perl/Makefile -C $(@D)/bindings/perl install
endef

define LIBMEDIASCAN_POST_INSTALL_FIXUP
	$(MAKE) $(@D)/bindings/perl/Makefile -C $(@D)/bindings/perl install
endef
LIBMEDIASCAN_PRE_CONFIGURE_HOOKS += LIBMEDIASCAN_PRE_CONFIGURE_FIXUP
LIBMEDIASCAN_POST_BUILD_HOOKS += LIBMEDIASCAN_BUILD_PERL_MODULE_FIXUP
LIBFOO_POST_INSTALL_TARGET_HOOKS += LIBMEDIASCAN_POST_INSTALL_FIXUP


$(eval $(autotools-package))

