test: diff

diff: MergedGoal.java Merged.java
	diff -u $^

clean:
	rm -f Merged.java MergedByGit.java

.PHONY: Merged.java
Merged.java: MergedByGit.java
	cp -pf $^ $@
	-../../resolve-adjacent-conflicts $@

MergedByGit.java: Parent1.java Base.java Parent2.java
	-git config --get diff.context
	-git -c merge.tool= merge-file -q  -p $^ > $@
	git config -l
	echo "---- start of MergedByGit.java ----"
	cat MergedByGit.java
	echo "---- end of MergedByGit.java ----"
