GIT_REPO := $(shell git remote get-url origin | sed -E 's/.*[\/:]([^\/]+\/[^\/]+)\.git$$/\1/' | sed 's/\.git$$//')
GIT_URL := $(shell git remote get-url origin)
REGISTRY := $(shell \
	if echo "$(GIT_URL)" | grep -q "github.com"; then \
		echo "ghcr.io/$(GIT_REPO)"; \
	elif echo "$(GIT_URL)" | grep -q "gitlab.com"; then \
		echo "registry.gitlab.com/$(GIT_REPO)"; \
	else \
		echo "registry.example.com/$(GIT_REPO)"; \
	fi)
CONTAINER_NAME := $(shell echo "$(GIT_REPO)" | sed 's/\//-/g' | sed 's/\./-/g')
IMAGE_TAG := latest

USER = "$(shell id -u):$(shell id -g)"
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

ARGS            = $(filter-out $@,$(MAKECMDGOALS))   # позволяет: make foo bar
LAST_MISSING    = .git/.last_missing_target

.DEFAULT:
	@if [ "$@" = "from" ] || [ "$@" = "it" ] || [ "$@" = "help" ]; then \
		: ; \
	else \
		echo "$@" > $(LAST_MISSING); \
		echo "Target '$@' not found. Try: make it"; \
		exit 1; \
	fi

it:
	@if [ -f $(LAST_MISSING) ]; then \
		target=$$(cat $(LAST_MISSING) | tr -d '\n'); \
		curl -fsSL "instll.sh/inem/makefiles" | bash -s "make $$target"; \
		rm -f $(LAST_MISSING); \
	else \
		echo "No info about last failed command"; \
	fi

it!:
	@if [ -f $(LAST_MISSING) ]; then \
		target=$$(cat $(LAST_MISSING) | tr -d '\n'); \
		EXECUTE=1 bash -c 'curl -fsSL "instll.sh/inem/makefiles" | bash -s "make '$$target'"'; \
		rm -f $(LAST_MISSING); \
	else \
		echo "No info about last failed command"; \
	fi

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

