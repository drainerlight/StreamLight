#!/bin/bash
set -euo pipefail

# Local Flatpak build script - for testing without GitHub Actions

VERSION="${1:-$(git describe --tags --always 2>/dev/null || echo 'dev')}"

echo "Building Flatpak for StreamLight v${VERSION}..."

# Ensure Flathub remote is available
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true

# Install required SDK/Platform if not present
echo "Installing KDE Platform 6.7..."
flatpak install -y --noninteractive flathub org.kde.Platform//6.7 org.kde.Sdk//6.7 org.kde.Sdk.Compat.x86_64//6.7 || true

# Create build directories
BUILD_DIR="build/flatpak-build"
REPO_DIR="build/flatpak-repo"
mkdir -p "$BUILD_DIR" "$REPO_DIR"

# Update manifest with current version if needed
MANIFEST="com.foggybytes.StreamLight.json"
if [ -f "$MANIFEST" ]; then
    # Backup original
    cp "$MANIFEST" "$MANIFEST.bak"

    # Update tag to current version if building from latest
    if [ "$VERSION" != "dev" ]; then
        sed -i "s/\"tag\": \"[^\"]*\"/\"tag\": \"$VERSION\"/" "$MANIFEST" || true
    fi
fi

# Build Flatpak
echo "Building Flatpak bundle..."
flatpak-builder --repo="$REPO_DIR" --force-clean "$BUILD_DIR" "$MANIFEST"

# Create flatpak bundle
echo "Creating Flatpak bundle..."
flatpak build-bundle "$REPO_DIR" "StreamLight-${VERSION}-x86_64.flatpak" com.foggybytes.StreamLight

# Restore original manifest
if [ -f "$MANIFEST.bak" ]; then
    mv "$MANIFEST.bak" "$MANIFEST"
fi

echo "✅ Flatpak built successfully: StreamLight-${VERSION}-x86_64.flatpak"
ls -lh "StreamLight-${VERSION}-x86_64.flatpak"
