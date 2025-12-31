# Neovim Upgrade Guide - Debian 13

## Current Situation
- **Your Version**: Neovim 0.10.4 (Debian package)
- **Latest Version**: Neovim 0.11.5
- **Issue**: Deprecation warning about 0.10.x support being removed in lspconfig v3.0.0

## Recommended: Official AppImage Method

### Why AppImage?
✅ **Official**: Distributed by Neovim team
✅ **Latest version**: Always get v0.11.5 (or newer)
✅ **Self-contained**: No dependency conflicts
✅ **Easy rollback**: Keep old version if needed
✅ **Debian-friendly**: Works on any Linux distro

### Quick Upgrade (Automated)

```bash
# Run the upgrade script
bash /tmp/upgrade-neovim.sh
```

This will:
1. Download Neovim v0.11.5 AppImage
2. Test it works
3. Install to `/usr/local/bin/nvim`
4. Remove old Debian package (0.10.4)

### Manual Upgrade (Step-by-step)

If you prefer to do it manually:

```bash
# 1. Download AppImage
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim.appimage
chmod u+x nvim.appimage

# 2. Test it
./nvim.appimage --version

# 3. Install it
sudo mv nvim.appimage /usr/local/bin/nvim

# 4. Remove old package (optional but recommended)
sudo apt remove neovim
```

## Alternative Methods

### Option 2: Build from Source (Advanced)

For the absolute latest:

```bash
# Install build dependencies
sudo apt install ninja-build gettext cmake unzip curl build-essential

# Clone and build
cd /tmp
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable  # or: git checkout v0.11.5
make CMAKE_BUILD_TYPE=Release
sudo make install
```

**Pros**: Latest features, optimized for your system
**Cons**: Takes 5-10 minutes, requires build tools

### Option 3: Snap (Not Recommended)

```bash
sudo snap install nvim --classic
```

**Pros**: Easy one-liner
**Cons**: Snap sandboxing can cause issues with plugins, slower startup

## After Upgrade

### 1. Verify version:
```bash
nvim --version
# Should show: NVIM v0.11.5
```

### 2. Test config:
```bash
cd ~/.config/nvim
./test-compatibility.sh
```

Expected output:
```
Detected: Neovim 0.11.5
Config mode: 0.11+ (modern API)
✅ All tests passed!
```

### 3. Update config to use modern API:

Your config will automatically detect 0.11+ and enable modern features!

### 4. No more deprecation warning:
Open nvim - the warning will be gone ✨

## Rollback (If Needed)

If something goes wrong:

```bash
# Remove AppImage
sudo rm /usr/local/bin/nvim

# Reinstall Debian package
sudo apt install neovim
```

## What Changes in Your Config?

With Neovim 0.11+, your config will automatically:
- ✅ Enable `automatic_enable = true` in mason-lspconfig
- ✅ Use new `vim.lsp.enable()` API (via mason-lspconfig)
- ✅ Remove deprecation warning
- ✅ Get access to 0.11 features (better diagnostics, improved LSP, etc.)

**No manual changes needed** - version detection handles it!

## Recommendation

🎯 **Use the AppImage method** - it's the official way and takes 30 seconds:

```bash
bash /tmp/upgrade-neovim.sh
```

This gives you:
- Latest stable version (0.11.5)
- No deprecation warnings
- Modern LSP features
- Easy updates in the future

## Questions?

**Q: Will this break my config?**
A: No! Your config is version-aware and will adapt automatically.

**Q: Can I keep using 0.10.4?**
A: Yes, but you'll see the deprecation warning until you upgrade.

**Q: How do I update to newer versions later?**
A: Just download the new AppImage and replace `/usr/local/bin/nvim`

**Q: What about my plugins?**
A: All compatible - plugins work with 0.11+ (many even require it now)
