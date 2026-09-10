# contrib/pgsentinel/src/Makefile

ifdef DEB_BUILD_GNU_TYPE
    REGRESS_OPTS =--temp-config=./pgsentinel.conf
else
    REGRESS_OPTS =--temp-config=./pgsentinel.conf --temp-instance=./tmp_check
endif

REGRESS = pgsentinel-test

MODULE_big = pgsentinel
OBJS = $(patsubst %.c,%.o,$(wildcard ./*.c))

ifeq ($(CC),gcc)
    PG_CPPFLAGS = -std=gnu11 -Wall -Wextra -Wno-unused-parameter -Wno-uninitialized -Wno-implicit-fallthrough -Iinclude
else
    PG_CPPFLAGS = -std=gnu11 -Wall -Wextra -Wno-unused-parameter -Wno-implicit-fallthrough -Iinclude
endif

EXTRA_CLEAN += $(addprefix ./,*.gcno *.gcda)

EXTENSION = pgsentinel
DATA = $(wildcard $(EXTENSION)*--*.sql)
PGFILEDESC = "pgsentinel - active session history"

LDFLAGS_SL += $(filter -lm, $(LIBS))

# Build against an installed server with PGXS by default.  When this tree is
# checked out inside a PostgreSQL source tree (as contrib/pgsentinel/src),
# build in-tree instead, like any other contrib module.
ifndef USE_PGXS
ifeq ($(wildcard ../../../src/Makefile.global),)
USE_PGXS = 1
endif
endif

ifdef USE_PGXS

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

else

# An in-tree build can be a VPATH build, where the sources are not in the
# current directory.  $(srcdir) is only known after Makefile.global, so these
# stay deferred assignments.
OBJS = $(WIN32RES) $(patsubst %.c,%.o,$(notdir $(wildcard $(srcdir)/*.c)))
DATA = $(notdir $(wildcard $(srcdir)/$(EXTENSION)*--*.sql))
REGRESS_OPTS = --temp-config $(srcdir)/pgsentinel.conf

# The regression test loads pg_stat_statements too, so it has to be installed
# into the temporary installation used by "make check".
EXTRA_INSTALL = contrib/pg_stat_statements
# Disabled because the test requires "shared_preload_libraries =
# pg_stat_statements,pgsentinel", which typical installcheck users do not
# have (e.g. buildfarm clients).
NO_INSTALLCHECK = 1

subdir = contrib/pgsentinel/src
top_builddir = ../../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk

endif
