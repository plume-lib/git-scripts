RESOLVER=../../resolve-import-conflicts

test: diff

diff: Merged_ConflictStyleMerge.diff Merged_ConflictStyleDiff3.diff

Merged_ConflictStyleMerge.diff: Merged_ConflictStyleMerge.goal Merged_ConflictStyleMerge.java
	diff -u $^ > $@

Merged_ConflictStyleDiff3.diff: Merged_ConflictStyleDiff3.goal Merged_ConflictStyleDiff3.java
	diff -u $^ > $@

clean:
	rm -f MergedByGit_ConflictStyleMerge.java MergedByGit_ConflictStyleDiff3.java
	rm -f Merged_ConflictStyleMerge.java Merged_ConflictStyleDiff3.java

Merged_ConflictStyleMerge.java: MergedByGit_ConflictStyleMerge.java
	cp -pf $^ $@
	-"${RESOLVER}" $@

Merged_ConflictStyleDiff3.java: MergedByGit_ConflictStyleDiff3.java
	cp -pf $^ $@
	-"${RESOLVER}" $@

MergedByGit_ConflictStyleMerge.java: Parent1.java Base.java Parent2.java
	-git -c merge.conflictStyle=merge -c diff.context=10 merge-file --no-diff3 -q  -p $^ > $@

MergedByGit_ConflictStyleDiff3.java: Parent1.java Base.java Parent2.java
	-git -c merge.conflictStyle=diff3 merge-file --diff3 -q  -p $^ > $@
