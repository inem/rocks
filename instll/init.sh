#!/bin/bash

# Initialize project with makefiles
# Usage: curl -sSL <URL>/init.sh | bash

echo "🚀 Initializing project with makefiles..."

# Configure all user settings at once
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    username=$(gh api user --jq '.login' 2>/dev/null)
    if [ -n "$username" ]; then
        git config --global github.user "$username" 2>/dev/null || true
        git config --global rocks.source "$username/rocks" 2>/dev/null || true
        echo "✅ Configured for GitHub user: $username"
    fi
fi

if command -v glab >/dev/null 2>&1 && glab auth status >/dev/null 2>&1; then
    username=$(glab api user --jq '.username' 2>/dev/null)
    if [ -n "$username" ]; then
        git config --global gitlab.user "$username" 2>/dev/null || true
        echo "✅ Configured GitLab user: $username"
    fi
fi

# Check final configuration
if git config --get rocks.source >/dev/null 2>&1; then
    echo "✅ Rocks source: $(git config --get rocks.source)"
else
    echo "⚠️  Rocks source not configured"
    echo "   Run: git config --global rocks.source YOUR_USERNAME/rocks"
    echo "   Example: git config --global rocks.source inem/rocks"
fi

# Download make-engine
echo "📥 Downloading make-engine..."
curl -fsSL "https://instll.sh/inem/rocks/rocks/make-engine" > "make-engine.mk" || {
    echo "❌ Failed to download make-engine"
    exit 1
}
echo "✅ Downloaded make-engine.mk"

# Create/update Makefile
if [[ -f "./Makefile" ]]; then
    if ! grep -q "include make-\*\.mk" "./Makefile" 2>/dev/null; then
        echo "📝 Adding include make-*.mk to existing Makefile..."
        echo -e "include make-*.mk\n$(cat ./Makefile)" > ./Makefile.tmp
        mv ./Makefile.tmp ./Makefile
        echo "✅ Added include to Makefile"
    else
        echo "✅ Makefile already includes make-*.mk"
    fi
else
    echo "📝 Creating Makefile..."
    echo "include make-*.mk" > "Makefile"
    echo "✅ Created Makefile"
fi

echo ""
echo "🎉 Project initialized! Now you can:"
echo "  $ make <any-command>  # will auto-find and add commands"
echo "  $ make it             # manually find last failed command"
echo "  $ make info           # show all available variables"

echo ""
echo "Try:"
echo "  $ make deploy"
echo "  $ make it"
