#!/bin/sh

# Test one invocation of git-clone-related.

# Arguments:
#  1: repo from which to run git-clone-related
#  2: branch from which to run git-clone-related
#  3: git-clone-related arguments
#  4: expected repo that should be cloned
#  5: expected branch that should be cloned

START_REPO=$1
START_BRANCH=$2
ARGS=$3
GOAL_REPO=$4
GOAL_BRANCH=$5

set -o errexit -o nounset
# set -o pipefail
# Display commands and their arguments as they are executed.
# set -x
# Display shell input lines as they are read.
# set -v

USER=${USER:-git-clone-related}
PLUME_SCRIPTS=$(cd ../../ && pwd -P)
startdir=$(mktemp -d 2> /dev/null || mktemp -d -t 'startdir')
resultdir=$(mktemp -d 2> /dev/null || mktemp -d -t 'resultdir')
rm -rf "$startdir" "$resultdir"

git clone --branch "$START_BRANCH" "$START_REPO" "$startdir" -q --single-branch --depth 1
# This test might itself be running under CI, so unset the variables that
# `ci-info` examines.
unset SYSTEM_PULLREQUEST_TARGETBRANCH
unset BUILD_SOURCEBRANCH
unset TRAVIS
unset CIRCLE_COMPARE_URL
unset GITHUB_HEAD_REF

# shellcheck disable=SC2086  # $ARGS should not be quoted
(cd "$startdir" && "${PLUME_SCRIPTS}"/git-clone-related $ARGS "$resultdir")

clonedrepo=$(git -C "$resultdir" config --get remote.origin.url)
# git 2.22 and later has `git branch --show-current`; CircleCI doesn't have that version yet.
clonedbranch=$(git -C "$resultdir" rev-parse --abbrev-ref HEAD)

if [ "$clonedrepo" != "$GOAL_REPO" ]; then
  echo "error: test-git-clone-related.sh \"$1\" \"$2\" \"$3\" \"$4\" \"$5\""
  echo "error: expected repo $GOAL_REPO, got: $clonedrepo"
  exit 2
fi
if [ "$clonedbranch" != "$GOAL_BRANCH" ]; then
  echo "error: test-git-clone-related.sh \"$1\" \"$2\" \"$3\" \"$4\" \"$5\""
  echo "error: expected branch $GOAL_BRANCH, got: $clonedbranch"
  exit 2
fi

# This comes after the failure exits, so we don't clean up if the test fails.
rm -rf "$startdir" "$resultdir"
