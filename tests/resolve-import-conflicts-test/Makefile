test: diff

diff: MergedGoal.java Merged1.java Merged2.java
	diff -u MergedGoal.java Merged1.java
	diff -u MergedGoal.java Merged2.java

clean:
	rm -f Merged1.java Merged2.java

Merged1.java: Parent1.java Base.java Parent2.java
	-git merge-file -q -p $^ > $@
	../../resolve-import-conflicts $@

Merged2.java: Parent1.java Base.java Parent2.java
	-git merge-file -q -p $^ > $@
	../../resolve-import-conflicts $@

MergedByGit.java: Parent1.java Base.java Parent2.java
	-git merge-file -q  -p $^ > $@
