################################################################################
#
# perl-log_log4perl
#
################################################################################

PERL_LOG_LOG4PERL_VERSION = 1.47
PERL_LOG_LOG4PERL_SOURCE = Log-Log4perl-$(PERL_LOG_LOG4PERL_VERSION).tar.gz
PERL_LOG_LOG4PERL_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MS/MSCHILLI
PERL_LOG_LOG4PERL_LICENSE = Artistic or GPLv1+
PERL_LOG_LOG4PERL_LICENSE_FILES = README

$(eval $(perl-package))
