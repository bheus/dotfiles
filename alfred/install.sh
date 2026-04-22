#!/bin/sh
#
# Alfred
#
# Install workflow source directories into Alfred's workflows folder.
# Alfred rejects symlinked workflow directories, so we copy the directory
# itself but symlink the individual files inside, so edits in this repo
# take effect without re-running install.

ALFRED_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Alfred's sync folder (set in Alfred preferences). Fall back to the local
# default if the sync folder isn't configured.
SYNC_FOLDER="$(defaults read com.runningwithcrayons.Alfred-Preferences syncfolder 2>/dev/null | sed "s|^~|$HOME|")"
if [ -z "$SYNC_FOLDER" ]; then
  WORKFLOWS_DIR="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows"
else
  WORKFLOWS_DIR="$SYNC_FOLDER/Alfred.alfredpreferences/workflows"
fi

if [ ! -d "$WORKFLOWS_DIR" ]; then
  echo "✗ Alfred workflows directory not found: $WORKFLOWS_DIR"
  exit 1
fi

for src in "$ALFRED_DIR"/*.alfredworkflow; do
  [ -d "$src" ] || continue
  name="$(basename "$src" .alfredworkflow)"
  dest="$WORKFLOWS_DIR/dotfiles.$name"

  # Fresh directory, then symlink each file from source.
  # (Can't symlink the directory itself — Alfred won't load it.)
  rm -rf "$dest"
  mkdir -p "$dest"
  for f in "$src"/*; do
    [ -e "$f" ] || continue
    ln -sf "$f" "$dest/$(basename "$f")"
  done
done

echo "✓ Alfred workflows linked"

exit 0
