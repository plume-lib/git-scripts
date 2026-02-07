.PHONY: all test clean

all: style-check test

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean

# Code style; defines `style-check` and `style-fix`.
ifeq (,$(wildcard .plume-scripts))
dummy := $(shell git clone --depth=1 -q https://github.com/plume-lib/plume-scripts.git .plume-scripts)
endif
include .plume-scripts/code-style.mak
