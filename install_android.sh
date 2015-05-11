#!/bin/bash
adb root
adb remount
adb push $OUT/system/lib/libtee.so /system/lib
adb push $OUT/system/bin/conn_test_app /system/bin
adb push $OUT/system/lib/libCommonApi.so /system/lib
adb push $OUT/system/lib/libInternalApi.so /system/lib
adb push $OUT/system/lib/libLauncherApi.so /system/lib/tee
adb push $OUT/system/lib/libManagerApi.so /system/lib/tee
adb push $OUT/system/bin/opentee-engine /system/bin
adb push $OUT/system/lib/libta_conn_test_app.so /system/lib/ta
adb push project/opentee.conf.android /etc/opentee.conf
