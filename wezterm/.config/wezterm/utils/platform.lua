local wezterm = require "wezterm"

M = {}

function M.is_linux()
    return wezterm.target_triple == "x86_64-unknown-linux-gnu"
end

function M.is_macos()
    return wezterm.target_triple == "x86_64-apple-darwin"
        or wezterm.target_triple == "aarch64-apple-darwin"
end

return M
