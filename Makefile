all: test check-style

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean

style-fix: python-style-fix shell-style-fix
style-check: python-style-check python-typecheck shell-style-check


PYTHON_FILES:=$(wildcard *.py)
install-mypy:
	@if ! command -v mypy ; then pip install mypy ; fi
install-ruff:
	@if ! command -v ruff ; then pipx install ruff ; fi
python-style-fix: install-ruff
	@ruff format ${PYTHON_FILES}
	@ruff -q check ${PYTHON_FILES} --fix
python-style-check: install-ruff
	@ruff -q format --check ${PYTHON_FILES}
	@ruff -q check ${PYTHON_FILES}
python-typecheck: install-mypy
	@mypy --strict ${PYTHON_FILES} > /dev/null 2>&1 || true
	@mypy --install-types --non-interactive
	mypy --strict --ignore-missing-imports ${PYTHON_FILES}

SH_SCRIPTS = $(shell grep -r -l '^\#!/bin/sh' * | grep -v .git | grep -v "~" | grep -v cronic-orig)
BASH_SCRIPTS = $(shell grep -r -l '^\#!/bin/bash' * | grep -v .git | grep -v "~" | grep -v cronic-orig)

shell-style-fix:
	shfmt -w -i 2 -ci -bn -sr ${SH_SCRIPTS} ${BASH_SCRIPTS}
	shellcheck -x -P SCRIPTDIR --format=diff ${SH_SCRIPTS} ${BASH_SCRIPTS} | patch -p1

shell-style-check:
	shfmt -d -i 2 -ci -bn -sr ${SH_SCRIPTS} ${BASH_SCRIPTS}
	shellcheck -x -P SCRIPTDIR --format=gcc ${SH_SCRIPTS} ${BASH_SCRIPTS}
	checkbashisms -l ${SH_SCRIPTS} /dev/null

showvars:
	@echo "PYTHON_FILES=${PYTHON_FILES}"
	@echo "SH_SCRIPTS=${SH_SCRIPTS}"
	@echo "BASH_SCRIPTS=${BASH_SCRIPTS}"

