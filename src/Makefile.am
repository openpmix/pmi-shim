#
# Copyright (c) 2020      Intel, Inc.  All rights reserved.
# Copyright (c) 2021      IBM Corporation.  All rights reserved.
# Copyright (c) 2023      Nanook Consulting.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

AM_CPPFLAGS = -I$(top_builddir)/src/include

#
# libpmishim[.so|.a]
#
lib_LTLIBRARIES = libpmishim.la
libpmishim_la_SOURCES = pmi1.c pmi2.c
libpmishim_la_LDFLAGS = $(pmix_LDFLAGS) -version-info $(libpmishim_so_version)
