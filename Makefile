include make-*.mk

...:
	git add .
	git commit -m "..."

dog:
	sitedog render

sniff:
	sitedog sniff

dog-push:
	sitedog push

uncommit:
	git reset --soft HEAD^

push!:
	git push --force origin $(BRANCH)

push:
	git push origin $(BRANCH)

commit:
	git commit -m "..."

commit!:
	git commit -m "..."
	git push origin $(BRANCH)

fetch:
	git fetch
