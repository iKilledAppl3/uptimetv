ARCHS = arm64
TARGET = appletv:clang
FINALPACKAGE = 1
SYSROOT = $(THEOS)/sdks/AppleTVOS12.4.sdk
INSTALL_TARGET_PROCESSES = TVSystemMenuService 

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = UptimeTVModule

UptimeTVModule_FILES = UptimeTVModule.mm
UptimeTVModule_INSTALL_PATH = /Library/TVSystemMenuModules
UptimeTVModule_FRAMEWORKS = UIKit
UptimeTVModule_PRIVATE_FRAMEWORKS = TVSystemMenuUI 
UptimeTVModule_CFLAGS = -fobjc-arc  -F. -I. -Wno-error=deprecated-declarations
UptimeTVModule_LDFLAGS +=  -F. -I.

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/TVSystemMenuModules$(ECHO_END)
	
