/*
   Copyright (c) 2016, The CyanogenMod Project
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <sys/sysinfo.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include <android-base/logging.h>
#include <android-base/file.h>
using android::base::ReadFileToString;

#include <android-base/strings.h>
using android::base::Trim;

#include <android-base/properties.h>
using android::base::GetProperty;

#include "property_service.h"
using android::init::property_set;

std::string heapstartsize;
std::string heapgrowthlimit;
std::string heapsize;
std::string heapminfree;
std::string heapmaxfree;

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

static void init_alarm_boot_properties()
{
    char const *boot_reason_file = "/proc/sys/kernel/boot_reason";
    char const *power_off_alarm_file = "/persist/alarm/powerOffAlarmSet";
    std::string boot_reason;
    std::string power_off_alarm;
    std::string reboot_reason = GetProperty("ro.boot.alarmboot", "");

    if (ReadFileToString(boot_reason_file, &boot_reason)
                 && ReadFileToString(power_off_alarm_file, &power_off_alarm))
    {
        /*
        * Setup ro.alarm_boot value to true when it is RTC triggered boot up
        * For existing PMIC chips, the following mapping applies
        * for the value of boot_reason:
        * 0 -> unknown
        * 1 -> hard reset
        * 2 -> sudden momentary power loss (SMPL)
        * 3 -> real time clock (RTC)
        * 4 -> DC charger inserted
        * 5 -> USB charger inserted
        * 6 -> PON1 pin toggled (for secondary PMICs)
        * 7 -> CBLPWR_N pin toggled (for external power supply)
        * 8 -> KPDPWR_N pin toggled (power key pressed)
        */
        if ((Trim(boot_reason) == "3" || reboot_reason == "true")
                 && Trim(power_off_alarm) == "1")
        {
            property_override("ro.alarm_boot", "true");
        } else {
            property_override("ro.alarm_boot", "false");
        }
    } else {
        PLOG(ERROR) << "init_msm: Can't read " << boot_reason_file <<
                       " or " << power_off_alarm_file;
    }
}

void check_device()
{
    struct sysinfo sys;
    sysinfo(&sys);

    if (sys.totalram > 3072ull * 1024 * 1024)
    {
        // from - phone-xxhdpi-4096-dalvik-heap.mk
        heapstartsize = "16m";
        heapgrowthlimit = "256m";
        heapsize = "512m";
        heapminfree = "4m";
        heapmaxfree = "8m";
        return;
    } else if (sys.totalram > 2048ull * 1024 * 1024) {
        // from - phone-xxhdpi-3072-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "288m";
        heapsize = "768m";
        heapminfree = "512k";
        heapmaxfree = "8m";
        return;
    } else {
        // from - phone-xxhdpi-2048-dalvik-heap.mk
        heapstartsize = "16m";
        heapgrowthlimit = "192m";
        heapsize = "512m";
        heapminfree = "2m";
        heapmaxfree = "8m";
    }
}

void vendor_load_properties()
{
    check_device();

    property_set("dalvik.vm.heapstartsize", heapstartsize);
    property_set("dalvik.vm.heapgrowthlimit", heapgrowthlimit);
    property_set("dalvik.vm.heapsize", heapsize);
    property_set("dalvik.vm.heaptargetutilization", "0.75");
    property_set("dalvik.vm.heapminfree", heapminfree);
    property_set("dalvik.vm.heapmaxfree", heapmaxfree);

    std::string selp = GetProperty("persist.sys.selinux.enforcing", "");
    if (selp == "")
    {
        LOG(INFO) << "init_msm: persist.sys.selinux.enforcing wasn't set...";
        property_set("persist.sys.selinux.enforcing", "0");
    }

    selp = GetProperty("persist.sys.cpu.core_ctl", "");
    if (selp == "")
    {
        LOG(INFO) << "init_msm: persist.sys.cpu.core_ctl wasn't set...";
        property_set("persist.sys.cpu.core_ctl", "0");
    }

    init_alarm_boot_properties();

    LOG(INFO) << "init_msm: Done...";
}

