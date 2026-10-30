#  herdr-tui

Personal Herdr TUI setup.

This repo is the shareable copy. Herdr still reads `~/.config/herdr`. Do not set `HERDR_CONFIG_PATH`.

Not included: SSH machines, logs, session snapshots, plugin checkouts.

## Plugins

Install each one with the pinned commit. `./import.sh` runs these same commands.

| Plugin | Repository | Install |
|---|---|---|
| Token Dashboard | [Davidcreador/herdr-token-dashboard](https://github.com/Davidcreador/herdr-token-dashboard) | `herdr plugin install Davidcreador/herdr-token-dashboard --ref 03872156075a50125aa5adffdd485d89fe965dfa --yes` |
| Bar | [jeffarese/herdr-bar](https://github.com/jeffarese/herdr-bar) | `herdr plugin install jeffarese/herdr-bar --ref 261de9b0441a6972941414bbf16eb4f5df27ac34 --yes` |
| File viewer | [smarzban/herdr-file-viewer](https://github.com/smarzban/herdr-file-viewer) | `herdr plugin install smarzban/herdr-file-viewer --ref 97ba479f6ecd577ca5acaad2f32983c852355f9f --yes` |
| Projects | [eliasstravik/herdr-projects](https://github.com/eliasstravik/herdr-projects) | `herdr plugin install eliasstravik/herdr-projects --ref 4aeaaba466b6ee8d534cee272c32b47c73fd0df4 --yes` |
| Radar | [hhdebb/herdr-radar](https://github.com/hhdebb/herdr-radar) | `herdr plugin install hhdebb/herdr-radar --ref 3e72fe2c22a30c983fc68f11144a94a9ae442f17 --yes` |
| Memex | [nicosuave/memex](https://github.com/nicosuave/memex) | `herdr plugin install nicosuave/memex --ref 66e9dfee2b30bf39d2e95ae8ab991c1ddb3551a6 --yes` |
| reviewr | [persiyanov/herdr-reviewr](https://github.com/persiyanov/herdr-reviewr) | `herdr plugin install persiyanov/herdr-reviewr --ref a253b1bfe4b34182af3204b7fcc42ccfed1b87d9 --yes` |
| TTT Editor | [eugenioenko/ttt](https://github.com/eugenioenko/ttt) (`herdr-plugin/`) | `herdr plugin install eugenioenko/ttt/herdr-plugin --ref ca3c4c64181518f0ea7d0101b907880b685258aa --yes` |
| Worktrunk | [devashish2203/herdr-worktrunk](https://github.com/devashish2203/herdr-worktrunk) | `herdr plugin install devashish2203/herdr-worktrunk --ref f9df9ba700b8a4f4d97ddfe3ea3eb345e80b880b --yes` |

`herdr-tsk` is local and not listed. `prefix+t` and `prefix+q` need `tsk` installed and its Herdr plugin linked on that machine.

## New machine

Install Herdr, then paste this to an agent:

```text
Clone https://github.com/santychuy/herdr-tui and run ./import.sh from that clone.
import.sh copies config.toml to ~/.config/herdr/config.toml, copies plugin config, runs every `herdr plugin install` command in the Plugins section, runs herdr config check, and reloads the running server.
If you are not using import.sh, run those nine install commands yourself. Each one is pinned with --ref.
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
