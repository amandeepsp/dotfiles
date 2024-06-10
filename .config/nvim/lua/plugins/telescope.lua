-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == "" then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require("telescope.builtin").live_grep({
            search_dirs = { git_root },
        })
    end
end

local function telescope_live_grep_open_files()
    require("telescope.builtin").live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            enabled = vim.fn.executable("make") == 1,
        },
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            pickers = {
                live_grep = {
                    additional_args = {
                        "--hidden",
                        "--glob",
                        "!{.git/*}",
                    },
                },
            },
            defaults = {
                file_ignore_patterns = { "node%_modules", "%.git" },
            },
        })

        local telescope_builtins = require("telescope.builtin")

        telescope.load_extension("fzf")

        vim.keymap.set("n", "<leader>?", telescope_builtins.oldfiles, { desc = "[?] Find recently opened files" })
        vim.keymap.set("n", "<leader><space>", telescope_builtins.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            telescope_builtins.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })
        vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
        vim.keymap.set("n", "<leader>ss", telescope_builtins.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>gf", telescope_builtins.git_files, { desc = "Search [G]it [F]iles" })
        vim.keymap.set("n", "<leader>sf", function()
            telescope_builtins.find_files({ hidden = true })
        end, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sh", telescope_builtins.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sw", telescope_builtins.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", telescope_builtins.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sG", live_grep_git_root, { desc = "[S]earch by [G]rep on Git Root" })
        vim.keymap.set("n", "<leader>sd", telescope_builtins.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", telescope_builtins.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>sb", telescope_builtins.buffers, { desc = "[S]earch [B]uffers" })
        vim.keymap.set("n", "<leader>sc", telescope_builtins.command_history, { desc = "[S]earch [c]ommand history" })
        vim.keymap.set("n", "<leader>sC", telescope_builtins.commands, { desc = "[S]earch [C]ommands" })

        telescope.load_extension("undo")
        vim.keymap.set("n", "<leader>u", telescope.extensions.undo.undo, { desc = "Search [U]ndo tree" })
    end,
}
