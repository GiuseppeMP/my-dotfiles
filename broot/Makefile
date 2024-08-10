mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
broot:
	mkdir -p ~/.config/broot
	ln -nsf $(dir $(mkfile_path))conf.hjson ~/.config/broot/conf.hjson
	ln -nsf $(dir $(mkfile_path))verbs.hjson ~/.config/broot/verbs.hjson
