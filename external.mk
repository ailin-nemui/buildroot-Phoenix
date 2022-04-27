include $(sort $(wildcard $(BR2_EXTERNAL_PHOENIX_PATH)/fs/*/*.mk))
include $(sort $(wildcard $(BR2_EXTERNAL_PHOENIX_PATH)/packages/*/*.mk))

export BR2_PHOENIX_PSLC_EMMC=0

rauc-fixups:
	$(BR2_EXTERNAL_PHOENIX_PATH)/scripts/rauc_fixups.sh

world: rauc-fixups
