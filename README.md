# Git-Scripts:  Scripts for git, such as automatically resolving merge conflicts

These scripts automate various Git tasks.

Also see https://github.com/plume-lib/manage-git-branches
and https://github.com/plume-lib/plume-scripts.

## Installation

To install, run the following (or put it at the top of a script).
Then, the scripts are available at `/tmp/$USER/git-scripts`.

```
if [ -d /tmp/$USER/git-scripts ] ; then
  git -C /tmp/$USER/git-scripts pull -q > /dev/null 2>&1
else
  mkdir -p /tmp/$USER && git -C /tmp/$USER clone --depth 1 -q https://github.com/plume-lib/git-scripts.git
fi
```

If you want to use a specific version of `git-scripts` rather than the
bleeding-edge HEAD, you can run `git checkout _SHA_` after the `git clone`
command.

Most of the scripts use `sh` or `bash`,
but some of the scripts use `perl` or `python`.


## Git version control scripts

### ediff-merge-script

A script for use as a git mergetool; runs Emacs ediff as the mergetool.
[Documentation](ediff-merge-script) at top of file.

### git-authors

Lists all the authors of commits in a get repository.
[Documentation](git-authors) at top of file.

### git-clone-related

Clones a repository related to the one where this script is called, trying
to match the fork and branch.
Works for Azure Pipelines, CircleCI, GitHub Actions, and Travis CI.
[Documentation](git-clone-related) at top of file.

Suppose you have two related Git repositories:\
  *MY-ORG*`/`*MY-REPO*\
  *MY-ORG*`/`*MY-OTHER-REPO*

In a CI job that is testing branch BR in fork F of *MY-REPO*,
you would like to use fork F of *MY-OTHER-REPO* if it exists,
and you would like to use branch BR if it exists.
Here is how to accomplish that:

```
  if [ -d "/tmp/$USER/git-scripts" ] ; then
    git -C /tmp/$USER/git-scripts pull -q > /dev/null 2>&1
  else
    mkdir -p /tmp/$USER && git -C /tmp/$USER clone --depth 1 -q https://github.com/plume-lib/git-scripts.git
  fi
  /tmp/$USER/git-scripts/git-clone-related codespecs fjalar
```

### git-find-fork

Finds a fork of a GitHub repository, or returns the upstream repository
if the fork does not exist.
[Documentation](git-find-fork) at top of file.

### git-find-branch

Tests whether a branch exists in a Git repository;
prints the branch, or prints "master" if the branch does not exist.
[Documentation](git-find-branch) at top of file.

### resolve-import-conflicts

Edits files in place to resolve git conflicts that arise from Java `import`
statements.
[Documentation](resolve-import-conflicts) at top of file.

### resolve-adjacent-conflicts

Edits files in place to resolve git conflicts that arise from edits to
adjacent lines.
[Documentation](resolve-adjacent-conflicts) at top of file.
