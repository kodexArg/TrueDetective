#!/usr/bin/env bash
# Install True Detective into ~/Zomboid/mods for local play (Linux).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/Contents/mods/TrueDetective"
DEST="${HOME}/Zomboid/mods/TrueDetective"
mkdir -p "${HOME}/Zomboid/mods"
ln -sfn "$SRC" "$DEST"
echo "Linked: $DEST -> $SRC"
echo "Next: launch Project Zomboid → Mods → enable True Detective → apply → restart if asked."
ls -la "$DEST"
test -f "$DEST/mod.info" && echo "mod.info OK" || { echo "mod.info missing"; exit 1; }
test -d "$DEST/42.0/media" -o -d "$DEST/42.20/media" && echo "version media OK" || { echo "version folder missing"; exit 1; }
