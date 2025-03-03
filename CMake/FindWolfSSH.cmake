#***************************************************************************
#                                  _   _ ____  _
#  Project                     ___| | | |  _ \| |
#                             / __| | | | |_) | |
#                            | (__| |_| |  _ <| |___
#                             \___|\___/|_| \_\_____|
#
# Copyright (C) Daniel Stenberg, <daniel@haxx.se>, et al.
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at https://curl.se/docs/copyright.html.
#
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#
# SPDX-License-Identifier: curl
#
###########################################################################
# Find the wolfssh library
#
# Result Variables:
#
# WOLFSSH_FOUND         System has wolfssh
# WOLFSSH_INCLUDE_DIRS  The wolfssh include directories
# WOLFSSH_LIBRARIES     The wolfssh library names
# WOLFSSH_VERSION       Version of wolfssh

find_path(WOLFSSH_INCLUDE_DIR "wolfssh/ssh.h")
find_library(WOLFSSH_LIBRARY NAMES "wolfssh" "libwolfssh")

if(WOLFSSH_INCLUDE_DIR)
  file(STRINGS "${WOLFSSH_INCLUDE_DIR}/wolfssh/version.h" _wolfssh_version_str REGEX "#[\t ]*define[\t ]+LIBWOLFSSH_VERSION_STRING[\t ]+\"(.*)\"")
  string(REGEX REPLACE "^.*\"([^\"]+)\"" "\\1" WOLFSSH_VERSION "${_wolfssh_version_str}")
  unset(_wolfssh_version_str)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WolfSSH
  REQUIRED_VARS
    WOLFSSH_INCLUDE_DIR
    WOLFSSH_LIBRARY
  VERSION_VAR
    WOLFSSH_VERSION
)

if(WOLFSSH_FOUND)
  set(WOLFSSH_INCLUDE_DIRS ${WOLFSSH_INCLUDE_DIR})
  set(WOLFSSH_LIBRARIES    ${WOLFSSH_LIBRARY})
endif()

mark_as_advanced(WOLFSSH_INCLUDE_DIR WOLFSSH_LIBRARY)
