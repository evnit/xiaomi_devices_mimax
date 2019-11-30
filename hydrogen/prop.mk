# Audio
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
audio.offload.disable=1 \
audio.offload.pcm.16bit.enable=true \
audio.offload.pcm.24bit.enable=true \
audio.offload.video=true \
persist.vendor.audio.fluence.audiorec=false \
persist.audio.fluence.spk.mono=true \
persist.vendor.audio.fluence.voicerec=false \
vendor.voice.voip.conc.disabled=true \
audio.offload.multiaac.enable=true

# Display
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
ro.qcom.ad=1 \
ro.qcom.ad.calib.data=/system/etc/calib.cfg \
ro.qcom.ad.sensortype=2 \
ro.qualcomm.cabl=0

# Radio
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
persist.radio.cs_srv_type=1 \
persist.radio.force_on_dc=true \
persist.radio.redir_party_num=0 \
persist.radio.start_ota_daemon=1

# Camera Force HAL1 in these packages
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
camera.hal1.packagelist=com.skype.raider,com.google.android.GoogleCamera,com.tencent.mm

# Codecs: (PARSER_) AAC AC3 AMR_NB AMR_WB ASF AVI DTS FLV 3GP 3G2 MKV MP2PS MP2TS MP3 OGG QCP WAV FLAC AIFF APE
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
mm.enable.qcom_parser=1048575 \
persist.mm.enable.prefetch=true \
av.debug.disable.pers.cache=true \
media.stagefright.enable-player=true \
media.stagefright.enable-http=true \
media.stagefright.enable-aac=true \
media.stagefright.enable-qcp=true \
media.stagefright.enable-fma2dp=true \
media.stagefright.enable-scan=true

# System prop for RmNet Data
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
persist.rmnet.data.enable=true \
persist.data.wda.enable=true \
persist.data.df.dl_mode=5 \
persist.data.df.ul_mode=5 \
persist.data.df.agg.dl_pkt=10 \
persist.data.df.agg.dl_size=4096 \
persist.data.df.mux_count=8 \
persist.data.df.iwlan_mux=9 \
persist.data.df.dev_name=rmnet_usb0

# Property to enable VDS WFD solution
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
persist.hwc.enable_vds=1

# Display feature support
# bit0-ColorPrefer bit1-EyeCare bit2-AD bit3-CE bit4-CABC bit5-SRGB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
ro.sys.display.support=63

# Fingerprint
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
ro.hardware.fingerprint=fpc