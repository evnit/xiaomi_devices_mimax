#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function blob_fixup() {
    case "${1}" in
        system/vendor/lib/mediadrm/libwvdrmengine.so)
            patchelf --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
        vendor/lib/mediadrm/libwvdrmengine.so)
            patchelf --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
        system/vendor/lib64/libwvhidl.so)
            patchelf --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
        vendor/lib64/libwvhidl.so)
            patchelf --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
    esac
}

# patchelf --remove-needed libprotobuf-cpp-lite.so libwvhidl.so
# patchelf --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "libwvhidl.so"
# patchelf --add-needed libprotobuf-cpp-full-v28.so libsettings.so
# Default to sanitizing the vendor folder before extraction  libprotobuf-cpp-full-v28.so
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_DEVICE_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-device-common )
                ONLY_DEVICE_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

if [ -z "${ONLY_TARGET}" ] && [ -z "${ONLY_DEVICE_COMMON}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -z "${ONLY_TARGET}" ] && [ -s "${MY_DIR}/../${DEVICE_SPECIFIED_COMMON}/proprietary-files.txt" ];then
    # Reinitialize the helper for device specified common
    source "${MY_DIR}/../${DEVICE_SPECIFIED_COMMON}/extract-files.sh"
    setup_vendor "${DEVICE_SPECIFIED_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE_SPECIFIED_COMMON}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -z "${ONLY_DEVICE_COMMON}" ] && [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

COMMON_BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary
patchelf --replace-needed android.frameworks.sensorservice@1.0.so android.frameworks.sensorservice@1.0-v27.so $COMMON_BLOB_ROOT/vendor/bin/slim_daemon
patchelf --replace-needed android.hardware.gnss@1.0.so android.hardware.gnss@1.0-v27.so $COMMON_BLOB_ROOT/lib64/vendor.qti.gnss@1.0.so
patchelf --replace-needed android.hardware.gnss@1.0.so android.hardware.gnss@1.0-v27.so $COMMON_BLOB_ROOT/vendor/lib64/vendor.qti.gnss@1.0_vendor.so
patchelf --replace-needed libbase.so libbase-v28.so $COMMON_BLOB_ROOT/vendor/lib64/hw/android.hardware.bluetooth@1.0-impl-qti.so
patchelf --add-needed libshim.so $COMMON_BLOB_ROOT/vendor/bin/imsrcsd

"${MY_DIR}/setup-makefiles.sh
