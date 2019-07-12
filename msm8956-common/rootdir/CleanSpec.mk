# Remove init scripts & fstab on dirty build
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*init.target*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*ueventd.qcom*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*fstab.qcom*' | xargs rm -rf)

$(call add-clean-step, find $(PRODUCT_OUT) -name '*perf-profile*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*perfboostsconfig*' | xargs rm -rf)
$(call add-clean-step, find $(PRODUCT_OUT) -name '*Lawnchair*' | xargs rm -rf)
