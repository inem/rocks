#!/bin/bash

# Initialize project with makefiles
# Usage: curl -sSL <URL>/init.sh | bash

BASE_URL="https://raw.githubusercontent.com/inem/makefiles/refs/heads/main/init"
MAKEFILE_URL="$BASE_URL/Makefile"
ENGINE_URL="$BASE_URL/make-engine"

echo "🚀 Initializing project with makefiles..."

# Download make-engine file
echo "📥 Downloading make-engine..."
if curl -fsSL "$ENGINE_URL" > "make-engine"; then
    echo "✅ Downloaded make-engine"
else
    echo "❌ Failed to download make-engine"
    exit 1
fi

# Check if Makefile already exists
if [[ -f "./Makefile" ]]; then
    echo "⚠️  Makefile already exists"

    # Check if it already includes make-*.mk
    if grep -q "include make-\*\.mk" "./Makefile" 2>/dev/null; then
        echo "✅ Makefile already includes make-*.mk"
    else
        echo "📝 Adding include make-*.mk to existing Makefile..."
        # Add include at the top of the file
        echo -e "include make-*.mk\n$(cat ./Makefile)" > ./Makefile.tmp
        mv ./Makefile.tmp ./Makefile
        echo "✅ Added include to Makefile"
    fi
else
    echo "📥 Downloading Makefile..."
    if curl -fsSL "$MAKEFILE_URL" > "Makefile"; then
        echo "✅ Downloaded Makefile"
    else
        echo "❌ Failed to download Makefile"
        exit 1
    fi
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
