dnl -*- shell-script -*-
dnl
dnl Copyright (c) 2004-2010 The Trustees of Indiana University and Indiana
dnl                         University Research and Technology
dnl                         Corporation.  All rights reserved.
dnl Copyright (c) 2004-2005 The University of Tennessee and The University
dnl                         of Tennessee Research Foundation.  All rights
dnl                         reserved.
dnl Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
dnl                         University of Stuttgart.  All rights reserved.
dnl Copyright (c) 2004-2005 The Regents of the University of California.
dnl                         All rights reserved.
dnl Copyright (c) 2006-2022 Cisco Systems, Inc.  All rights reserved
dnl Copyright (c) 2007      Sun Microsystems, Inc.  All rights reserved.
dnl Copyright (c) 2009-2022 IBM Corporation.  All rights reserved.
dnl Copyright (c) 2009      Los Alamos National Security, LLC.  All rights
dnl                         reserved.
dnl Copyright (c) 2009-2011 Oak Ridge National Labs.  All rights reserved.
dnl Copyright (c) 2011-2013 NVIDIA Corporation.  All rights reserved.
dnl Copyright (c) 2013-2023 Intel, Inc.  All rights reserved.
dnl Copyright (c) 2015-2019 Research Organization for Information Science
dnl                         and Technology (RIST).  All rights reserved.
dnl Copyright (c) 2016      Mellanox Technologies, Inc.
dnl                         All rights reserved.
dnl
dnl Copyright (c) 2021-2023 Nanook Consulting.  All rights reserved.
dnl Copyright (c) 2018-2022 Amazon.com, Inc. or its affiliates.
dnl                         All Rights reserved.
dnl Copyright (c) 2021      FUJITSU LIMITED.  All rights reserved.
dnl $COPYRIGHT$
dnl
dnl Additional copyrights may follow
dnl
dnl $HEADER$
dnl

AC_DEFUN([PMISHIM_SETUP_CORE],[

    AC_REQUIRE([AC_USE_SYSTEM_EXTENSIONS])
    AC_REQUIRE([AC_CANONICAL_TARGET])

    # AM_PROG_CC_C_O AC_REQUIREs AC_PROG_CC, so we have to be a little
    # careful about ordering here, and AC_REQUIRE these things so that
    # they get stamped out in the right order.
    AC_REQUIRE([_PMISHIM_START_SETUP_CC])
    AC_REQUIRE([_PMISHIM_PROG_CC])
    AC_REQUIRE([AM_PROG_CC_C_O])

    # Get pmishim's absolute top builddir (which may not be the same as
    # the real $top_builddir)
    PMISHIM_startdir=`pwd`
    PMISHIM_top_builddir=`pwd`
    AC_SUBST(PMISHIM_top_builddir)

    # Get pmishim's absolute top srcdir (which may not be the same as the
    # real $top_srcdir.  First, go back to the startdir in case the
    # $srcdir is relative.

    cd "$PMISHIM_startdir"
    cd "$srcdir"
    PMISHIM_top_srcdir="`pwd`"
    AC_SUBST(PMISHIM_top_srcdir)

    # Go back to where we started
    cd "$PMISHIM_startdir"

    AC_MSG_NOTICE([pmishim builddir: $PMISHIM_top_builddir])
    AC_MSG_NOTICE([pmishim srcdir: $PMISHIM_top_srcdir])
    if test "$PMISHIM_top_builddir" != "$PMISHIM_top_srcdir"; then
        AC_MSG_NOTICE([Detected VPATH build])
    fi

    # Get the version of pmishim that we are installing
    AC_MSG_CHECKING([for pmishim version])
    PMISHIM_VERSION="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_MSG_RESULT([$PMISHIM_VERSION])
    AC_SUBST(PMISHIM_VERSION)
    AC_DEFINE_UNQUOTED([PMISHIM_VERSION], ["$PMISHIM_VERSION"],
                       [The library version is always available, contrary to VERSION])

    PMISHIM_PROXY_BUGREPORT_STRING="https://github.com/openpmishim/openpmishim"
    AC_SUBST(PMISHIM_PROXY_BUGREPORT_STRING)
    AC_DEFINE_UNQUOTED([PMISHIM_PROXY_BUGREPORT_STRING], ["$PMISHIM_PROXY_BUGREPORT_STRING"],
                       [Where to report bugs])

    PMISHIM_RELEASE_DATE="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --release-date`"
    AC_SUBST(PMISHIM_RELEASE_DATE)

    # Save the breakdown the version information
    PMISHIM_MAJOR_VERSION="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --major`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_MAJOR_VERSION)
    AC_DEFINE_UNQUOTED([PMISHIM_MAJOR_VERSION], [$PMISHIM_MAJOR_VERSION],
                       [The library major version is always available, contrary to VERSION])

    PMISHIM_MINOR_VERSION="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --minor`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_MINOR_VERSION)
    AC_DEFINE_UNQUOTED([PMISHIM_MINOR_VERSION], [$PMISHIM_MINOR_VERSION],
                       [The library minor version is always available, contrary to VERSION])

    PMISHIM_RELEASE_VERSION="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --release`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_RELEASE_VERSION)
    AC_DEFINE_UNQUOTED([PMISHIM_RELEASE_VERSION], [$PMISHIM_RELEASE_VERSION],
                       [The library release version is always available, contrary to VERSION])

    pmishimmajor=${PMISHIM_MAJOR_VERSION}L
    pmishimminor=${PMISHIM_MINOR_VERSION}L
    pmishimrelease=${PMISHIM_RELEASE_VERSION}L
    pmishimnumeric=$(printf 0x%4.4x%2.2x%2.2x $PMISHIM_MAJOR_VERSION $PMISHIM_MINOR_VERSION $PMISHIM_RELEASE_VERSION)
    AC_SUBST(pmishimmajor)
    AC_SUBST(pmishimminor)
    AC_SUBST(pmishimrelease)
    AC_SUBST(pmishimnumeric)

    PMISHIM_GREEK_VERSION="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --greek`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_GREEK_VERSION)

    PMISHIM_REPO_REV="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --repo-rev`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_REPO_REV)
    AC_DEFINE_UNQUOTED([PMISHIM_REPO_REV], ["$PMISHIM_REPO_REV"],
                       [The OpenPMIshim Git Revision])

    PMISHIM_RELEASE_DATE="`$PMISHIM_top_srcdir/config/pmishim_get_version.sh $PMISHIM_top_srcdir/VERSION --release-date`"
    if test "$?" != "0"; then
        AC_MSG_ERROR([Cannot continue])
    fi
    AC_SUBST(PMISHIM_RELEASE_DATE)

    # Debug mode?
    AC_MSG_CHECKING([if want pmishim maintainer support])
    pmishim_debug=
    AS_IF([test "$pmishim_debug" = "" && test "$enable_debug" = "yes"],
          [pmishim_debug=1
           pmishim_debug_msg="enabled"])
    AS_IF([test "$pmishim_debug" = ""],
          [pmishim_debug=0
           pmishim_debug_msg="disabled"])
    # Grr; we use #ifndef for PMISHIM_DEBUG!  :-(
    AH_TEMPLATE(PMISHIM_ENABLE_DEBUG, [Whether we are in debugging mode or not])
    AS_IF([test "$pmishim_debug" = "1"], [AC_DEFINE([PMISHIM_ENABLE_DEBUG])])
    AC_MSG_RESULT([$pmishim_debug_msg])

    #
    # Package/brand string
    #
    AC_MSG_CHECKING([if want package/brand string])
    AC_ARG_WITH([pmishim-package-string],
         [AS_HELP_STRING([--with-pmishim-package-string=STRING],
                         [Use a branding string throughout PMIshim])])
    if test "$with_pmishim_package_string" = "" || test "$with_pmishim_package_string" = "no"; then
        with_package_string="PMIshim $PMISHIM_CONFIGURE_USER@$PMISHIM_CONFIGURE_HOST Distribution"
    fi
    AC_DEFINE_UNQUOTED([PMISHIM_PACKAGE_STRING], ["$with_package_string"],
         [package/branding string for PMIshim])
    AC_MSG_RESULT([$with_package_string])

    pmishimdir='${installdir}'
    pmishimdatadir='${datadir}'
    pmishimlibdir='${libdir}'
    pmishimincludedir='${includedir}'
    AC_SUBST(pmishimdir)
    AC_SUBST(pmishimdatadir)
    AC_SUBST(pmishimlibdir)
    AC_SUBST(pmishimincludedir)

    # A hint to tell us if we are working with a build from Git or a tarball.
    # Helpful when preparing diagnostic output.
    if test -e $PMISHIM_TOP_SRCDIR/.git; then
        AC_DEFINE_UNQUOTED([PMISHIM_GIT_REPO_BUILD], ["1"],
            [If built from a git repo])
        pmishim_git_repo_build=yes
    fi

    # do we want dlopen support ?
    AC_MSG_CHECKING([if want dlopen support])
    AC_ARG_ENABLE([dlopen],
        [AS_HELP_STRING([--enable-dlopen],
                        [Whether build should attempt to use dlopen (or
                         similar) to dynamically load components.
                         (default: enabled)])])
    AS_IF([test "$enable_dlopen" = "unknown"],
          [AC_MSG_WARN([enable_dlopen variable has been overwritten by configure])
           AC_MSG_WARN([This is an internal error that should be reported to PMIshim developers])
           AC_MSG_ERROR([Cannot continue])])
    AS_IF([test "$enable_dlopen" = "no"],
          [PMISHIM_ENABLE_DLOPEN_SUPPORT=0
           AC_MSG_RESULT([no])],
          [PMISHIM_ENABLE_DLOPEN_SUPPORT=1
           AC_MSG_RESULT([yes])])
    AC_DEFINE_UNQUOTED(PMISHIM_ENABLE_DLOPEN_SUPPORT, $PMISHIM_ENABLE_DLOPEN_SUPPORT,
                      [Whether we want to enable dlopen support])

#
#
# Developer picky compiler options
#

AC_MSG_CHECKING([if want developer-level compiler pickyness])
AC_ARG_ENABLE(devel-check,
    AS_HELP_STRING([--enable-devel-check],
                   [enable developer-level compiler pickyness when building PMIshim (default: disabled)]))
if test "$enable_devel_check" = "yes"; then
    AC_MSG_RESULT([yes])
    WANT_PICKY_COMPILER=1
elif test "$enable_devel_check" = "no"; then
    AC_MSG_RESULT([no])
    WANT_PICKY_COMPILER=0
    CFLAGS="$CFLAGS -Wno-unused-parameter"
elif test "$pmishim_git_repo_build" = "yes" && test "$pmishim_debug" = "1"; then
    AC_MSG_RESULT([yes])
    WANT_PICKY_COMPILER=1
else
    AC_MSG_RESULT([no])
    WANT_PICKY_COMPILER=0
    CFLAGS="$CFLAGS -Wno-unused-parameter"
fi

AC_DEFINE_UNQUOTED(PMISHIM_PICKY_COMPILERS, $WANT_PICKY_COMPILER,
                   [Whether or not we are using picky compiler settings])

#
# Developer debugging
#

AC_MSG_CHECKING([if want developer-level debugging code])
AC_ARG_ENABLE(debug,
    AS_HELP_STRING([--enable-debug],
                   [enable developer-level debugging code (not for general PMIshim users!) (default: disabled)]))
if test "$enable_debug" = "yes"; then
    AC_MSG_RESULT([yes])
    WANT_DEBUG=1
else
    AC_MSG_RESULT([no])
    WANT_DEBUG=0
fi

if test "$WANT_DEBUG" = "0"; then
    CFLAGS="-DNDEBUG $CFLAGS"
fi

AC_DEFINE_UNQUOTED(PMISHIM_ENABLE_DEBUG, $WANT_DEBUG,
                   [Whether we want developer-level debugging code or not])

AC_ARG_ENABLE(debug-symbols,
              AS_HELP_STRING([--disable-debug-symbols],
                             [Disable adding compiler flags to enable debugging symbols if --enable-debug is specified.  For non-debugging builds, this flag has no effect.]))

#
#
# Ident string
#
AC_MSG_CHECKING([if want ident string])
AC_ARG_WITH([ident-string],
            [AS_HELP_STRING([--with-ident-string=STRING],
                            [Embed an ident string into PMIshim object files])])
if test "$with_ident_string" = "" || test "$with_ident_string" = "no"; then
    with_ident_string="%VERSION%"
fi
# This is complicated, because $PMISHIM_VERSION may have spaces in it.
# So put the whole sed expr in single quotes -- i.e., directly
# substitute %VERSION% for (not expanded) $PMISHIM_VERSION.
with_ident_string="`echo $with_ident_string | sed -e 's/%VERSION%/$PMISHIM_VERSION/'`"

# Now eval an echo of that so that the "$PMISHIM_VERSION" token is
# replaced with its value.  Enclose the whole thing in "" so that it
# ends up as 1 token.
with_ident_string="`eval echo $with_ident_string`"

AC_DEFINE_UNQUOTED([PMISHIM_IDENT_STRING], ["$with_ident_string"],
                   [ident string for PMISHIM])
AC_MSG_RESULT([$with_ident_string])

# see if they want to disable non-RTLD_GLOBAL dlopen
AC_MSG_CHECKING([if want to support dlopen of non-global namespaces])
AC_ARG_ENABLE([nonglobal-dlopen],
              AS_HELP_STRING([--enable-nonglobal-dlopen],
                             [enable non-global dlopen (default: enabled)]))
if test "$enable_nonglobal_dlopen" = "no"; then
    AC_MSG_RESULT([no])
    pmishim_need_libpmishim=0
else
    AC_MSG_RESULT([yes])
    pmishim_need_libpmishim=1
fi

])dnl
