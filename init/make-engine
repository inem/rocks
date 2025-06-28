GIT_REPO = $(shell git remote get-url origin | sed -E 's/.*[\/:]([^\/]+\/[^\/]+)\.git$$/\1/' | sed 's/\.git$$//')
GIT_URL = $(shell git remote get-url origin)
GITHUB_USER = $(shell \
	if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then \
		gh api user --jq '.login' 2>/dev/null; \
	elif git config --get user.email >/dev/null 2>&1; then \
		curl -s "https://api.github.com/search/users?q=$$(git config --get user.email)+in:email" | grep '"login"' | head -1 | cut -d'"' -f4 2>/dev/null; \
	else \
		echo "inem"; \
	fi)
EMAIL = $(shell git config --get user.email)
GITLAB_USER = $(shell \
	if command -v glab >/dev/null 2>&1 && glab auth status >/dev/null 2>&1; then \
		glab api user --jq '.username' 2>/dev/null; \
	else \
		echo "inem"; \
	fi)
REGISTRY = $(shell \
	if echo "$(GIT_URL)" | grep -q "github.com"; then \
		echo "ghcr.io/$(GIT_REPO)"; \
	elif echo "$(GIT_URL)" | grep -q "gitlab.com"; then \
		echo "registry.gitlab.com/$(GIT_REPO)"; \
	else \
		echo "registry.example.com/$(GIT_REPO)"; \
	fi)
IMAGE_NAME = $(shell echo "$(GIT_REPO)" | sed 's/\//-/g' | sed 's/\./-/g')
IMAGE_TAG = latest

USER = "$(shell id -u):$(shell id -g)"
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

ARGS            = $(filter-out $@,$(MAKECMDGOALS))   # allows: make foo bar
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

rock:
	@if [ -z "$(ARGS)" ]; then \
		echo "Usage: make rock <module-name>"; \
		echo "Example: make rock git"; \
		exit 1; \
	fi; \
	module_name="$(firstword $(ARGS))"; \
	target_file="make-$$module_name.mk"; \
	temp_file="/tmp/make-$$module_name-$$$$.mk"; \
	echo "📥 Downloading make-$$module_name from rocks..."; \
	curl -sSL "https://instll.sh/inem/makefiles/rocks/make-$$module_name" -o "$$temp_file" || { \
		echo "❌ Failed to download make-$$module_name"; \
		rm -f "$$temp_file"; \
		exit 1; \
	}; \
	if [ -f "$$target_file" ]; then \
		echo "⚠️  $$target_file exists, will merge new commands in 5s..."; \
		echo "   Press Ctrl+C to cancel"; \
		sleep 5; \
		echo "🔍 Merging new commands..."; \
		existing_commands=$$(grep "^[a-zA-Z][^:]*:" "$$target_file" 2>/dev/null | cut -d: -f1 | sort || true); \
		new_commands=$$(grep "^[a-zA-Z][^:]*:" "$$temp_file" 2>/dev/null | cut -d: -f1 | sort || true); \
		added_count=0; \
		for cmd in $$new_commands; do \
			if [ -n "$$cmd" ] && ! echo "$$existing_commands" | grep -q "^$$cmd$$"; then \
				if [ $$added_count -eq 0 ]; then \
					echo "" >> "$$target_file"; \
					echo "# Added by make rock $$module_name" >> "$$target_file"; \
				fi; \
				echo "➕ Adding command: $$cmd"; \
				awk "/^$$cmd:/{flag=1; print} flag && /^[^[:space:]]/ && !/^$$cmd:/{flag=0} flag && !/^$$cmd:/{print}" "$$temp_file" >> "$$target_file"; \
				added_count=$$((added_count + 1)); \
			fi; \
		done; \
		rm -f "$$temp_file"; \
		if [ $$added_count -eq 0 ]; then \
			echo "✅ No new commands to add"; \
		else \
			echo "✅ Added $$added_count new commands to $$target_file"; \
		fi; \
	else \
		mv "$$temp_file" "$$target_file"; \
		echo "✅ Downloaded $$target_file"; \
	fi; \
	echo "🚀 Now you can use commands from $$target_file"

info:
	@echo "EMAIL: $(EMAIL)"
	@echo "GITHUB_USER: $(GITHUB_USER)"
	@echo "GITLAB_USER: $(GITLAB_USER)"
	@echo
	@echo "GIT_REPO: $(GIT_REPO)"
	@echo "GIT_URL: $(GIT_URL)"
	@echo "BRANCH: $(BRANCH)"
	@echo
	@echo "REGISTRY: $(REGISTRY)"
	@echo "IMAGE_NAME: $(IMAGE_NAME)"

# Handle arguments for commands like 'make rock git'
%:
	@:
