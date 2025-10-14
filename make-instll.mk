# Package installation variables
GITHUB_USER = $(shell git config --get github.user 2>/dev/null)

# Ignore arguments when running instll
ifneq (,$(filter instll,$(MAKECMDGOALS)))
$(foreach arg,$(filter-out instll,$(MAKECMDGOALS)),$(eval $(arg): ; @:))
endif

.PHONY: instll

instll:
	@for package in $(ARGS); do \
		if echo "$$package" | grep -q "/"; then \
			full_package="$$package"; \
		else \
			if [ -n "$(GITHUB_USER)" ]; then \
				full_package="$(GITHUB_USER)/$$package"; \
			else \
				full_package="$$package"; \
			fi; \
		fi; \
		echo "📦 Installing $$full_package..."; \
		if curl -fsSL instll.sh/$$full_package | bash; then \
			echo "✅ $$full_package installed successfully"; \
		else \
			echo "❌ Failed to install $$full_package"; \
			exit 1; \
		fi; \
		echo ""; \
	done
