#!/bin/bash

# Searches for make commands in remote repo and adds them to local Makefile
# Usage: curl -sSL <URL>/install.sh | sh -s "make deploy"
# Updated: force cache invalidation

REPO_URL="https://github.com/inem/rocks.git"
TEMP_DIR="/tmp/makefiles-$$"

if [[ -n "$1" ]]; then
    echo "💥 Failed command: $1"

    # Extract target from "make deploy" -> "deploy"
    target=$(echo "$1" | sed 's/^make[[:space:]]*//' | awk '{print $1}')

    if [[ -z "$target" ]]; then
        echo "❌ Could not determine make target"
        exit 1
    fi

    echo "📥 Fetching latest makefiles..."

    # Shallow clone repository temporarily (faster)
    if ! git clone --quiet --depth 1 "$REPO_URL" "$TEMP_DIR" 2>/dev/null; then
        echo "❌ Failed to clone repository $REPO_URL"
        exit 1
    fi

    echo "🔍 Searching for '$target' command..."

    # Search for command in all make-* files in rocks folder
    found_files=""
    # Escape dots for regex
    escaped_target=$(echo "$target" | sed 's/\./\\./g')
    for file in $(find "$TEMP_DIR/rocks" -name "make-*" 2>/dev/null); do
        if grep -q "^$escaped_target:" "$file" 2>/dev/null; then
            found_files="$found_files $file"
        fi
    done

    if [[ -z "$found_files" ]]; then
        echo "❌ Command '$target' not found in makefiles"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo "✅ Found '$target' command in:"
    for file in $found_files; do
        echo "  - $(basename "$file")"
    done

    # Take first found file (since we already verified it contains the target)
    source_file=$(echo "$found_files" | awk '{print $1}')

    if [[ -z "$source_file" ]]; then
        echo "❌ Could not find file with target '$target'"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    # Extract target and its commands
    target_block=$(awk "/^$escaped_target:/{flag=1} flag && /^[^[:space:]]/ && !/^$escaped_target:/{flag=0} flag" "$source_file")

    if [[ -z "$target_block" ]]; then
        echo "❌ Could not extract block for '$target'"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo ""
    echo "📝 Found block:"
    echo "$target_block"
    echo ""

    # Check if local Makefile exists
    if [[ ! -f "./Makefile" ]]; then
        echo "✅ Creating local Makefile"
        touch "./Makefile"
    fi

    # Check if target already exists in local Makefile
    if grep -q "^$escaped_target:" "./Makefile" 2>/dev/null; then
        echo "⚠️  Target '$target' already exists in local Makefile - skipping"
        rm -rf "$TEMP_DIR"
        exit 0
    fi

    if [[ "$EXECUTE" == "1" ]]; then
        # Execute mode - run the command directly
        echo "🚀 Executing command: $target"
        echo ""

        # Create temporary Makefile with the target
        temp_makefile="/tmp/temp_makefile_$$"
        echo "$target_block" > "$temp_makefile"

        # Execute the target
        make -f "$temp_makefile" "$target"
        exit_code=$?

        # Cleanup
        rm -f "$temp_makefile"
        rm -rf "$TEMP_DIR"

        exit $exit_code
    fi

    # Add new target
    echo "" >> "./Makefile"
    echo "$target_block" >> "./Makefile"

    echo "✅ Command '$target' added to local Makefile"
    echo "🚀 Now you can run: make $target"

    # Remove temporary repository
    rm -rf "$TEMP_DIR"

else
    echo "❌ No argument provided"
    exit 1
fi
