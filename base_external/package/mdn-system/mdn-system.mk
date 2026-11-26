
##############################################################
#
# MDN-SYSTEM
#
##############################################################

# Commit hash for repo with client (+ others as needed)
MDN_SYSTEM_VERSION = 2b71aac5b4ac210b5eecbe4cad2ceaa41fcd1360	# 11/26/2026 commit		

# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
MDN_SYSTEM_SITE = git@github.com:ryanchallacombe/ecea5307-final-project.git
MDN_SYSTEM_SITE_METHOD = git
MDN_SYSTEM_GIT_SUBMODULES = YES
MDN_SYSTEM_SUBDIRS += client
#CROSS_COMPILE_TB_SCRIPT_PATH = /aesd_client_include/tb_request.sh


define MDN_SYSTEM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/client all
endef
# $(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -DTB_SCRIPT_PATH=\"$(CROSS_COMPILE_TB_SCRIPT_PATH)\"" -C $(@D)/client all

define MDN_SYSTEM_INSTALL_TARGET_CMDS

	$(INSTALL) -m 0755 $(@D)/client/aesd_client $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/client/tb_request.sh $(TARGET_DIR)/aesd_client_include
	$(INSTALL) -m 0755 $(@D)/client/client-start-stop.sh $(TARGET_DIR)/etc/init.d/S98client		
								
endef

$(eval $(generic-package))
