#!/bin/sh

## Run this script, or cut-and-paste its commands into a shell, to test
## your Git mergetool.

mkdir -p /tmp/"${USER}"
cd /tmp/"${USER}" || {
  echo "cannot cd to /tmp/${USER}"
  exit
}

rm -rf repo clone1 clone2

mkdir repo
cd repo || exit
git init --bare
cd ..

git clone repo clone1
cd clone1 || exit
printf 'Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9' > file.txt
echo 'Foo bar' > file2.txt
echo 'Baz quux' > file3.txt
git add file.txt file2.txt file3.txt
git commit -m "Initial contents"
git push -u origin HEAD
cd ..

git clone repo clone2

cd clone1 || exit
printf 'Line 1\nLine 2 in 1\nLine 3\nLine 4\nLine 5\nLine 6 in 1\nLine 7 in 1\nLine 8\nLine 9' > file.txt
echo 'Foo bar in 1' > file2.txt
echo 'Baz quux in 1' > file3.txt
git commit -m "Changes in clone 1" file.txt file2.txt file3.txt
git push
cd ..

cd clone2 || exit
printf 'Line 1\nLine 2\nLine 3\nLine 4 in 2\nLine 5\nLine 6\nLine 7 in 2\nLine 8 in 2\nLine 9' > file.txt
echo 'Baz quux in 2' > file3.txt
git commit -m "Changes in clone 2" file.txt file3.txt
git pull --no-rebase --no-ff
git mergetool
