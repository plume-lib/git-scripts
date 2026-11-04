#!/bin/sh

set -eu

TEST_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
GIT_SCRIPTS=$(CDPATH='' cd -- "$TEST_DIR/../.." && pwd)

check_result() {
  scenario=$1
  expected=$2
  result=$(PR_NUMBER_TEST_SCENARIO="$scenario" PATH="$TEST_DIR/mock-bin:$PATH" "$GIT_SCRIPTS/pr-number")

  if [ "$result" != "$expected" ]; then
    echo "error: $scenario: expected PR $expected, got: $result" >&2
    exit 1
  fi
}

check_result prefer-open 8342
check_result fallback-to-non-open 39
