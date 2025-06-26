#!/bin/bash

# Initialize project with makefiles
# Usage: curl -sSL <URL>/init.sh | bash

MAKEFILE_URL="https://raw.githubusercontent.com/inem/makefiles/refs/heads/main/Makefile"

echo "🚀 Initializing project with makefiles..."

# Check if Makefile already exists
if [[ -f "./Makefile" ]]; then
    echo "⚠️  Makefile already exists"
    echo "📥 Downloading base Makefile to Makefile.base..."
    target_file="Makefile.base"
else
    echo "📥 Downloading Makefile..."
    target_file="Makefile"
fi

# Download Makefile
if curl -fsSL "$MAKEFILE_URL" > "$target_file"; then
    echo "✅ Downloaded to $target_file"
else
    echo "❌ Failed to download Makefile"
    exit 1
fi

# Make it executable if needed
chmod +x "$target_file" 2>/dev/null || true

echo ""
if [[ "$target_file" == "Makefile.base" ]]; then
    echo "🎉 Base Makefile saved! You can:"
    echo "  $ cp Makefile.base Makefile  # to replace current Makefile"
    echo "  $ make -f Makefile.base it   # to use base commands directly"
else
    echo "🎉 Project initialized! Now you can:"
    echo "  $ make <any-command>  # will show error and suggest 'make it'"
    echo "  $ make it             # will find and add the command from remote repo"
fi

echo ""
echo "Try:"
echo "  $ make deploy"
echo "  $ make it"
