BUNDLE=bundle
FASTLANE=$(BUNDLE) exec fastlane
PODS=$(BUNDLE) exec pod

install: # install dependencies
	$(BUNDLE) install
	$(POD) install --repo-update --clean
