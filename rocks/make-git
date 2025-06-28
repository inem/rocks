branch:
	git checkout $(ARGS) > /dev/null 2>&1 || git checkout -b $(ARGS)

staging:
	git checkout staging

develop:
	git checkout develop

new:
	git checkout $(ARGS) || git checkout -b $(ARGS)

stash:
	git stash save --keep-index --include-untracked

unstash:
	git stash apply

master:
	@ git status

history:
	git log

push:
	git push origin $(BRANCH)

push!:
	git push --force origin $(BRANCH)

pull:
	git pull origin $(BRANCH)

trunk:
	git checkout master

uncommit:
	git reset --soft HEAD^

remote:
	git remote -v

last-commit:
	git log -1 --pretty=%B

# merge feature branch to dev
merge-to:
	@	$(eval current_branch := $(BRANCH))
		 git checkout $(ARGS)
		 git merge $(current_branch) --no-edit
		 git push origin $(ARGS)
		 git checkout $(current_branch)

unmerge:
	git merge --abort

branch-reset:
	$(eval current_branch := $(BRANCH))
	git reset --hard origin/$(current_branch)

pull!:
	git pull origin $(BRANCH) --rebase

pull!!: branch-reset

unrebase:
	git rebase --abort

fetch:
	git fetch

commit:
	git commit -m "..."

commit!:
	git commit -m "..."
	git push origin $(BRANCH)

...:
	git add .
	git commit -m "..."
