################################################################################
#
# perl_dbix_class
#
################################################################################

PERL_DBIX_CLASS_VERSION = 0.082840
PERL_DBIX_CLASS_SOURCE = DBIx-Class-$(PERL_DBIX_CLASS_VERSION).tar.gz
PERL_DBIX_CLASS_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RI/RIBASUSHI
PERL_DBIX_CLASS_LICENSE = Artistic or GPLv1+
PERL_DBIX_CLASS_LICENSE_FILES = README
PERL_DBIX_CLASS_DEPENDENCIES = perl-moo perl-module-runtime perl-devel-globaldestruction perl-sub-exporter-progressive \
			       perl-class-c3-componentised perl-mro-compat perl-namespace-clean \
			       perl-b-hooks-endofscope perl-module-implementation perl-try-tiny \
			       perl-package-stash
$(eval $(perl-package))
