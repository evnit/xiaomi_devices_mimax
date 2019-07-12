# Remove init scripts & fstab on dirty build
$(call add-clean-step, find $(PRODUCT_OUT) -name '*libstagefright*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.target*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*ueventd.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*fstab.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.qcom.post_boot*' | xargs rm -rf)

$(call add-clean-step, find $(PRODUCT_OUT) -name '*perf-profile*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*perfboostsconfig*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*Lawnchair*' | xargs rm -rf)

$(call add-clean-step, find $(PRODUCT_OUT) -name 'qti-telephony-common*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name 'ims_intermediates' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name 'imssettings_intermediates' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name 'ims' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name 'imssettings' | xargs rm -rf)
