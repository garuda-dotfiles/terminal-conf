# terminal-conf

Terminal configuration. Branch `master` holds the [kitty](https://sw.kovidgoyal.net/kitty/) config for
Linux (Garuda / Arch); branch `windows-cmd` holds a WezTerm config for Windows.

## Requirements

- kitty (tested with 0.49)
- The [Comic Code](https://tosche.net/fonts/comic-code) font: Medium, Bold, Italic and Bold Italic.
  Nerd Font icons come from the symbols font bundled with kitty.
- [tmux-conf](https://github.com/garuda-dotfiles/tmux-conf) for the special key combos

## Install

```bash
git clone https://github.com/garuda-dotfiles/terminal-conf ~/dotfiles-conf/terminal-conf
mv ~/.config/kitty ~/.config/kitty.bak   # keep the old config, if any
ln -s ~/dotfiles-conf/terminal-conf/kitty ~/.config/kitty
```

Reload a running kitty with `ctrl+shift+f5` (or `ctrl+shift+r`).

## Files

| File | Purpose |
| --- | --- |
| `kitty/kitty.conf` | Main configuration (kitty's full commented default with changes) |
| `kitty/current-theme.conf` | Colors, included at the end of `kitty.conf` |

## Settings

| Setting | Value |
| --- | --- |
| Font | Comic Code Medium 12pt, cell height +2px |
| Cursor | Beam, system blink rate; shell integration `no-cursor` |
| Tab bar | Bottom, fade style, purple active tab |
| Scrollback | 2000 lines |

### Colors

| Name | Value | Name | Value |
| --- | --- | --- | --- |
| background | `#201c33` | foreground | `#fff1e0` |
| cursor | `#d8dee9` | selection | `#000000` text on `#ffffff` |
| color0 / color8 | `#2f2a38` / `#8977a8` | color1 / color9 | `#ff87a5` / `#f2637e` |
| color2 / color10 | `#6eeb84` / `#afff61` | color3 / color11 | `#ffd080` / `#ffdf61` |
| color4 / color12 | `#80bdff` / `#7583ff` | color5 / color13 | `#b891ff` / `#b98aff` |
| color6 / color14 | `#3fc4c4` / `#2bedc0` | color7 / color15 | `#eee6ff` / `#ffffff` |

## Keys

`kitty_mod` is `ctrl+shift`. Changes from kitty's defaults:

| Keys | Action |
| --- | --- |
| `alt+c` / `alt+v` | Copy / paste (as well as `ctrl+shift+c` / `ctrl+shift+v`) |
| `ctrl+=` / `ctrl+-` / `ctrl+0` | Bigger / smaller / reset font size |
| `ctrl+shift+r` | Reload the config |

### tmux special combos

These keys send one character each to [tmux-conf](https://github.com/garuda-dotfiles/tmux-conf), which
binds the characters ("Terminal special combos" in `tmux.conf`). `ctrl+shift+h/j/k/l` no longer scroll
or switch kitty layouts, they are sent to tmux.

| Keys | Sends | tmux action |
| --- | --- | --- |
| `ctrl+alt+[` / `ctrl+alt+]` | U+00D6 / U+00A1 | Resize pane left / right |
| `ctrl+alt+shift+[` / `ctrl+alt+shift+]` | U+00A2 / U+00A3 | Resize pane up / down |
| `ctrl+alt+shift+h/j/k/l` | U+00A4..U+00A7 | Swap pane with its neighbour |
| `ctrl+shift+h/j/k/l` | U+00D0..U+00D3 | Move pane into the neighbouring column / row |
| `ctrl+alt+'` / `ctrl+alt+;` | U+00A8 / U+00A9 | Next / previous window |
| `ctrl+alt+shift+'` / `ctrl+alt+shift+;` | U+00B0 / U+00B1 | Move window right / left |
| `ctrl+alt+enter` | U+00B2 | New window in the current directory |
| `ctrl+alt+1`..`ctrl+alt+9` | U+00C1..U+00C9 | Select window N |

`ctrl+alt+[` sends U+00D6 because kitty strips U+00A0 (no-break space) as whitespace in `send_text`.
