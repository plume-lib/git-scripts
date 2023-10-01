test: diff

diff: MergedGoal.java Merged.java
	diff -u $^

clean:
	rm -f Merged.java MergedByGit.java

.PHONY: Merged.java
Merged.java: Parent1.java Base.java Parent2.java
	git config --get diff.context
	-git merge-file -q  -p $^ > $@
	-../../resolve-adjacent-conflicts $@

MergedByGit.java: Parent1.java Base.java Parent2.java
	git config --get diff.context
	-git merge-file -q  -p $^ > $@
