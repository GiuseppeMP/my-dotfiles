mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
broot:
	mkdir -p ~/.config/phoenix
	ln -nsf $(dir $(mkfile_path))phoenix.js ~/.config/phoenix/phoenix.js
