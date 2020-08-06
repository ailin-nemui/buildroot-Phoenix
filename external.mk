include $(sort $(wildcard $(BR2_EXTERNAL_MynaPlayer_PATH)/packages/*/*.mk))

export MODULES_PLACE = $(BASE_DIR)/../kmod
export KERNEL_PLACE = $(BASE_DIR)/../kernel

pre-clean:
	rm -rf $(MAGIC_PLACE)
	rm -rf $(KERNEL_PLACE)

rauc-fixups:
	$(BR2_EXTERNAL_MynaPlayer_PATH)/scripts/rauc_fixups.sh

all: rauc-fixups
