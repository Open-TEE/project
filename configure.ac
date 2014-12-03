#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#
# NOTE: If you edit this file, make sure changes destined for upstream are
# made and committed to the version controlled copy at projects/configure.ac
#

AC_PREREQ([2.69])
AC_INIT([opentee], [0.0.0], [https://github.com/Open-TEE/project/issues],
		[opentee], [https://github.com/Open-TEE])
AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([foreign subdir-objects])
AC_CONFIG_MACRO_DIR([m4])

# Nested packages to be built
AC_CONFIG_SUBDIRS([emulator
                   libtee
				   tests])

AC_CONFIG_FILES([Makefile])

AC_OUTPUT
