# One link is more than a million words:

```bash
curl -sSL instll.sh/inem/makefiles/init.sh | bash
```

(Non destructive action, will just add two files to you current folder)

# 🗿 Makefiles: The Philosophy of Instant Automation

> *"What if every command you've ever needed was just a `make it` away?"*

Welcome to a new paradigm in developer experience. This isn't just another tool—it's a movement toward **effortless automation**, **collective knowledge sharing**, and **the elimination of context switching**.

## 🎯 The Problem We're Solving

Picture this: You're deep in flow, building something amazing. Then you need to deploy. Or run tests. Or check the database. Suddenly you're:

- 🤔 **Googling commands** you've used 100 times before
- 📋 **Copy-pasting** from old projects or documentation
- 🔄 **Context switching** between your IDE, terminal, and browser
- 😤 **Losing momentum** while figuring out project-specific tooling

**Every broken command is a broken flow state.**

## 💡 The Solution: Collective Command Intelligence

What if the entire developer community shared a living, breathing repository of commands? What if **failing fast** became **succeeding faster**?

```bash
make deploy         # ❌ Command not found
make it             # ✨ Magic happens - command appears
make deploy         # ✅ Now it works perfectly
```

This is **make-driven development**: where your tools adapt to you, not the other way around.

## 🚀 Quick Start: From Zero to Hero in 30 Seconds

```bash
# 1. Initialize the magic
curl -sSL instll.sh/inem/rocks/init.sh | bash

# 2. Try any command (it will fail)
make deploy

# 3. Watch the magic happen
make it

# 4. Now it works!
make deploy
```

**That's it.** You now have access to hundreds of battle-tested commands.

## 🏗️ Core Philosophy: The Three Pillars

### 1. **Fail Fast, Succeed Faster**
Every failed command is an opportunity. When `make deploy` doesn't exist, `make it` finds it, installs it, and you're back to building.

### 2. **Collective Intelligence**
Why should everyone figure out Docker deployment separately? One person writes `make deploy`, everyone benefits.

### 3. **Zero Context Switching**
Stay in your terminal. Stay in your flow. Let the tools adapt to your rhythm.

## 🎪 The Magic Behind the Curtain

### Intelligent Command Discovery
```bash
make unknown-command
# Target 'unknown-command' not found. Try: make it

make it
# 💥 Failed command: make unknown-command
# 📥 Fetching latest makefiles...
# 🔍 Searching for 'unknown-command' command...
# ✅ Found 'unknown-command' command in: make-docker
# 📝 Adding to local Makefile...
```

### Smart Module System
```bash
make rock git       # Download git commands module
make rock rails     # Download rails commands module
make rock docker    # Download docker commands module
```

Commands are organized in **rocks** (modules) that you can pick and mix:
- 🔧 `make-git`: Git workflows (`push`, `pull`, `branch`, `merge-to`)
- 🚂 `make-rails`: Rails development (`console`, `test`, `migrate`)
- 🐳 `make-docker`: Container operations (`build`, `run`, `deploy`)
- 🔮 `make-engine`: The core system (auto-installed)

### Intelligent Merging
When you run `make rock git` twice:
```bash
⚠️  make-git.mk exists, will add new commands in 9s...
   Press Ctrl+C to cancel
🔍 Adding new commands...
➕ Adding command: branch-reset
➕ Adding command: uncommit
✅ Added 2 new commands to make-git.mk
```

Your customizations are preserved. Only new commands are added.

## 🧠 Learning Through Usage

This system teaches you **by doing**:

### Universal Variables
Every project gets smart defaults:
```bash
make info
# EMAIL: your@email.com
# GITHUB_USER: yourusername
# GIT_REPO: yourusername/yourproject
# REGISTRY: ghcr.io/yourusername/yourproject
# IMAGE_NAME: yourusername-yourproject
```

### Battle-Tested Patterns
```bash
# Git workflows
make develop        # Switch to develop branch
make main          # Switch to main branch
make push          # Push current branch
make pull!         # Force pull with rebase

# Docker patterns
make build         # Build with auto-detected registry
make run           # Run with proper port mapping
make logs          # Follow container logs

# Rails conventions
make c             # Rails console (no autocomplete)
make test          # Run test suite
make migrate       # Run pending migrations
```

### Progressive Enhancement
Start simple, grow complex:
```bash
# Beginner: Just works
make deploy

# Intermediate: Understand the pattern
make build push deploy

# Advanced: Customize for your needs
REGISTRY=my-registry.com make deploy
```

## 🌟 Real-World Usage Stories

### The Onboarding Experience
```bash
# New team member, first day
git clone company/awesome-project
cd awesome-project

# They try the obvious thing
make test
# ❌ Target 'test' not found. Try: make it

make it
# ✅ Found 'test' command in: make-rails
# 📝 Added to local Makefile

make test
# 🎉 Tests are running!
```

**Zero documentation needed. The system teaches itself.**

### The Context Switch Killer
```bash
# You're coding, need to deploy quickly
make deploy
# Works instantly - no googling, no copy-pasting

# Need to check logs?
make logs
# Streaming immediately

# Quick database check?
make console
# You're in, ready to debug
```

**Flow state preserved. Momentum maintained.**

### The Knowledge Multiplier
```bash
# You discover a better way to do something
vim rocks/make-rails
# Add your improved command

git push
# Now everyone on every project benefits
```

**Individual learning becomes collective wisdom.**

## 🔧 Advanced Patterns

### Project-Specific Customization
```makefile
# Your local Makefile
include make-*.mk

# Override defaults
REGISTRY = my-private-registry.com

# Add project-specific commands
setup:
	make migrate
	make seed
	make test

deploy-staging:
	ENVIRONMENT=staging make deploy
```

### Smart Error Handling
```bash
make rock nonexistent
# ❌ Failed to download make-nonexistent (not found in rocks/)

make it!  # Execute immediately after finding
# 🚀 Executing command: deploy
# [command runs immediately]
```

### Integration with Modern Workflow
```bash
# Works with your existing tools
make build          # Builds Docker image
make test           # Runs your test suite
make deploy         # Deploys to configured environment

# Composes beautifully
make build test deploy
```

## 🌍 The Bigger Picture: Developer Experience Revolution

This isn't just about commands. It's about **removing friction** from the creative process:

### Before Makefiles
```
Idea → Google → StackOverflow → Copy-paste → Debug → Modify → Finally works
```

### After Makefiles
```
Idea → make it → Works
```

### The Network Effect
- **Individual**: You save time and stay in flow
- **Team**: Shared knowledge, consistent workflows
- **Community**: Battle-tested patterns, continuous improvement
- **Industry**: Elevated baseline for developer experience

## 🚀 Installation & Getting Started

### One-Line Setup
```bash
curl -sSL instll.sh/inem/rocks/init.sh | bash
```

This creates:
- ✅ `Makefile` with `include make-*.mk`
- ✅ `make-engine.mk` with core functionality
- ✅ Smart defaults for your project

### First Commands to Try
```bash
make info           # See your project variables
make rock git       # Add git commands
make rock rails     # Add rails commands (if applicable)
make deploy         # Let it fail, then...
make it             # Watch the magic
```

## 🤝 Contributing: Join the Movement

### Adding Commands
```bash
# 1. Fork the repository
# 2. Add commands to appropriate rocks/make-* file
# 3. Submit PR

# Example: Adding to rocks/make-git
troubleshoot:
	git log --oneline -10
	git status
	git diff --stat
```

### Creating New Modules
```bash
# Create rocks/make-kubernetes
build-manifests:
	kustomize build . > manifests.yaml

deploy-k8s:
	kubectl apply -f manifests.yaml
```

### Philosophy Guidelines
- **Commands should be memorable** (`make deploy`, not `make deploy-to-production-with-rollback`)
- **Embrace convention over configuration** (smart defaults)
- **Optimize for flow state** (no prompts, no confirmations in common paths)
- **Make it teachable** (commands should be self-explanatory)

## 🔮 Future Vision

Imagine a world where:
- ✨ **Every project** has instant, discoverable commands
- 🧠 **Collective intelligence** eliminates repetitive learning
- 🌊 **Flow state** is the default developer experience
- 🚀 **Automation** is effortless and shareable

This is just the beginning. **Make** was created in 1976. It's time for an upgrade.

## 📚 Learn More

- 🏠 **[Live Demo](https://makefiles.rocks)** - See it in action
- 🗿 **[Rock Collection](https://github.com/inem/rocks/tree/main/rocks)** - Browse available modules
- 💬 **[Discussions](https://github.com/inem/rocks/discussions)** - Share patterns and ideas
- 🐛 **[Issues](https://github.com/inem/rocks/issues)** - Report bugs or request features

---

**"The best tools are invisible. They get out of your way and let you create."**

Join the revolution. Make commands, not barriers.

```bash
curl -sSL instll.sh/inem/rocks/init.sh | bash
```

---

😤 Built by annoyed developers — for annoyed developers.
