it:
	@last_cmd=$$(history | tail -2 | head -1 | sed 's/^[ ]*[0-9]*[ ]*//'); \
	curl -fsSL "https://raw.githubusercontent.com/inem/makefiles/refs/heads/main/install.sh" | sh -s "$$last_cmd"
