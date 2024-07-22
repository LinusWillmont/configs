local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Settings
config.default_workspace = "home"
config.scrollback_lines = 3000

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = true })

config.window_background_opacity = 0.9
--config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
