-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- fonts 
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13.0

-- colors
config.color_scheme = 'Neutron'

-- window
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10
config.window_close_confirmation = 'NeverPrompt'


return config
