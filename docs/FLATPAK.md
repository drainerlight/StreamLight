# Flathub Publishing Guide for StreamLight

This guide explains how to publish StreamLight on Flathub, making it available to Steam Deck users and other Linux desktop users.

## Prerequisites

- GitHub account with StreamLight fork
- Flathub account (https://flathub.org)
- Git configured locally

## Step 1: Fork Flathub Repository

1. Go to https://github.com/flathub/flathub
2. Fork the repository to your account
3. Clone it locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/flathub.git
   cd flathub
   ```

## Step 2: Add StreamLight Manifest

1. Create directory for StreamLight:
   ```bash
   mkdir -p new-entries/com.foggybytes.StreamLight
   ```

2. Copy the manifest from StreamLight repo:
   ```bash
   cp /path/to/StreamLight/com.foggybytes.StreamLight.json \
      new-entries/com.foggybytes.StreamLight/
   ```

3. Update manifest to use AppImage release instead of git tag

4. Add appdata.xml from StreamLight repo

## Step 3: Validate Manifest

```bash
flatpak-builder --repo=repo --force-clean build \
  new-entries/com.foggybytes.StreamLight/com.foggybytes.StreamLight.json
```

## Step 4: Create Pull Request to Flathub

1. Commit changes and push to your fork
2. Create PR to https://github.com/flathub/flathub
3. Wait for Flathub team review

## Steam Deck Installation

Once approved on Flathub, Steam Deck users can:

1. Open **Discover** (KDE App Store)
2. Search for "StreamLight"
3. Click **Install**

Done! ✅

## References

- Flathub Docs: https://docs.flathub.org/docs/for-app-authors/
- Steam Deck: https://github.com/FoggyBytes/StreamLight
