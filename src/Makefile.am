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
# libpmi[.so|.a]
#
lib_LTLIBRARIES = libpmi.la
libpmi_la_SOURCES = pmi1.c
libpmi_la_LDFLAGS = $(pmix_LDFLAGS) -version-info $(libpmishim_so_version)

#
# libpmi2[.so|.a]
#
lib_LTLIBRARIES += libpmi2.la
libpmi2_la_SOURCES = pmi2.c
libpmi2_la_LDFLAGS = $(pmix_LDFLAGS) -version-info $(libpmishim_so_version)
