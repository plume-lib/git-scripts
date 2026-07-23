.PHONY: all test clean

all: style-check test

test:
	${MAKE} -C tests test

clean:
	${MAKE} -C tests clean
