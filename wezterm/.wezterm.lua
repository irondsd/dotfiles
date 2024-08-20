-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- fonts 
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13.0

-- colors
config.color_scheme = 'Palenight (Gogh)'

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10

return config
