################################################################################
#
# perl-audio-scan
#
################################################################################

PERL_AUDIO_SCAN_VERSION = 0.95
PERL_AUDIO_SCAN_SOURCE = Audio-Scan-$(PERL_AUDIO_SCAN_VERSION).tar.gz
PERL_AUDIO_SCAN_SITE = https://github.com/Logitech/slimserver-vendor/raw/public/7.9/CPAN
PERL_AUDIO_SCAN_LICENSE = Artistic or GPLv1+
PERL_AUDIO_SCAN_LICENSE_FILES = README

$(eval $(perl-package))
