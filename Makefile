ARGS            = $(filter-out $@,$(MAKECMDGOALS))   # позволяет: make foo bar
LAST_MISSING    = .last_missing_target

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
		curl -fsSL "https://raw.githubusercontent.com/inem/makefiles/refs/heads/main/install.sh" | sh -s "make $$target"; \
		rm -f $(LAST_MISSING); \
	else \
		echo "Нет информации о последней упавшей команде"; \
	fi
