.PHONY: all clean test

test:
	${MAKE} -C git-clone-related-test test
	./pr-number-test/test-pr-number.sh
	${MAKE} -C resolve-adjacent-conflicts-test
	${MAKE} -C resolve-import-conflicts-test

clean:
	${MAKE} -C git-clone-related-test clean
	${MAKE} -C resolve-adjacent-conflicts-test clean
	${MAKE} -C resolve-import-conflicts-test clean
