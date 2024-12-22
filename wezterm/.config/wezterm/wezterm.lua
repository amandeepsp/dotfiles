local platform = require("utils.platform")
local projects = require("utils.projects")
local wezterm = require("wezterm")
local action = wezterm.action

local theme = require("colors.kanagawa-dragon")

local config = wezterm.config_builder()

if platform.is_macos() then
    -- `front_end` setinng can make font rendering
    -- a little bit better on macOS
    config.front_end = "WebGpu"
    config.font_size = 13.0
    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 30
end

if platform.is_linux() then
    config.font_size = 11.0
end

config.font = wezterm.font("SFMono Nerd Font")

config.scrollback_lines = 10000
config.colors = theme

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.use_fancy_tab_bar = false
config.inactive_pane_hsb = {
    saturation = 0.9,
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
    {
        key = "r",
        mods = "LEADER",
        action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
    },
    -- Tab Keybindings
    { key = "t", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "LEADER", action = action.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER", action = action.ActivateTabRelative(1) },
    { key = "n", mods = "LEADER", action = action.ShowTabNavigator },
    { key = "Q", mods = "LEADER", action = action.CloseCurrentTab({ confirm = true }) },
    {
        key = "n",
        mods = "LEADER",
        action = action.PromptInputLine({
            description = "Enter new tab name",
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
    { key = "p", mods = "LEADER", action = projects.choose_project() },
    { key = "f", mods = "LEADER", action = action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
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

    local text_fg = "#c0c0c0"

    local elements = {}
    local num_cells = 0

    local function push(text)
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Text = " " .. text .. " " })
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell)
    end

    window:set_right_status(wezterm.format(elements))
end)

return config
