# Serverless Makefile commands "package management"

Universal make command management system with automatic command discovery and installation from remote repository.

## 🚀 Quick Start

```bash
# Initialize in your project
curl -sSL instll.sh/inem/makefiles/init.sh | bash

# Usage
make deploy          # command not found
make it             # find and add command to local Makefile
make deploy         # now it works

# Or automatically
make some_command   # automatically finds, adds and executes
```

## 📋 How it works

- `make it` - find last failed command and add to Makefile
- `make it!` - find, add and execute immediately

## 🔧 Available Variables

System automatically detects variables for your project:

```bash
make info  # show all variables
```

### Users
- `EMAIL` - your git email
- `GITHUB_USER` - GitHub username (via CLI or API)
- `GITLAB_USER` - GitLab username (via CLI)

### Project
- `GIT_REPO` - owner/repo (e.g.: inem/makefiles)
- `GIT_URL` - full repository URL
- `BRANCH` - current branch

### Docker
- `REGISTRY` - automatically detected by platform:
  - GitHub: `ghcr.io/owner/repo`
  - GitLab: `registry.gitlab.com/owner/repo`
- `IMAGE_NAME` - image name (owner-repo)
- `IMAGE_TAG` - image tag (default: latest)

## 📚 Command Libraries

Commands are organized in thematic files:

- `make-git` - Git operations (develop, main, push, etc.)
- `make-rails` - Rails commands (bop, test, etc.)
- `make-docker` - Docker operations

## 🛠 Installation

### Automatic (recommended)
```bash
curl -sSL instll.sh/inem/makefiles/init.sh | bash
```

### Manual

```bash
curl -sSL instll.sh/inem/makefiles/Makefile > Makefile
```

## 🎯 Usage Examples

### Git operations
```bash
make develop    # git checkout develop
make main       # git checkout main
make push       # git push origin current_branch
```

### Docker
```bash
make build      # docker build
make run        # docker run
make push-image # docker push to registry
```

### Rails
```bash
make test       # run tests
make console    # rails console
make migrate    # rails db:migrate
```

## 🔄 How to add your own commands

1. Create PR with new `.mk` file
2. Or add commands to existing file
3. Commands become available to all system users

### Command format
```makefile
# make-example.mk
my_command:
	echo "Hello World"

complex_command:
	@echo "Complex command with variables"
	docker build -t $(REGISTRY):$(IMAGE_TAG) .
	docker push $(REGISTRY):$(IMAGE_TAG)
```

## 🚨 Troubleshooting

### Command not found
```bash
make unknown_command
# ❌ Command 'unknown_command' not found in repository
# 💡 You can still try: make it
```

### Variables issues
```bash
make info  # check all variables
```

### Clear cache
```bash
rm -rf /tmp/makefiles-*  # clear temporary files
```

## 📖 Advanced Usage

### Override variables
```makefile
# In your local Makefile
GITHUB_USER = my_custom_user
```

### Custom commands
```makefile
# Local commands have priority
deploy:
	@echo "My custom deploy command"
	make build
	make push-image
```

## 🤝 Contributing

1. Fork the repository
2. Create branch for new feature
3. Add commands to appropriate `.mk` file
4. Create Pull Request

## 📝 License

MIT License - use freely in any projects.
