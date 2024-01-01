local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.launch_menu = {
		{
			label = "PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		},
	}
	config.default_domain = "WSL:Arch"
end

config.scrollback_lines = 10000
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
	{ family = "JetBrainsMono Nerd Font", scale = 0.75 },
})
config.font_size = 11
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.color_scheme = "kanagawabones"

wezterm.on("update-right-status", function(window, pane)
	local cells = {}

	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	local colors = {
		"#3c1361",
		"#52307c",
		"#663a82",
		"#7c5295",
		"#b491c8",
	}

	local text_fg = "#c0c0c0"

	local elements = {}
	local num_cells = 0

	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

return config
