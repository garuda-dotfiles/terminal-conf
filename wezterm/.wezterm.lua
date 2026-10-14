local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Shell: Windows PowerShell (WezTerm defaults to cmd.exe on Windows)
config.default_prog = { "powershell.exe", "-NoLogo" }

-- Font: Comic Code for text, Nerd Font glyphs for icons (Alacritty cannot fall back like this)
config.font = wezterm.font_with_fallback({
  "Comic Code",
  "Symbols Nerd Font Mono", -- bundled with WezTerm
})
config.font_size = 12.0
-- Extra row spacing, as `font.offset.y = 6` / `glyph_offset.y = 3` did in Alacritty
config.line_height = 1.3

-- Colors: Solarized Osaka, the theme nvim uses with a transparent background.
-- Read from the plugin's extras so both stay in sync; fall back to a built-in scheme without it.
local osaka_dir = wezterm.home_dir .. "/AppData/Local/nvim-data/lazy/solarized-osaka.nvim/extras/wezterm"
if #wezterm.glob(osaka_dir .. "/solarized_osaka_dark.toml") > 0 then
  config.color_scheme_dirs = { osaka_dir }
  config.color_scheme = "Solarized Osaka"
else
  config.color_scheme = "Solarized Dark (Gogh)"
end

-- tmux (psmux) handles tabs and splits
config.enable_tab_bar = false
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }
config.audible_bell = "Disabled"

-- Special combos for tmux, sent as single characters like kitty did on Linux.
-- The table lives in tmux-conf/psmux.conf ("Terminal special combos").
local combos = {
  -- psmux prefix: ConPTY drops Ctrl from Ctrl+Space
  { "Space", "CTRL", "Õ" },
  -- resize pane
  { "phys:LeftBracket", "CTRL|ALT", "\u{a0}" },
  { "phys:RightBracket", "CTRL|ALT", "¡" },
  { "phys:LeftBracket", "CTRL|ALT|SHIFT", "¢" },
  { "phys:RightBracket", "CTRL|ALT|SHIFT", "£" },
  -- swap pane with neighbour
  { "phys:H", "CTRL|ALT|SHIFT", "¤" },
  { "phys:J", "CTRL|ALT|SHIFT", "¥" },
  { "phys:K", "CTRL|ALT|SHIFT", "¦" },
  { "phys:L", "CTRL|ALT|SHIFT", "§" },
  -- next/previous window, move window
  { "phys:Quote", "CTRL|ALT", "¨" },
  { "phys:Semicolon", "CTRL|ALT", "©" },
  { "phys:Quote", "CTRL|ALT|SHIFT", "°" },
  { "phys:Semicolon", "CTRL|ALT|SHIFT", "±" },
  -- new window in current directory
  { "Enter", "CTRL|ALT", "²" },
  -- move pane into the neighbouring column/row
  { "phys:H", "CTRL|SHIFT", "Ð" },
  { "phys:J", "CTRL|SHIFT", "Ñ" },
  { "phys:K", "CTRL|SHIFT", "Ò" },
  { "phys:L", "CTRL|SHIFT", "Ó" },
}
-- select window 1..9: Á..É (U+00C1..U+00C9)
for i = 1, 9 do
  table.insert(combos, { "phys:" .. i, "CTRL|ALT", utf8.char(0xC0 + i) })
end

config.keys = {}
for _, c in ipairs(combos) do
  table.insert(config.keys, { key = c[1], mods = c[2], action = wezterm.action.SendString(c[3]) })
end

return config
