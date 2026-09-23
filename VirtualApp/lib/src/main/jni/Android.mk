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
                   Substrate/SubstrateDebug.cpp \
                   Substrate/SubstratePosixMemory.cpp \

LOCAL_LDLIBS := -llog -latomic



ifneq ($(TARGET_ARCH),arm64)
LOCAL_SRC_FILES += Substrate/hde64.c Substrate/SubstrateHook.cpp
endif

ifeq ($(TARGET_ARCH),arm64)
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)/HookZz/include $(MAIN_LOCAL_PATH)/HookZz/src $(MAIN_LOCAL_PATH)/fb/include
LOCAL_CPPFLAGS += -frtti -fexceptions -std=gnu++11 -DDISABLE_CPUCAP -DDISABLE_XPLAT
LOCAL_SRC_FILES += $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/zzdeps/common/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/zzdeps/linux/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/zzdeps/posix/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/platforms/arch-arm64/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/platforms/backend-arm64/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/platforms/backend-linux/*.c) $(wildcard $(MAIN_LOCAL_PATH)/HookZz/src/platforms/backend-posix/*.c)
LOCAL_SRC_FILES += $(wildcard $(MAIN_LOCAL_PATH)/fb/*.cpp) $(wildcard $(MAIN_LOCAL_PATH)/fb/jni/*.cpp) $(wildcard $(MAIN_LOCAL_PATH)/fb/lyra/*.cpp)
endif

include $(BUILD_SHARED_LIBRARY)