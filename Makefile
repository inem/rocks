USER = "$(shell id -u):$(shell id -g)"
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

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
		./install.sh "make $$target"; \
		rm -f $(LAST_MISSING); \
	else \
		echo "No info about last failed command"; \
	fi
