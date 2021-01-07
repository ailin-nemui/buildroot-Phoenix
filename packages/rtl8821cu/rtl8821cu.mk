################################################################################
#
# rtl8821CU
#
################################################################################

RTL8821CU_VERSION = 69eed197d2b56044f6df2f0013deebf3604dff86
RTL8821CU_SITE = $(call github,morrownr,8821cu,$(RTL8821CU_VERSION))
RTL8821CU_LICENSE = GPL-2.0
RTL8821CU_LICENSE_FILES = LICENSE

RTL8821CU_MODULE_MAKE_OPTS = \
	CONFIG_RTL8821CU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

define MAKEFILE_ALTERATIONS
# disabling i386 platform
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' $(@D)/Makefile
# we use raspberry pi platform since it is ARM architecture
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' $(@D)/Makefile
endef
RTL8821CU_PRE_BUILD_HOOKS += MAKEFILE_ALTERATIONS

$(eval $(kernel-module))
$(eval $(generic-package))
