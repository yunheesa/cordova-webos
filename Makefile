GREP = /usr/bin/grep
CUT = /usr/bin/cut
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(SHELL) -c true
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = mkdir -p
CAT = cat
MAKE = make
OPEN = open
ECHO = echo
ECHO_N = echo -n
JAVA = java
PGVERSION = 1.7.0

NAME = `$(CAT) framework/appinfo.json | $(GREP) '"id"' | $(CUT) -d \" -f 4`
VERSION = `$(CAT) framework/appinfo.json | $(GREP) '"version"' | $(CUT) -d \" -f 4`

all :: js copy_js package deploy run

custom :: js copy_js package deploy

clean :: clean_libs

clean_libs:
	-$(RM_RF) lib
	
package:
ifeq ($(findstring palm-package.bat,$(wildcard *.bat)), )
	palm-package framework/
else
	palm-package.bat framework/
endif
	
deploy:
ifeq ($(findstring palm-install.bat,$(wildcard *.bat)), )
	palm-install $(NAME)_$(VERSION)_all.ipk
else
	palm-install.bat $(NAME)_$(VERSION)_all.ipk
endif
	
run:
ifeq ($(findstring palm-install.bat,$(wildcard *.bat)), )
	palm-launch $(NAME)
else
	palm-launch.bat $(NAME)
endif
	
copy_js:
	cp lib/cordova.js framework/cordova-$(PGVERSION).js
	
js: lib/cordova.js

lib/cordova.js: js/cordova-core.js js/acceleration.js js/accelerometer.js js/application.js js/audio.js js/camera.js js/compass.js js/contacts.js js/debugconsole.js js/device.js js/file.js js/geolocation.js js/map.js js/mojo.js js/mouse.js js/network.js js/notification.js js/orientation.js js/position.js js/service.js js/sms.js js/telephony.js js/window.js js/windowproperties.js lib/thumbs.0.5.2.js
	$(MKPATH) lib
	$(RM_F) $@
	$(CAT) js/cordova-core.js >> $@
	$(CAT) js/acceleration.js >> $@
	$(CAT) js/accelerometer.js >> $@
	$(CAT) js/application.js >> $@
	$(CAT) js/audio.js >> $@
	$(CAT) js/camera.js >> $@
	$(CAT) js/contacts.js >> $@
	$(CAT) js/compass.js >> $@
	$(CAT) js/debugconsole.js >> $@
	$(CAT) js/device.js >> $@
	$(CAT) js/file.js >> $@
	$(CAT) js/geolocation.js >> $@
	$(CAT) js/map.js >> $@
	$(CAT) js/mojo.js >> $@
	$(CAT) js/mouse.js >> $@
	$(CAT) js/network.js >> $@
	$(CAT) js/notification.js >> $@
	$(CAT) js/orientation.js >> $@
	$(CAT) js/position.js >> $@
	$(CAT) js/service.js >> $@
	$(CAT) js/sms.js >> $@
	$(CAT) js/telephony.js >> $@
	$(CAT) js/window.js >> $@
	$(CAT) js/windowproperties.js >> $@
	$(CAT) lib/thumbs.0.5.2.js >> $@
