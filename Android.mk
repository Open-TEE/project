LOCAL_PATH := $(my-dir)

ifeq ($(TARGET_ARCH),x86)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
