INSTALL_PATH = /usr/local/bin/textoru

install:
	swift package update
	swift build -c release
	cp -f .build/release/textoru $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
