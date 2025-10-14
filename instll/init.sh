#!/bin/bash

# Initialize project with makefiles
# Usage: curl -sSL <URL>/init.sh | bash

echo "🚀 Initializing project with makefiles..."

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
