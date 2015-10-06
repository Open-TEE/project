#!/bin/bash
#
# Copyright (C) 2015 Aalto University.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Open-TEE install targets
OT_PROGS=${OT_PROGS-"opentee-engine conn_test_app"}
OT_LIBS=${OT_LIBS-"libtee libCommonApi libInternalApi"}
OT_LIBSX=${OT_LIBSX-"libLauncherApi libManagerApi"}
OT_TAS=${OT_TAS-"libta_conn_test_app"}
OT_CONFIG=${OT_CONFIG-"opentee.conf"}

# Destinations
OT_PREFIX=${OT_PREFIX-"/system"}
OT_PROGS_DEST=${OT_PROGS_DEST-"$OT_PREFIX/bin"}
OT_LIBS_DEST=${OT_LIBS_DEST-"$OT_PREFIX/lib"}
OT_LIBSX_DEST=${OT_LIBSX_DEST-"$OT_PREFIX/lib/tee"}
OT_TAS_DEST=${OT_TAS_DEST-"$OT_PREFIX/lib/ta"}
OT_CONFIG_DEST=${OT_CONFIG_DEST-"$OT_PREFIX/etc"}

# Open-TEE project directory
OT_BASEDIR="$(dirname "${BASH_SOURCE[0]}")/project"

# Returns the adb shell user from connected device
adb_whoami()
{
  echo $(echo "echo \$USER; exit" | adb shell | tail -1 | tr -d '\r')
}

# Write error message to stdout and exit
fail()
{
  echo "`basename $0`: $1" >&2
  exit 1
}

# Make sure ANDROID_PRODUCT_OUT is set to the product-specific directory that
# contains the generated binaries
if [ -z "$ANDROID_PRODUCT_OUT" ]; then
  fail "ANDROID_PRODUCT_OUT not set, run lunch to set build target, aborting"
fi

# Restart adbd daemon as root if needed
if [ "x$(adb_whoami)" != "xroot" ]; then
  printf "Restarting adbd daemon with root permissions: "
  adb root
  sleep 5s
  if [ "x$(adb_whoami)" != "xroot" ]; then
    echo "FAILED"
    fail "failed restart adbd with root permissions, aborting"
  else
    echo "OK"
  fi
fi

# Remount system partions read-write"
printf "Remounting /system read-write: "
adb remount || fail "failed to remount /system read-write, aborting"

# Create destination directories
adb shell mkdir -p  "$OT_TAS_DEST"   || fail "failed to create '$TA_DEST', aborting"
adb shell chmod 755 "$OT_TAS_DEST"   || fail "failed to set permissions for '$OT_TAS_DEST', aborting"
adb shell mkdir -p  "$OT_LIBSX_DEST" || fail "failed to create '$OT_LIBSX_DEST', aborting"
adb shell chmod 755 "$OT_LIBSX_DEST" || fail "failed to set permissions for '$OT_LIBSX_DEST', aborting"

# Push programs
for target in $OT_PROGS
do
  infile="$ANDROID_PRODUCT_OUT/system/bin/$target"
  echo "Pushing '$target' to '$OT_PROGS_DEST'"
  adb push "$infile" "$OT_PROGS_DEST"          || fail "failed to push '$target', aborting"
  adb shell chmod 755 "$OT_PROGS_DEST/$target" || fail "failed to set permissions for '$target', aborting"
done

# Push libraries
for target in $OT_LIBS
do
  infile="$ANDROID_PRODUCT_OUT/system/lib/${target}.so"
  echo "Pushing '$target' to '$OT_LIBS_DEST'"
  adb push "$infile" "$OT_LIBS_DEST" || fail "failed to push '$target', aborting"
done

# Push additional libraries
for target in $OT_LIBSX
do
  infile="$ANDROID_PRODUCT_OUT/system/lib/${target}.so"
  echo "Pushing '$target' to '$OT_LIBSX_DEST'"
  adb push "$infile" "$OT_LIBSX_DEST" || fail "failed to push '$target', aborting"
done

# Push TAs
for target in $OT_TAS
do
  infile="$ANDROID_PRODUCT_OUT/system/lib/${target}.so"
  echo "Pushing '$target' to '$OT_TAS_DEST'"
  adb push "$infile" "$OT_TAS_DEST" || fail "failed to push '$target', aborting"
done

# Push config
for target in $OT_CONFIG
do
  infile="$OT_BASEDIR/${target}.android"
  echo "Pushing '$target' to '$OT_CONFIG_DEST'"
  adb push "$infile" "$OT_CONFIG_DEST/${target}" || fail "failed to push '$target', aborting"
done

# Done
exit 0

