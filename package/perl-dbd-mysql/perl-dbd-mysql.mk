################################################################################
#
# perl-dbd-mysql
#
################################################################################

PERL_DBD_MYSQL_VERSION = 4.034
PERL_DBD_MYSQL_SOURCE = DBD-mysql-$(PERL_DBD_MYSQL_VERSION).tar.gz
PERL_DBD_MYSQL_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/MI/MICHIELB
PERL_DBD_MYSQL_LICENSE = Artistic or GPLv1+
PERL_DBD_MYSQL_LICENSE_FILES = README
PERL_DBD_MYSQL_DEPENDENCIES = mysql openssl perl-dbi host-perl-dbi
PERL_DBD_MYSQL_CONF_OPTS = \
	--cflags="-I$(STAGING_DIR)/usr/include/mysql" \
	--libs="-L$(STAGING_DIR)/usr/lib -lmysqlclient -lpthread -lz -lm -ldl -lssl -lcrypto" \
	--mysql_config=$(STAGING_DIR)/usr/bin/mysql_config

$(eval $(perl-package))
