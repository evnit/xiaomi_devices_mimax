LOCAL_PATH := $(call my-dir)

# Xiaomi offmode charging
+include $(CLEAR_VARS)
+LOCAL_MODULE          := healthd_xiaomi
+LOCAL_MODULE_OWNER    := xiaomi
+LOCAL_MODULE_PATH     := $(TARGET_ROOT_OUT_SBIN)
+LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_SBIN_UNSTRIPPED)
+LOCAL_SRC_FILES       := healthd_xiaomi
+LOCAL_MODULE_TAGS     := optional
+LOCAL_MODULE_CLASS    := EXECUTABLES
+include $(BUILD_PREBUILT)

