-- Pull in the wezterm API
local wezterm = require "wezterm"
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Set default_domain to wsl
config.default_domain = 'WSL:Ubuntu'

local wsl_domains = wezterm.default_wsl_domains()
for _, dom in ipairs(wsl_domains) do
  dom.default_cwd = "~"
end

config.wsl_domains = wsl_domains

-- For example, changing the color scheme:
-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "Dracula"
--config.color_scheme = "Dark Ocean (terminal.sexy)"

-- Set background to same color as neovim

-- old style background
--config.colors = {}
--config.colors.background = "#111111"
--config.window_background_opacity = .85

-- new style background
config.background = {
  {
    source = {Gradient={preset="GnBu"}},
    --opacity = .95,
    repeat_x = "Mirror",
    attachment = { Parallax = 0.1 },
  },
  {
    source = {File={path="C:\\Users\\David Engelmann\\.config\\wezterm\\sand_dunes.jpg"}},
    --opacity = .95,
--    horizontal_align = "Center",
--    vertical_align = "Middle",
--    height = "Contain",
--    width = "Contain",
--    repeat_x = "NoRepeat",
--    repeat_y = "NoRepeat",
    attachment = "Fixed",
  },
}


config.font = wezterm.font_with_fallback {
  "DejaVu Sans Mono",
  "PowerlineSymbols",
}

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- I didn't hear no bell
config.audible_bell = "Disabled"

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

local ssh_domains = require("extra.ssh")

config.ssh_domains = ssh_domains
-- spawn window
wezterm.on("gui_startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

config.use_dead_keys = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.hide_mouse_cursor_when_typing = true
config.show_update_window = true


config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config
