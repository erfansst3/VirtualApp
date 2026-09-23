LOCAL_PATH := $(call my-dir)
MAIN_LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := va++

LOCAL_CFLAGS := -Wno-error=format-security -fpermissive -DLOG_TAG=\"VA++\"
LOCAL_CFLAGS += -fno-rtti -fno-exceptions

LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)/Foundation
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)/Jni

LOCAL_SRC_FILES := Jni/VAJni.cpp \
				   Foundation/IOUniformer.cpp \
				   Foundation/VMPatch.cpp \
				   Foundation/SymbolFinder.cpp \
				   Foundation/Path.cpp \
				   Foundation/SandboxFs.cpp \
				   Substrate/hde64.c \
                   Substrate/SubstrateDebug.cpp \
                   Substrate/SubstrateHook.cpp \
                   Substrate/SubstratePosixMemory.cpp \

LOCAL_LDLIBS := -llog -latomic
LOCAL_STATIC_LIBRARIES := fb

ifneq ($(TARGET_ARCH),arm64)
LOCAL_SRC_FILES += Substrate/hde64.c Substrate/SubstrateHook.cpp
endif

ifeq ($(TARGET_ARCH),arm64)
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)/HookZz/include
LOCAL_STATIC_LIBRARIES += hookzz
endif

include $(MAIN_LOCAL_PATH)/fb/Android.mk
ifeq ($(TARGET_ARCH),arm64)
include $(MAIN_LOCAL_PATH)/HookZz/Android.mk
endif
include $(BUILD_SHARED_LIBRARY)