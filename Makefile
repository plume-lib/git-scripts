all: test check-style

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean

check-style: python-style-check shell-style-check

PYTHON_FILES=$(wildcard *.py)

python-style-fix:
	ruff format ${PYTHON_FILES}
	ruff check ${PYTHON_FILES} --fix

python-style-check:
	ruff format ${PYTHON_FILES}
	ruff check ${PYTHON_FILES} --fix

SH_SCRIPTS = $(shell grep -r -l '^\#!/bin/sh' * | grep -v .git | grep -v "~" | grep -v cronic-orig)
BASH_SCRIPTS = $(shell grep -r -l '^\#!/bin/bash' * | grep -v .git | grep -v "~" | grep -v cronic-orig)

shell-style-fix:
	shfmt -w -i 2 -ci -bn ${SH_SCRIPTS} ${BASH_SCRIPTS}
	shellcheck -x -P SCRIPTDIR --format=diff ${SH_SCRIPTS} ${BASH_SCRIPTS} | patch -p1

shell-style-check:
	shfmt -d -i 2 -ci -bn ${SH_SCRIPTS} ${BASH_SCRIPTS}
	shellcheck -x -P SCRIPTDIR --format=gcc ${SH_SCRIPTS} ${BASH_SCRIPTS}
	checkbashisms -l ${SH_SCRIPTS} /dev/null

showvars:
	@echo "PYTHON_FILES=${PYTHON_FILES}"
	@echo "SH_SCRIPTS=${SH_SCRIPTS}"
	@echo "BASH_SCRIPTS=${BASH_SCRIPTS}"

