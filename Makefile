.PHONY: all test install-user install-system uninstall switch-shift switch-altgr switch-turkish status info

all: status

test:
	python3 tests/test_layouts.py

install-user:
	./setup.sh shift

switch-shift:
	python3 uzkey.py switch shift

switch-altgr:
	python3 uzkey.py switch altgr

switch-turkish:
	python3 uzkey.py switch turkish

status:
	python3 uzkey.py status

info:
	python3 uzkey.py info

install-system:
	sudo ./install.sh

uninstall:
	./uninstall.sh
