local wezterm = require("wezterm")

M = {}

local core_project_dirs = { wezterm.home_dir .. "/dev", wezterm.home_dir .. "/personal" }

local function project_dirs()
    local projects = { wezterm.home_dir }
    for _, value in ipairs(core_project_dirs) do
        table.insert(projects, value)
    end

    for _, project_dir in ipairs(core_project_dirs) do
        for _, dir in ipairs(wezterm.glob(project_dir .. "/*")) do
            table.insert(projects, dir)
        end
    end

    return projects
end

function M.choose_project()
    local choices = {}
    for _, value in ipairs(project_dirs()) do
        table.insert(choices, { label = value })
    end

    return wezterm.action.InputSelector({
        title = "Choose a project",
        choices = choices,
        fuzzy = true,
        action = wezterm.action_callback(function(child_window, child_pane, id, label)
            if not label then
                return
            end

            child_window:perform_action(
                wezterm.action.SwitchToWorkspace({
                    name = label:match("([^/]+)$"),
                    spawn = { cwd = label },
                }),
                child_pane
            )
        end),
    })
end

return M
