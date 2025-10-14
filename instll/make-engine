GREEN := [32m
YELLOW := [33m
RED := [31m
NC := [0m # No Color

# Rocks system version
ROCKS_VERSION = 0.5.2

# Core rocks system variables
ROCKS_SOURCE = $(shell git config --get rocks.source 2>/dev/null)

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
	@if [ -z "$(ROCKS_SOURCE)" ]; then \
		echo "❌ Rocks source not configured"; \
		echo "   Run: git config --global rocks.source YOUR_USERNAME/rocks"; \
		echo "   Example: git config --global rocks.source inem/rocks"; \
		exit 1; \
	fi
	@if [ -f $(LAST_MISSING) ]; then \
		target=$$(cat $(LAST_MISSING) | tr -d '\n'); \
		curl -fsSL "instll.sh/$(ROCKS_SOURCE)" | bash -s "make $$target"; \
		rm -f $(LAST_MISSING); \
	else \
		echo "No info about last failed command"; \
	fi

it!:
	@if [ -z "$(ROCKS_SOURCE)" ]; then \
		echo "❌ Rocks source not configured"; \
		echo "   Run: git config --global rocks.source YOUR_USERNAME/rocks"; \
		echo "   Example: git config --global rocks.source inem/rocks"; \
		exit 1; \
	fi
	@if [ -f $(LAST_MISSING) ]; then \
		target=$$(cat $(LAST_MISSING) | tr -d '\n'); \
		EXECUTE=1 bash -c 'curl -fsSL "instll.sh/$(ROCKS_SOURCE)" | bash -s "make '$$target'"'; \
		rm -f $(LAST_MISSING); \
	else \
		echo "No info about last failed command"; \
	fi

$(if $(filter rock,$(MAKECMDGOALS)),$(eval $(foreach arg,$(filter-out rock,$(MAKECMDGOALS)),$(arg): ; @:)))

rock:
	@if [ -z "$(ROCKS_SOURCE)" ]; then \
		echo "❌ Rocks source not configured"; \
		echo "   Run: git config --global rocks.source YOUR_USERNAME/rocks"; \
		echo "   Example: git config --global rocks.source inem/rocks"; \
		exit 1; \
	fi
	@if [ -z "$(ARGS)" ]; then \
		echo "Usage: make rock <module-name> or make rock <user>/<module-name>"; \
		echo "Example: make rock git"; \
		echo "Example: make rock alice/docker"; \
		exit 1; \
	fi; \
	rock_path="$(firstword $(ARGS))"; \
	if echo "$$rock_path" | grep -q "/"; then \
		user=$$(echo "$$rock_path" | cut -d'/' -f1); \
		module_name=$$(echo "$$rock_path" | cut -d'/' -f2); \
		repo_path="$$user/makefiles"; \
	else \
		repo_path="$(ROCKS_SOURCE)"; \
		module_name="$$rock_path"; \
	fi; \
	target_file="make-$$module_name.mk"; \
	temp_file="/tmp/make-$$module_name-$$$$.mk"; \
	echo "📥 Downloading make-$$module_name from $$repo_path..."; \
	if curl -sSL "https://instll.sh/$$repo_path/make-$$module_name" -o "$$temp_file" && [ -s "$$temp_file" ] && ! grep -q "404: Not Found" "$$temp_file"; then \
		: ; \
	else \
		echo "❌ Failed to download make-$$module_name (not found)"; \
		rm -f "$$temp_file"; \
		exit 1; \
	fi; \
	if [ -f "$$target_file" ]; then \
		echo "⚠️  $$target_file exists, will add new commands in 9s..."; \
		echo "   Press Ctrl+C to cancel"; \
		for i in 9 8 7 6 5 4 3 2 1; do \
			printf "\r   Adding in $$i seconds... "; \
			sleep 1; \
		done; \
		printf "\r                               \r"; \
		echo "🔍 Adding new commands..."; \
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


