################################################################################
#
# perl-io_interface
#
################################################################################

PERL_IO_INTERFACE_VERSION = 1.09
PERL_IO_INTERFACE_SOURCE = IO-Interface-$(PERL_IO_INTERFACE_VERSION).tar.gz
PERL_IO_INTERFACE_SITE = $(BR2_CPAN_MIRROR)/authors/id/L/LD/LDS
PERL_IO_INTERFACE_LICENSE = Artistic or GPLv1+
PERL_IO_INTERFACE_LICENSE_FILES = README
PERL_IO_INTERFACE_DEPENDENCIES = host-perl-module-build

$(eval $(perl-package))
