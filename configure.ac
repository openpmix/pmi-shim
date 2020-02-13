# -*- shell-script -*-
#
# Copyright (c) 2004-2009 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2010 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2006-2016 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2006-2008 Sun Microsystems, Inc.  All rights reserved.
# Copyright (c) 2006-2017 Los Alamos National Security, LLC.  All rights
#                         reserved.
# Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
# Copyright (c) 2011-2013 NVIDIA Corporation.  All rights reserved.
# Copyright (c) 2012      Oracle and/or its affiliates.  All rights reserved.
# Copyright (c) 2013      Mellanox Technologies, Inc.
#                         All rights reserved.
# Copyright (c) 2014-2019 Intel, Inc.  All rights reserved.
# Copyright (c) 2016      IBM Corporation.  All rights reserved.
# Copyright (c) 2016-2018 Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# Copyright (c) 2020      Lawrence Livermore National Security, LLC.
#                         All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

AC_INIT([pmi-shim],
        [1.0],
        [https://github.com/pmix/pmi-shim/issues],
        [pmi-shim],
        [https://github.com/pmix/pmi-shim],
)
AC_CONFIG_AUX_DIR(./config)
# Note that this directory must *exactly* match what was specified via
# -I in ACLOCAL_AMFLAGS in the top-level Makefile.am.
AC_CONFIG_MACRO_DIR(./config)

AM_INIT_AUTOMAKE([foreign dist-bzip2 subdir-objects no-define tar-ustar -Wall -Werror])

# SILENT_RULES is new in AM 1.11, but we require 1.11 or higher via
# autogen.  Limited testing shows that calling SILENT_RULES directly
# works in more cases than adding "silent-rules" to INIT_AUTOMAKE
# (even though they're supposed to be identical).  Shrug.
AM_SILENT_RULES([yes])

# Set the language
AC_LANG([C])

# Find a C compiler
AC_PROG_CC
# Required for linking libraries according to automake warnings
AM_PROG_AR

LT_INIT([disable-static])

AC_CONFIG_HEADERS([src/include/pmix_config.h])
AC_CONFIG_FILES([Makefile src/Makefile test/Makefile])
AC_CHECK_HEADERS([string.h unistd.h stdlib.h])

OPAL_CONFIGURE_SETUP
OPAL_CHECK_PMIX
m4_ifdef([project_ompi], [OMPI_CONFIGURE_OPTIONS])

AC_OUTPUT
