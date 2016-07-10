################################################################################
#
# perl-io_aio
#
################################################################################

PERL_IO_AIO_VERSION = 4.34
PERL_IO_AIO_SOURCE = IO-AIO-$(PERL_IO_AIO_VERSION).tar.gz
PERL_IO_AIO_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_IO_AIO_LICENSE = Artistic or GPLv1+
PERL_IO_AIO_LICENSE_FILES = README

$(eval $(perl-package))
