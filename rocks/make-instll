.PHONY: instll

instll:
	@for package in $(ARGS); do \
		echo "📦 Installing $$package..."; \
		curl -fsSL instll.sh/$$package | bash; \
		if [ $$? -eq 0 ]; then \
			echo "✅ $$package installed successfully"; \
		else \
			echo "❌ Failed to install $$package"; \
			exit 1; \
		fi; \
		echo ""; \
	done
