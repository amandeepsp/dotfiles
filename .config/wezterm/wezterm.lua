local wezterm = require("wezterm")
local action = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("SF Mono")
config.font_size = 13.0
config.scrollback_lines = 10000

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.use_fancy_tab_bar = false
config.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
}

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
    { key = "phys:Space", mods = "LEADER", action = action.ActivateCommandPalette },
    -- Pane Keybindings
    { key = "-", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
    { key = "q", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
    { key = "z", mods = "LEADER", action = action.TogglePaneZoomState },
    { key = "r", mods = "LEADER", action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    -- Tab Keybindings
    { key = "t", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "LEADER", action = action.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER", action = action.ActivateTabRelative(1) },
    { key = "n", mods = "LEADER", action = action.ShowTabNavigator },
    { key = "Q", mods = "LEADER", action = action.CloseCurrentTab({ confirm = true }) },
}

config.key_tables = {
    resize_pane = {
        { key = "h", action = action.AdjustPaneSize({ "Left", 1 }) },
        { key = "j", action = action.AdjustPaneSize({ "Down", 1 }) },
        { key = "k", action = action.AdjustPaneSize({ "Up", 1 }) },
        { key = "l", action = action.AdjustPaneSize({ "Right", 1 }) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter", action = "PopKeyTable" },
    },
}

wezterm.on("update-right-status", function(window, pane)
    local cells = {}

    if window:leader_is_active() then
        table.insert(cells, "Leader")
    end

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
