################################################################################
#
# perl-tree_dag_node
#
################################################################################

PERL_TREE_DAG_NODE_VERSION = 1.29
PERL_TREE_DAG_NODE_SOURCE = Tree-DAG_Node-$(PERL_TREE_DAG_NODE_VERSION).tgz
PERL_TREE_DAG_NODE_SITE = $(BR2_CPAN_MIRROR)/authors/id/R/RS/RSAVAGE
PERL_TREE_DAG_NODE_LICENSE = Artistic or GPLv1+
PERL_TREE_DAG_NODE_LICENSE_FILES = README
PERL_TREE_DAG_NODE_DEPENDENCIES = host-perl-file-slurp-tiny perl-file-slurp-tiny

$(eval $(perl-package))
