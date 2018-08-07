#############################################################
#
# Diag Application
#
#############################################################

#DIAG_VERSION = 1.0.0

define DIAG_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)"  LD="$(TARGET_LD)" -C $(@D) all
endef


define DIAG_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/diag $(TARGET_DIR)/usr/sbin
	mkdir -p $(TARGET_DIR)/usr/sbin/scripts
	$(INSTALL) -D -m 0755 $(@D)/scripts/*.sh $(TARGET_DIR)/usr/sbin/scripts
endef

define DIAG_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/sbin/diag
	rm -f $(TARGET_DIR)/usr/sbin/scripts
endef

define DIAG_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

#DIAG_LICENSE_FILES = LICENSES.txt

$(eval $(generic-package))
