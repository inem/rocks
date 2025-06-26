BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

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

upd:
	@ make make!
	git merge master --no-edit

upd!:
	@	$(eval current_branch := $(BRANCH))
	@ make make!
	git fetch
	git checkout master
	git pull origin master
	git checkout $(current_branch)
	git merge master --no-edit

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


branch-diff:
	@if [ -z "$(ARGS)" ]; then \
		echo "Error: Please specify a branch name. Example: make branch-diff branch-name"; \
		exit 1; \
	fi
	@echo "Creating diff for branch $(ARGS)..."
	@git checkout $(ARGS)
	@git fetch origin master
	@git diff $$(git merge-base origin/master HEAD) > $(ARGS).diff.txt
	@echo "Diff saved to $(ARGS).diff.txt"
	@echo "List of changed files:"
	@git diff --name-only $$(git merge-base origin/master HEAD)

branch-diff-rb:
	@if [ -z "$(ARGS)" ]; then \
		echo "Error: Please specify a branch name. Example: make branch-diff-rb branch-name"; \
		exit 1; \
	fi
	@echo "Creating diff for Ruby files in branch $(ARGS)..."
	@git checkout $(ARGS)
	@git fetch origin master
	@git diff $$(git merge-base origin/master HEAD) -- '*.rb' > $(ARGS).rb.diff.txt
	@echo "Ruby diff saved to $(ARGS).rb.diff.txt"
	@echo "List of changed Ruby files:"
	@git diff --name-only $$(git merge-base origin/master HEAD) -- '*.rb'
