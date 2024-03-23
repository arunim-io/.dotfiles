local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "terafox"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
