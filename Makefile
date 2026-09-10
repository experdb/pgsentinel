# contrib/pgsentinel/Makefile
#
# The module itself lives in src/.  When this tree is checked out inside a
# PostgreSQL source tree as contrib/pgsentinel, use PostgreSQL's own recursion
# machinery so that all/install/check/clean behave like any other contrib
# module; when it is built standalone against an installed server, just
# forward every target to src/.

ifndef USE_PGXS
ifneq ($(wildcard ../../src/Makefile.global),)
PGSENTINEL_IN_TREE = 1
endif
endif

ifdef PGSENTINEL_IN_TREE

subdir = contrib/pgsentinel
top_builddir = ../..
include $(top_builddir)/src/Makefile.global

SUBDIRS = src

$(recurse)

else

all:
	$(MAKE) -C src all
%:
	$(MAKE) -C src $@

endif
