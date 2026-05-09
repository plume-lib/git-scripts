.PHONY: all test clean

all: style-check test

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean

PLUME_SCRIPTS ?= .plume-scripts

# Code style; defines `style-check` and `style-fix`.
ifeq (,$(wildcard ${PLUME_SCRIPTS}))
dummy := $(shell git clone --depth=1 -q https://github.com/plume-lib/plume-scripts.git ${PLUME_SCRIPTS})
endif
include ${PLUME_SCRIPTS}/code-style.mak
