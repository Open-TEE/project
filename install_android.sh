#!/bin/bash
adb root
adb remount

adb shell mkdir /system/lib/ta
adb shell mkdir /system/lib/tee

adb push $OUT/system/lib/libtee.so /system/lib
adb push $OUT/system/lib/libtee_pkcs11.so /system/lib
adb push $OUT/system/bin/conn_test_app /system/bin
adb push $OUT/system/lib/libCommonApi.so /system/lib
adb push $OUT/system/lib/libInternalApi.so /system/lib
adb push $OUT/system/lib/libLauncherApi.so /system/lib/tee
adb push $OUT/system/lib/libManagerApi.so /system/lib/tee
adb push $OUT/system/bin/opentee-engine /system/bin
adb push $OUT/system/lib/libta_conn_test_app.so /system/lib/ta
adb push $OUT/system/lib/libta_pkcs11.so /system/lib/ta
adb push $OUT/system/lib/libta_storage_test.so /system/lib/ta
adb push $OUT/system/bin/storage_test /system/bin
adb push $OUT/system/bin/storage_test_ca /system/bin
adb push $OUT/system/bin/pkcs11_test /system/bin
adb push project/opentee.conf.android /etc/opentee.conf

adb shell chmod 755 /system/lib/{ta,tee}
adb shell chmod 755 /system/bin/{opentee-engine,conn_test_app,pkcs11_test,storage_test,storage_test_ca}

