#!/bin/sh
# This repo → ~/.config/herdr. Installs pinned GitHub plugins. Skips local herdr-tsk.
set -eu
cd "$(dirname "$0")"
live="$HOME/.config/herdr"
mkdir -p "$live"

stamp=$(date +%Y%m%d-%H%M%S)
if [ -f "$live/config.toml" ]; then
  cp -p "$live/config.toml" "$live/config.toml.bak-import-$stamp"
fi

python3 - config.toml "$live/config.toml" << 'PY'
import pathlib, sys
src, dest = sys.argv[1:]
home = pathlib.Path.home().as_posix()
text = pathlib.Path(src).read_text().replace("$HOME", home)
pathlib.Path(dest).write_text(text)
PY

if [ -d plugins ]; then
  find plugins -type f -print | while IFS= read -r f; do
    rel="${f#plugins/}"
    mkdir -p "$live/plugins/config/$(dirname "$rel")"
    cp "$f" "$live/plugins/config/$rel"
  done
fi

python3 - plugins.lock.toml << 'PY'
import json, pathlib, subprocess, sys
lock = pathlib.Path(sys.argv[1]).read_text().splitlines()
installed = {
    p["plugin_id"]
    for p in json.loads(subprocess.check_output(["herdr", "plugin", "list", "--json"]))["result"]["plugins"]
}
cur = {}
for line in lock:
    line = line.strip()
    if line.startswith("id = "):
        cur["id"] = line.split("=", 1)[1].strip().strip('"')
    elif line.startswith("source = "):
        cur["source"] = line.split("=", 1)[1].strip().strip('"')
    elif line.startswith("ref = "):
        cur["ref"] = line.split("=", 1)[1].strip().strip('"')
        if cur["id"] in installed:
            print("skip", cur["id"])
        else:
            subprocess.check_call(["herdr", "plugin", "install", cur["source"], "--ref", cur["ref"], "--yes"])
        cur = {}
PY

herdr config check
herdr server reload-config || true

for name in pi omp claude opencode; do
  herdr integration install "$name" || echo "skip integration $name"
done
