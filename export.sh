#!/bin/sh
# Live ~/.config/herdr → this repo. Does not publish logs, sessions, or SSH machines.
set -eu
cd "$(dirname "$0")"
live="$HOME/.config/herdr"
test -f "$live/config.toml"

python3 - "$live/config.toml" config.toml << 'PY'
import pathlib, re, sys
src, dest = sys.argv[1:]
home = pathlib.Path.home().as_posix()
text = pathlib.Path(src).read_text()
bad = re.compile(
    r"(ghp_[A-Za-z0-9_]|github_pat_|sk-[A-Za-z0-9]|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|xox[baprs]-)"
)
if bad.search(text):
    sys.exit("refusing: config.toml looks like it contains a token")
foreign = [p for p in re.findall(r"/Users/[^/\s\"']+", text) if not p.startswith(home)]
if foreign:
    sys.exit("refusing: config.toml has a home path that is not $HOME: " + ", ".join(foreign))
pathlib.Path(dest).write_text(text.replace(home, "$HOME"))
PY

rm -rf plugins
mkdir -p plugins
if [ -d "$live/plugins/config" ]; then
  find "$live/plugins/config" -type f -print | while IFS= read -r f; do
    rel="${f#"$live/plugins/config/"}"
    mkdir -p "plugins/$(dirname "$rel")"
    cp "$f" "plugins/$rel"
  done
fi

herdr plugin list --json | python3 -c '
import json, sys
data = json.load(sys.stdin)["result"]["plugins"]
lines = []
for p in data:
    src = p.get("source") or {}
    if src.get("kind") != "github":
        continue
    source = src["owner"] + "/" + src["repo"]
    if src.get("subdir"):
        source += "/" + src["subdir"]
    lines.append("[[plugin]]")
    lines.append("id = \"%s\"" % p["plugin_id"])
    lines.append("source = \"%s\"" % source)
    lines.append("ref = \"%s\"" % src["resolved_commit"])
    lines.append("")
open("plugins.lock.toml", "w").write("\n".join(lines))
'
