all: style-check test

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean

# Code style
ifeq (,$(wildcard .plume-scripts))
dummy != git clone -q https://github.com/plume-lib/plume-scripts.git .plume-scripts
endif
include .plume-scripts/code-style.mak
