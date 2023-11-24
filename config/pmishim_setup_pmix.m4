# -*- shell-script ; indent-tabs-mode:nil -*-
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2009-2015 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2011-2014 Los Alamos National Security, LLC. All rights
#                         reserved.
# Copyright (c) 2014-2020 Intel, Inc.  All rights reserved.
# Copyright (c) 2014-2019 Research Organization for Information Science
#                         and Technology (RIST).  All rights reserved.
# Copyright (c) 2016      IBM Corporation.  All rights reserved.
# Copyright (c) 2023      Nanook Consulting.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

AC_DEFUN([PMISHIM_CHECK_PMIX],[

    PMISHIM_VAR_SCOPE_PUSH([pmishim_external_pmix_save_CPPFLAGS pmishim_external_pmix_save_LDFLAGS pmishim_external_pmix_save_LIBS])

    AC_ARG_WITH([pmix],
                [AS_HELP_STRING([--with-pmix(=DIR)],
                                [Where to find PMIx support, optionally adding DIR to the search path])])

    AC_ARG_WITH([pmix-libdir],
                [AS_HELP_STRING([--with-pmix-libdir=DIR],
                                [Look for libpmix in the given directory DIR, DIR/lib or DIR/lib64])])


    if test "$with_pmix" = "no"; then
        AC_MSG_WARN([PMISHIM requires PMIx support using])
        AC_MSG_WARN([an external copy that you supply.])
        AC_MSG_ERROR([Cannot continue])

    else
        # check for external pmix lib */
        AS_IF([test -z "$with_pmix"],
              [pmix_ext_install_dir=/usr],
              [pmix_ext_install_dir=$with_pmix])

        # Make sure we have the headers and libs in the correct location
        PMISHIM_CHECK_WITHDIR([pmix], [$pmix_ext_install_dir/include], [pmix.h])

        AS_IF([test -n "$with_pmix_libdir"],
              [AC_MSG_CHECKING([libpmix.* in $with_pmix_libdir])
               files=`ls $with_pmix_libdir/libpmix.* 2> /dev/null | wc -l`
               AS_IF([test "$files" -gt 0],
                     [AC_MSG_RESULT([found])
                      pmix_ext_install_libdir=$with_pmix_libdir],
                     [AC_MSG_RESULT([not found])
                      AC_MSG_CHECKING([libpmix.* in $with_pmix_libdir/lib64])
                      files=`ls $with_pmix_libdir/lib64/libpmix.* 2> /dev/null | wc -l`
                      AS_IF([test "$files" -gt 0],
                            [AC_MSG_RESULT([found])
                             pmix_ext_install_libdir=$with_pmix_libdir/lib64],
                            [AC_MSG_RESULT([not found])
                             AC_MSG_CHECKING([libpmix.* in $with_pmix_libdir/lib])
                             files=`ls $with_pmix_libdir/lib/libpmix.* 2> /dev/null | wc -l`
                             AS_IF([test "$files" -gt 0],
                                   [AC_MSG_RESULT([found])
                                    pmix_ext_install_libdir=$with_pmix_libdir/lib],
                                    [AC_MSG_RESULT([not found])
                                     AC_MSG_ERROR([Cannot continue])])])])],
              [# check for presence of lib64 directory - if found, see if the
               # desired library is present and matches our build requirements
               AC_MSG_CHECKING([libpmix.* in $pmix_ext_install_dir/lib64])
               files=`ls $pmix_ext_install_dir/lib64/libpmix.* 2> /dev/null | wc -l`
               AS_IF([test "$files" -gt 0],
               [AC_MSG_RESULT([found])
                pmix_ext_install_libdir=$pmix_ext_install_dir/lib64],
               [AC_MSG_RESULT([not found])
                AC_MSG_CHECKING([libpmix.* in $pmix_ext_install_dir/lib])
                files=`ls $pmix_ext_install_dir/lib/libpmix.* 2> /dev/null | wc -l`
                AS_IF([test "$files" -gt 0],
                      [AC_MSG_RESULT([found])
                       pmix_ext_install_libdir=$pmix_ext_install_dir/lib],
                      [AC_MSG_RESULT([not found])
                       AC_MSG_ERROR([Cannot continue])])])])

        AS_IF([test "$pmix_ext_install_dir" != "/usr"],
              [pmix_CPPFLAGS="-I$pmix_ext_install_dir/include"
               pmix_LDFLAGS="-L$pmix_ext_install_libdir"],
               [pmix_CPPFLAGS=""
                pmix_LDFLAGS=""])
        pmix_LIBS=-lpmix

    fi

    PMISHIM_SUMMARY_ADD([[Required Packages]],[[PMIx]],[pmix],[yes ($pmix_ext_install_dir)])

    PMISHIM_VAR_SCOPE_POP
])
