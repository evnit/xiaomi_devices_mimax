# Remove init scripts & fstab on dirty build
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*ueventd.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*fstab.qcom*' | xargs rm -rf)

$(call add-clean-step, find $(PRODUCT_OUT) -name '*qti-telephony-common*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*CNEService*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*ims*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*qcrilmsgtunnel*' | xargs rm -rf)

$(call add-clean-step, find $(PRODUCT_OUT) -name '*perf-profile*' | xargs rm -rf)
