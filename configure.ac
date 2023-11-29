# -*- shell-script -*-
#
# Copyright (c) 2004-2009 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2018 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2006-2019 Cisco Systems, Inc.  All rights reserved
# Copyright (c) 2006-2008 Sun Microsystems, Inc.  All rights reserved.
# Copyright (c) 2006-2017 Los Alamos National Security, LLC.  All rights
#                         reserved.
# Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
# Copyright (c) 2011-2013 NVIDIA Corporation.  All rights reserved.
# Copyright (c) 2012      Oracle and/or its affiliates.  All rights reserved.
# Copyright (c) 2013      Mellanox Technologies, Inc.
#                         All rights reserved.
# Copyright (c) 2013-2020 Intel, Inc.  All rights reserved.
# Copyright (c) 2014-2020 Research Organization for Information Science
#                         and Technology (RIST).  All rights reserved.
# Copyright (c) 2016-2020 IBM Corporation.  All rights reserved.
# Copyright (c) 2018      Amazon.com, Inc. or its affiliates.
#                         All Rights reserved.
# Copyright (c) 2018      FUJITSU LIMITED.  All rights reserved.
# Copyright (c) 2023      Nanook Consulting.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#


############################################################################
# Initialization, version number, and other random setup/init stuff
############################################################################

# Load the version number code
m4_include([config/pmishim_get_version.m4])
AC_LANG([C])

# Init autoconf

# We don't have the version number to put in here yet, and we can't
# call PMISHIM_GET_VERSION (etc.) before AC_INIT.  So use the shell
# version

AC_INIT([pmi-shim],[m4_normalize(esyscmd([config/pmishim_get_version.sh VERSION --tarball]))],
        [https://github.com/openpmishim/pmi-shim/issues],[pmishim])
AC_PREREQ([2.70])
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_MACRO_DIR(./config)

AC_PROG_SED

# autotools expects to perform tests without interference
# from user-provided CFLAGS, particularly -Werror flags.
# Search for them here and cache any we find
PMISHIM_CFLAGS_cache=
PMISHIM_CFLAGS_pass=
for val in $CFLAGS; do
    if echo "$val" | grep -q -e "-W"; then
        PMISHIM_CFLAGS_cache="$PMISHIM_CFLAGS_cache $val";
    else
        PMISHIM_CFLAGS_pass="$PMISHIM_CFLAGS_pass $val";
    fi
done
CFLAGS=$PMISHIM_CFLAGS_pass

PMISHIM_TOP_BUILDDIR="`pwd`"
AC_SUBST(PMISHIM_TOP_BUILDDIR)
top_buildir=`pwd`
cd "$srcdir"
PMISHIM_TOP_SRCDIR="`pwd`"
top_srcdir=$PMISHIM_TOP_SRCDIR
AC_SUBST(PMISHIM_TOP_SRCDIR)
cd "$PMISHIM_TOP_BUILDDIR"

AC_MSG_NOTICE([builddir: $PMISHIM_TOP_BUILDDIR])
AC_MSG_NOTICE([srcdir: $PMISHIM_TOP_SRCDIR])
if test "$PMISHIM_TOP_BUILDDIR" != "$PMISHIM_TOP_SRCDIR"; then
    AC_MSG_NOTICE([Detected VPATH build])
fi

# setup configure options (e.g., show_title and friends)
PMISHIM_CONFIGURE_SETUP

pmishim_show_title "Configuring PMI-SHIM"

#
# Setup some things that must be done before AM-INIT-AUTOMAKE
#
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AC_DEFINE_UNQUOTED(PMISHIM_ARCH, "$target", [PMI-SHIM architecture string])

#
# Init automake
#
AM_INIT_AUTOMAKE([foreign dist-bzip2 subdir-objects no-define 1.13.4 tar-ustar])

# SILENT_RULES is new in AM 1.11, but we require 1.11 or higher via
# autogen.  Limited testing shows that calling SILENT_RULES directly
# works in more cases than adding "silent-rules" to INIT_AUTOMAKE
# (even though they're supposed to be identical).  Shrug.
AM_SILENT_RULES([yes])

# set the language
AC_LANG([C])
# find NM
AC_PROG_GREP
LT_PATH_NM

# AC_USE_SYSTEM_EXTENSIONS will modify CFLAGS if nothing was in there
# beforehand.  We don't want that.  So if there was nothing in
# CFLAGS, put nothing back in there.
PMISHIM_VAR_SCOPE_PUSH([CFLAGS_save])
CFLAGS_save=$CFLAGS
AC_USE_SYSTEM_EXTENSIONS
AS_IF([test -z "$CFLAGS_save"], [CFLAGS=])
PMISHIM_VAR_SCOPE_POP

# Sanity checks
AC_DEFUN([PMISHIM_CHECK_DIR_FOR_SPACES],[
    dir="$1"
    article="$2"
    label="$3"

    AC_MSG_CHECKING([directory of $label])
    AC_MSG_RESULT([$dir])
    AS_IF([test -n "`echo $dir | grep ' '`"],
          [AC_MSG_WARN([This version of OpenPMIshim does not support $article $label])
           AC_MSG_WARN([with a path that contains spaces])
           AC_MSG_ERROR([Cannot continue.])])
])

PMISHIM_VAR_SCOPE_PUSH(pmishim_checkdir)
pmishim_checkdir=`pwd`
PMISHIM_CHECK_DIR_FOR_SPACES([$pmishim_checkdir], [a], [build tree])
PMISHIM_CHECK_DIR_FOR_SPACES([$prefix], [a], [prefix])
PMISHIM_CHECK_DIR_FOR_SPACES([$srcdir], [a], [source tree])
PMISHIM_VAR_SCOPE_POP

# Make configure depend on the VERSION file, since it's used in AC_INIT
AC_SUBST([CONFIGURE_DEPENDENCIES], ['$(top_srcdir)/VERSION'])

pmishim_show_subtitle "Checking versions"

# Get the version of PMI-SHIM that we are installing

PMISHIM_SAVE_VERSION([PMISHIM], [PMI-SHIM], [$srcdir/VERSION],
                      [include/pmishim_version.h])

# Get shared library version numbers

. $srcdir/VERSION
AC_SUBST(libpmishim_so_version)

#
# Get the versions of the autotools that were used to bootstrap us
# (helpful for debugging reports)
#
AC_MSG_CHECKING([for bootstrap Autoconf version])
acversion=`grep "Generated by GNU Autoconf" $0 | head -n 1 | awk '{ print $6 }'`
AC_MSG_RESULT([$acversion])

AC_MSG_CHECKING([for bootstrap Automake version])
AC_MSG_RESULT([$am__api_version])

AC_MSG_CHECKING([for bootstrap Libtool version])
ltversion=`grep VERSION= $srcdir/config/ltmain.sh | head -n 1 | cut -d= -f2`
AC_MSG_RESULT([$ltversion])

# List header files to generate

AC_CONFIG_HEADERS([src/include/pmishim_config.h])

pmishim_show_subtitle "Initialization, setup"

# Setup the top of the src/include/pmishim_config.h file

AH_TOP([/* -*- c -*-
 *
 * Copyright (c) 2023      Nanook Consulting. All rights reserved.
 *
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 *
 * Function: - OS, CPU and compiler dependent configuration
 */

#ifndef PMISHIM_CONFIG_H
#define PMISHIM_CONFIG_H

#undef PMISHIM_HAVE_VISIBILITY

#if PMISHIM_HAVE_VISIBILITY == 1
#define PMISHIM_EXPORT __attribute__((__visibility__("default")))
#else
#define PMISHIM_EXPORT
#endif

])
AH_BOTTOM([
#include "src/include/pmishim_config_bottom.h"
#endif /* PMISHIM_CONFIG_H */
])

# Other basic setup stuff

PMISHIM_BASIC_SETUP
PMISHIM_CHECK_VISIBILITY
PMISHIM_SETUP_CORE

pmishim_show_title "Checking for PMIx"
PMISHIM_CHECK_PMIX

############################################################################
# Libtool: part one
# (before C compiler setup)
############################################################################

#
# Part one of libtool magic.  Default to: enable shared, disable static.
#

pmishim_show_title "Setup libtool"

AC_ENABLE_SHARED([])
#AC_ENABLE_STATIC([])
#AC_DISABLE_STATIC([])


LT_INIT()
LT_LANG([C])

# final compiler config
############################################################################
pmishim_show_title "Compiler flags"

#
# This is needed for VPATH builds, so that it will -I the appropriate
# include directory.  We delayed doing it until now just so that
# '-I$(top_srcdir)' doesn't show up in any of the configure output --
# purely aesthetic.
#

# Because pmishim_config.h is created by AC_CONFIG_HEADERS, we
# don't need to -I the builddir for src/include. However, we do
# need to add it for pmishim as it doesn't have an AC_CONFIG_HEADERS that
# will install it for us. If we VPATH building, we do need to include the
# source directories, however.
#

if test "$PMISHIM_TOP_BUILDDIR" != "$PMISHIM_TOP_SRCDIR"; then
    # Note the embedded m4 directives here -- we must embed them
    # rather than have successive assignments to these shell
    # variables, lest the $(foo) names try to get evaluated here.
    # Yuck!
    CPP_INCLUDES='-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/src/include -I$(top_builddir)/src/include'" $CPPFLAGS"
else
    CPP_INCLUDES='-I$(top_srcdir) -I$(top_srcdir)/src/include'" $CPPFLAGS"
fi
CPPFLAGS="$CPP_INCLUDES $CPPFLAGS $pmishim_CPPFLAGS"
LDFLAGS="$LDFLAGS $pmishim_LDFLAGS"
LIBS="$LIBS $pmishim_LIBS"

#
# Delayed the substitution of CFLAGS and CXXFLAGS until now because
# they may have been modified throughout the course of this script.
#

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(CXXFLAGS)

AC_CONFIG_FILES([
    Makefile
    src/Makefile
    include/Makefile
])

AC_MSG_CHECKING([final CPPFLAGS])
AC_MSG_RESULT([$CPPFLAGS])

AC_MSG_CHECKING([final CFLAGS])
AC_MSG_RESULT([$CFLAGS])

AC_MSG_CHECKING([final LDFLAGS])
AC_MSG_RESULT([$LDFLAGS])

AC_MSG_CHECKING([final LIBS])
AC_MSG_RESULT([$LIBS])


pmishim_show_title "Configuration complete"

AC_OUTPUT
PMISHIM_SUMMARY_PRINT

