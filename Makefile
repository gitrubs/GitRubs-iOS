BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)
FASTLANE=$(BUNDLE) exec fastlane
PODS=$(BUNDLE) exec pod

install: # install dependencies
	$(BUNDLE) install
	$(POD) install

test: # Run tests
	$(FASTLANE) test