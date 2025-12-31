#!/bin/bash

# management_hub.sh - Updates the Global AI Context Hub

# Configuration
TAILWIND_REPO="https://github.com/tailwindlabs/tailwindcss.com"
TAILWIND_BRANCH="v4-beta-docs"
TAILWIND_DEST="tailwind-v4"

GHOST_REPO="https://github.com/TryGhost/docs"
GHOST_BRANCH="main" 
GHOST_DEST="ghost-v6"

ALPINE_REPO="https://github.com/alpinejs/alpine"
ALPINE_BRANCH="main"
ALPINE_DEST="alpine-v3"

# Function: Sync generic repo
sync_repo() {
    NAME=$1
    REPO=$2
    BRANCH=$3
    DEST=$4
    SUBPATH=$5

    echo "🔄 Syncing $NAME ($BRANCH)..."
    
    # Temp dir for cloning
    TEMP_DIR="temp_${NAME// /_}_clone"
    rm -rf "$TEMP_DIR"
    
    # Clone specific branch
    git clone --branch "$BRANCH" --depth 1 "$REPO" "$TEMP_DIR" 2>/dev/null || git clone --branch "$BRANCH" "$REPO" "$TEMP_DIR"

    if [ ! -d "$TEMP_DIR" ]; then
        echo "❌ Failed to clone $NAME"
        echo "   Please check repo URL and branch name."
        return
    fi

    # Prepare destination (Fresh start)
    rm -rf "$DEST"
    mkdir -p "$DEST"

    # Copy content
    if [ -z "$SUBPATH" ]; then
        # Copy everything excluding .git
        echo "   Copying full repo..."
        rsync -av --exclude='.git' "$TEMP_DIR/" "$DEST/" > /dev/null
    else
        # Copy specific subpath
        echo "   Extracting $SUBPATH..."
        if [ -d "$TEMP_DIR/$SUBPATH" ]; then
             rsync -av "$TEMP_DIR/$SUBPATH/" "$DEST/" > /dev/null
        else
            echo "⚠️  Subpath $SUBPATH not found in $NAME"
        fi
    fi

    # Cleanup
    rm -rf "$TEMP_DIR"
    echo "✅ $NAME sync complete in ./$DEST"
}

# --- Execution ---

# 1. Tailwind v4
# Source: src/pages/docs (contains .mdx files)
sync_repo "Tailwind CSS v4" "$TAILWIND_REPO" "$TAILWIND_BRANCH" "$TAILWIND_DEST" "src/pages/docs"

# 2. Ghost Docs
sync_repo "Ghost Docs" "$GHOST_REPO" "$GHOST_BRANCH" "$GHOST_DEST" ""

# 3. Alpine.js
sync_repo "Alpine.js" "$ALPINE_REPO" "$ALPINE_BRANCH" "$ALPINE_DEST" "packages/docs/src"
