dnl -*- shell-script -*-
dnl
dnl Copyright (c) 2016      Los Alamos National Security, LLC. All rights
dnl                         reserved.
dnl Copyright (c) 2016-2018 Cisco Systems, Inc.  All rights reserved
dnl Copyright (c) 2016      Research Organization for Information Science
dnl                         and Technology (RIST). All rights reserved.
dnl Copyright (c) 2018-2020 Intel, Inc.  All rights reserved.
dnl Copyright (c) 2023      Nanook Consulting.  All rights reserved.
dnl $COPYRIGHT$
dnl
dnl Additional copyrights may follow
dnl
dnl $HEADER$
dnl
AC_DEFUN([PMISHIM_SUMMARY_ADD],[
    PMISHIM_VAR_SCOPE_PUSH([pmishim_summary_section pmishim_summary_line pmishim_summary_section_current])

    dnl need to replace spaces in the section name with somethis else. _ seems like a reasonable
    dnl choice. if this changes remember to change PMISHIM_PRINT_SUMMARY as well.
    pmishim_summary_section=$(echo $1 | tr ' ' '_')
    pmishim_summary_line="$2: $4"
    pmishim_summary_section_current=$(eval echo \$pmishim_summary_values_$pmishim_summary_section)

    if test -z "$pmishim_summary_section_current" ; then
        if test -z "$pmishim_summary_sections" ; then
            pmishim_summary_sections=$pmishim_summary_section
        else
            pmishim_summary_sections="$pmishim_summary_sections $pmishim_summary_section"
        fi
        eval pmishim_summary_values_$pmishim_summary_section=\"$pmishim_summary_line\"
    else
        eval pmishim_summary_values_$pmishim_summary_section=\"$pmishim_summary_section_current,$pmishim_summary_line\"
    fi

    PMISHIM_VAR_SCOPE_POP
])

AC_DEFUN([PMISHIM_SUMMARY_PRINT],[
    PMISHIM_VAR_SCOPE_PUSH([pmishim_summary_section pmishim_summary_section_name])
    cat <<EOF

PMISHIM configuration:
-----------------------
Version: $PMISHIM_MAJOR_VERSION.$PMISHIM_MINOR_VERSION.$PMISHIM_RELEASE_VERSION$PMISHIM_GREEK_VERSION
EOF

    if test $WANT_DEBUG = 0 ; then
        echo "Debug build: no"
    else
        echo "Debug build: yes"
    fi

    echo

    for pmishim_summary_section in $(echo $pmishim_summary_sections) ; do
        pmishim_summary_section_name=$(echo $pmishim_summary_section | tr '_' ' ')
        echo "$pmishim_summary_section_name"
        echo "-----------------------"
        echo "$(eval echo \$pmishim_summary_values_$pmishim_summary_section)" | tr ',' $'\n' | sort -f
        echo " "
    done

    if test $WANT_DEBUG = 1 ; then
        cat <<EOF
*****************************************************************************
 THIS IS A DEBUG BUILD!  DO NOT USE THIS BUILD FOR PERFORMANCE MEASUREMENTS!
*****************************************************************************

EOF
    fi

    PMISHIM_VAR_SCOPE_POP
])
