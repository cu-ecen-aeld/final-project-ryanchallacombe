
##############################################################
#
# MDN-SYSTEM
#
##############################################################

# Commit hash for repo with client (+ others as needed)
MDN_SYSTEM_VERSION = 06e9fa39167d0fe85797b146e64ef24a50a30855	# 11/8/2026 commit		

# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
MDN_SYSTEM_SITE = git@github.com:ryanchallacombe/ecea5307-final-project.git
MDN_SYSTEM_SITE_METHOD = git
MDN_SYSTEM_GIT_SUBMODULES = YES
MDN_SYSTEM_SUBDIRS += client

define MDN_SYSTEM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/client all
endef


define MDN_SYSTEM_INSTALL_TARGET_CMDS

	$(INSTALL) -m 0755 $(@D)/client/aesd_client $(TARGET_DIR)/usr/bin
									
endef

#	$(INSTALL) -m 0755 $(@D)/client/client-start-stop.sh $(TARGET_DIR)/etc/init.d/S98client

$(eval $(generic-package))
