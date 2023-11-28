/*
 * Copyright (c) 2011      Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2013-2015 Intel, Inc. All rights reserved
 * Copyright (c) 2016      IBM Corporation.  All rights reserved.
 * Copyright (c) 2021-2023 Nanook Consulting.  All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 *
 * This file is included at the bottom of pmishim_config.h, and is
 * therefore a) before all the #define's that were output from
 * configure, and b) included in most/all files in PMIshim.
 *
 * Since this file is *only* ever included by pmishim_config.h, and
 * pmishim_config.h already has #ifndef/#endif protection, there is no
 * need to #ifndef/#endif protection here.
 */

#ifndef PMISHIM_CONFIG_H
#    error "pmishim_config_bottom.h should only be included from config.h(.in)"
#endif

/* The only purpose of this file is to undef the PACKAGE_<foo> macros
   that are put in by autoconf/automake projects.  Specifically, if
   you include a .h file from another project that defines these
   macros (e.g., gmp.h) and then include PMISHIM's config.h,
   you'll get a preprocessor conflict.  So put these undef's here to
   protect us from other package's PACKAGE_<foo> macros.

   Note that we can't put them directly in pmishim_config.h (e.g., via
   AH_TOP) because they will be turned into #define's by autoconf. */

#undef PACKAGE_BUGREPORT
#undef PACKAGE_NAME
#undef PACKAGE_STRING
#undef PACKAGE_TARNAME
#undef PACKAGE_VERSION
#undef PACKAGE_URL
#undef HAVE_CONFIG_H
