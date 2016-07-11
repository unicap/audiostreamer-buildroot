################################################################################
#
# perl-sql_abstract
#
################################################################################

PERL_SQL_ABSTRACT_VERSION = 1.81
PERL_SQL_ABSTRACT_SOURCE = SQL-Abstract-$(PERL_SQL_ABSTRACT_VERSION).tar.gz
PERL_SQL_ABSTRACT_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RI/RIBASUSHI
PERL_SQL_ABSTRACT_LICENSE = Artistic or GPLv1+
PERL_SQL_ABSTRACT_LICENSE_FILES = README

$(eval $(perl-package))
