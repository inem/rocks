#!/bin/bash

# Initialize project with makefiles
# Usage: curl -sSL <URL>/init.sh | bash

MAKEFILE_URL="https://raw.githubusercontent.com/inem/makefiles/refs/heads/main/Makefile"

echo "🚀 Initializing project with makefiles..."

# Check if Makefile already exists
if [[ -f "./Makefile" ]]; then
    echo "⚠️  Makefile already exists"
    echo -n "Do you want to backup and replace it? (y/N): "
    read -r replace
    if [[ "$replace" =~ ^[Yy]$ ]]; then
        mv Makefile Makefile.backup
        echo "✅ Backed up existing Makefile to Makefile.backup"
    else
        echo "❌ Cancelled - keeping existing Makefile"
        exit 0
    fi
fi

# Download Makefile
echo "📥 Downloading Makefile..."
if curl -fsSL "$MAKEFILE_URL" > Makefile; then
    echo "✅ Makefile downloaded successfully"
else
    echo "❌ Failed to download Makefile"
    exit 1
fi

# Make it executable if needed
chmod +x Makefile 2>/dev/null || true

echo ""
echo "🎉 Project initialized! Now you can:"
echo "  $ make <any-command>  # will show error and suggest 'make it'"
echo "  $ make it             # will find and add the command from remote repo"
echo ""
echo "Try:"
echo "  $ make deploy"
echo "  $ make it"
