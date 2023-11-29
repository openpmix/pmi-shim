#
# Copyright 2020     Intel, Inc. All rights reserved
# Copyright (c) 2020      IBM Corporation.  All rights reserved.
# Copyright (c) 2023      Nanook Consulting.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#
# See COPYING in top-level directory.

# Note that the -I directory must *exactly* match what was specified
# via AC_CONFIG_MACRO_DIR in configure.ac.
ACLOCAL_AMFLAGS = -I ./config

#
# "make distcheck" requires that tarballs are able to be able to "make
# dist", so we have to include config/distscript.sh.
#
EXTRA_DIST = \
        NEWS README.md VERSION autogen.sh \
    	config/pmishim_get_version.sh


headers =
sources =
nodist_headers =
dist_pmishimdata_DATA =
nobase_pmishim_HEADERS = \
	src/include/pmishim_config.h \
	src/include/pmishim_config_bottom.h

SUBDIRS = include src

nobase_pmishim_HEADERS += $(headers)
