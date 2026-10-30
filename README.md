#  herdr-tui

Personal Herdr TUI setup.

This repo is the shareable copy. Herdr still reads `~/.config/herdr`. Do not set `HERDR_CONFIG_PATH`.

Not included: SSH machines, logs, session snapshots, plugin checkouts.

## New machine

Install Herdr, then paste this to an agent:

```text
Clone https://github.com/santychuy/herdr-tui and run ./import.sh from that clone.
import.sh copies config.toml to ~/.config/herdr/config.toml, copies plugin config, installs the GitHub plugins pinned in plugins.lock.toml, runs herdr config check, and reloads the running server.
Do not copy SSH machines, logs, or session snapshots.
herdr-tsk is not in this repo. prefix+t and prefix+q need tsk installed and its Herdr plugin linked separately.
Integrations installed when the agent config dir already exists: pi, omp, claude, opencode.
```

## After changing the live config

From this clone, run `./export.sh`, review `git diff`, commit, and push. `export.sh` rewrites your home directory to `$HOME` and refuses token-like strings.

## Keys

| Action | Binding |
|---|---|
| Prefix | `ctrl+a` |
| New tab | `prefix+n` |
| Close tab | `prefix+shift+w` |
| Switch tab | `prefix+1..9` |
| Split down / right | `prefix+.` / `prefix+/` |
| Focus pane | `prefix+h/j/k/l` |
| Zoom | `prefix+z` |
| Copy mode | `prefix+c` |
| Sidebar | `prefix+b` |
| Reload config | `ctrl+alt+r` |
| Radar flip / settings | `prefix+a` / `prefix+,` |
| Command bar | `prefix+shift+k` or `ctrl+alt+k` |
| TTT editor | `prefix+e` |
| File viewer | `prefix+f` |
| Worktrunk | `prefix+shift+n` / `prefix+shift+x` |
| Memex | `prefix+m` / `prefix+shift+m` |
| Token dashboard | `prefix+$` |
| tsk board / capture | `prefix+t` / `prefix+q` (plugin not in this repo) |

Full bindings are in `config.toml`.
