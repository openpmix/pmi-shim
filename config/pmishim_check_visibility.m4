# -*- shell-script -*-
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2006-2015 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2009-2011 Oracle and/or its affiliates.  All rights reserved.
# Copyright (c) 2017      Intel, Inc. All rights reserved.
# Copyright (c) 2021-2023 Nanook Consulting.  All rights reserved.
# Copyright (c) 2022      Amazon.com, Inc. or its affiliates.  All Rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

# PMISHIM_CHECK_VISIBILITY
# --------------------------------------------------------
AC_DEFUN([PMISHIM_CHECK_VISIBILITY],[
    AC_REQUIRE([AC_PROG_GREP])

    # Check if the compiler has support for visibility, like some
    # versions of gcc, icc Sun Studio cc.
    AC_ARG_ENABLE(visibility,
        AS_HELP_STRING([--enable-visibility],
            [enable visibility feature of certain compilers/linkers (default: enabled)]))

    WANT_VISIBILITY=0
    pmishim_msg="whether to enable symbol visibility"

    if test "$enable_visibility" = "no"; then
        AC_MSG_CHECKING([$pmishim_msg])
        AC_MSG_RESULT([no (disabled)])
    else
        CFLAGS_orig=$CFLAGS

        pmishim_add=
        case "$oac_cv_c_compiler_vendor" in
        sun)
            # Check using Sun Studio -xldscope=hidden flag
            pmishim_add=-xldscope=hidden
            CFLAGS="$pmishim_add -errwarn=%all"
            ;;

        *)
            # Check using -fvisibility=hidden
            pmishim_add=-fvisibility=hidden
            CFLAGS="$pmishim_add -Werror"
            ;;
        esac

        AC_MSG_CHECKING([if $CC supports $pmishim_add])
        AC_LINK_IFELSE([AC_LANG_PROGRAM([[
            #include <stdio.h>
            __attribute__((visibility("default"))) int foo;
            ]],[[fprintf(stderr, "Hello, world\n");]])],
            [AS_IF([test -s conftest.err],
                   [$GREP -iq visibility conftest.err
                    # If we find "visibility" in the stderr, then
                    # assume it doesn't work
                    AS_IF([test "$?" = "0"], [pmishim_add=])])
            ], [pmishim_add=])
        AS_IF([test "$pmishim_add" = ""],
              [AC_MSG_RESULT([no])],
              [AC_MSG_RESULT([yes])])

        CFLAGS=$CFLAGS_orig
        PMISHIM_VISIBILITY_CFLAGS=$pmishim_add

        if test "$pmishim_add" != "" ; then
            WANT_VISIBILITY=1
            CFLAGS="$CFLAGS $PMISHIM_VISIBILITY_CFLAGS"
            AC_MSG_CHECKING([$pmishim_msg])
            AC_MSG_RESULT([yes (via $pmishim_add)])
        elif test "$enable_visibility" = "yes"; then
            AC_MSG_ERROR([Symbol visibility support requested but compiler does not seem to support it.  Aborting])
        else
            AC_MSG_CHECKING([$pmishim_msg])
            AC_MSG_RESULT([no (unsupported)])
        fi
        unset pmishim_add
    fi

    AC_DEFINE_UNQUOTED([PMISHIM_HAVE_VISIBILITY], [$WANT_VISIBILITY],
            [Whether C compiler supports symbol visibility or not])
])
