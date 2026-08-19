#!/usr/bin/env bash
# Install live True Detective into ~/Zomboid/mods as a REAL directory (rsync).
# PZ/Steam runtime can miss or skip symlinks that point outside the sandbox.
# Never installs from legacy/.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/Contents/mods/TrueDetective"
DEST="${HOME}/Zomboid/mods/TrueDetective"
DEFAULT="${HOME}/Zomboid/mods/default.txt"

mkdir -p "${HOME}/Zomboid/mods"
test -f "$SRC/mod.info" || { echo "missing $SRC/mod.info"; exit 1; }
test -d "$SRC/42.0/media" || { echo "missing $SRC/42.0/media"; exit 1; }

# replace symlink or stale tree with a real copy
if [[ -L "$DEST" ]]; then
  rm -f "$DEST"
fi
mkdir -p "$DEST"
rsync -a --delete "$SRC/" "$DEST/"

# Same Mod ID from multiple roots dual-loads; old trees win if left stale.
# 1) Steam workshop content cache (subscribed item 3383387174)
WS_DEST="${HOME}/.local/share/Steam/steamapps/workshop/content/108600/3383387174/mods/TrueDetective"
if [[ -d "$(dirname "$WS_DEST")" ]]; then
  mkdir -p "$WS_DEST"
  rsync -a --delete "$SRC/" "$WS_DEST/"
  echo "Also synced Steam workshop cache: $WS_DEST"
fi
# 2) In-game Workshop upload package (Tools → Workshop → TrueDetective)
#    Path: ~/Zomboid/Workshop/TrueDetective/Contents/mods/TrueDetective
#    This was still shipping SurveySense and was what the client ran.
PKG_DEST="${HOME}/Zomboid/Workshop/TrueDetective/Contents/mods/TrueDetective"
if [[ -d "${HOME}/Zomboid/Workshop/TrueDetective" ]]; then
  mkdir -p "$PKG_DEST"
  rsync -a --delete "$SRC/" "$PKG_DEST/"
  echo "Also synced Zomboid Workshop package: $PKG_DEST"
fi

# enable in default modlist (ActiveModsFile format) if not already listed
if [[ ! -f "$DEFAULT" ]] || ! grep -q 'mod = TrueDetective' "$DEFAULT" 2>/dev/null; then
  cat >"$DEFAULT" <<'EOF'
VERSION = 1,

mods
{
	mod = TrueDetective,
}

maps
{
}
EOF
fi

# keep B42 reset marker so default.txt is not wiped empty
RESET="${HOME}/Zomboid/mods/reset-mods-42_00.txt"
if [[ ! -f "$RESET" ]]; then
  echo 'If this file does not exist, default.txt will be reset to empty (no mods active).' >"$RESET"
fi

echo "Installed (real dir): $DEST"
echo "Enabled in: $DEFAULT"
ls -la "$DEST"
test -f "$DEST/mod.info" && echo "mod.info OK"
test -d "$DEST/42.0/media" && echo "42.0/media OK"
test ! -L "$DEST" && echo "not a symlink OK"
echo "Next: open Project Zomboid main menu → Mods → look for True Detective."
echo "If the client was already running, fully restart it so it rescans mods."
