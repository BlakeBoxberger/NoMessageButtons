include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NoMessageButtonsPreferences
NoMessageButtonsPreferences_FILES = NZMRootListController.m
NoMessageButtonsPreferences_INSTALL_PATH = /Library/PreferenceBundles
NoMessageButtonsPreferences_FRAMEWORKS = UIKit
NoMessageButtonsPreferences_PRIVATE_FRAMEWORKS = Preferences
NoMessageButtonsPreferences_EXTRA_FRAMEWORKS += Cephei, CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoMessageButtonsPreferences.plist$(ECHO_END)
