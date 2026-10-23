# kumiko Configuration

> 🇷🇺 [Русская версия](README.ru.md)

kumiko is a personal tiling window manager for macOS that comes as one app: virtual workspaces
without SIP changes, hotkeys with modes, a status bar, window borders and vim modes in text fields.
It replaced yabai, skhd, JankyBorders, SketchyBar and SketchyVim in this repository.

The app is not published yet and is built from its own repository: `scripts/bundle.sh` produces
`dist/Kumiko.app`, and the `kumiko` CLI lives inside the bundle at
`Kumiko.app/Contents/MacOS/kumiko`. That is why it is not in the Brewfile.

## Files

| Source | Target |
| --- | --- |
| `home/dot_config/kumiko/kumiko.toml` | `~/.config/kumiko/kumiko.toml` |
| `home/dot_bin/raycast/executable_restart-vm.sh` | Raycast command `Restart WM` |

kumiko watches the config file and rereads it on change, so `chezmoi apply` is enough. A broken
file keeps the previous config in force and shows the error in the status menu and in
`kumiko status`.

## Config Sections

- `[wm]` and `[[wm.rule]]` - gaps, padding, which apps are tiled and whether their windows cast
  shadows (ported from yabairc)
- `[[workspace]]` - named workspaces, their display (`external` or `builtin`) and app assignments;
  their order is the order of the `alt - 1` … `alt - =` hotkeys
- `[hotkeys]` - bindings and modes (ported from skhdrc)
- `[borders]` - border width, radius, color and blacklist (ported from bordersrc)
- `[vim]` - vim modes in text fields with the Russian `langmap` (ported from svimrc)
- `[menubar]` - hides menu bar status items behind a chevron, the way Ice does; it replaced Ice here

## Window Shadows

`shadows = false` works through a scripting addition that kumiko loads into Dock, the way yabai did,
and it needs root:

```bash
sudo kumiko sa install   # copies the payload from Kumiko.app
kumiko sa status         # installed / loaded and its version
```

To let the app load it again after Dock restarts without a password, the fish function
`kumiko.sudoers` puts the line from `kumiko sa sudoers` into `/private/etc/sudoers.d/kumiko`, checking
it with `visudo` first. The line is pinned to the binary's hash, so run it again after every rebuild.

## Keybindings

| Keys | Action |
| --- | --- |
| `alt - 1` … `alt - =` | Focus workspace 1–12 |
| `alt - h/j/k/l` | Focus window west/south/north/east |
| `cmd + ctrl - i` | Window mode: focus, stack, float, zoom, resize, close, balance |
| `cmd + ctrl - m` | Move mode: warp windows, rotate and mirror the workspace |
| `cmd + ctrl - n` | Resize mode |
| `cmd + ctrl - o` | Stack mode |
| `cmd + ctrl - ;` | Command mode: `w` reloads the config, `l` sleeps the display |
| `escape` or `ctrl - [` | Back to the default mode |

The full list is in `kumiko.toml` itself.

## CLI

```bash
kumiko ping                  # is the app running
kumiko status                # modules, permissions, config path, last config error
kumiko reload                # reread kumiko.toml
kumiko settings              # open the read-only settings window
kumiko query workspaces      # state as JSON: windows | focused | workspaces | displays
kumiko workspace focus Code  # by name or number
kumiko menubar toggle        # show or hide the status items left of the divider
kumiko quit                  # quit, putting hidden windows back on screen
```

## Restarting

The Raycast command `Restart WM` finds `Kumiko.app` by its bundle id `online.aimuzov.kumiko`, calls
`kumiko quit` and opens the app again.
