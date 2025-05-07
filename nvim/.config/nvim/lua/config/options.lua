-- enable line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true
-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.incsearch = true --enable incremental search
vim.opt.wrap = false -- disable line wrap
vim.opt.autowrite = true -- Auto save
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.laststatus = 3 -- global statusline
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.splitbelow = true
vim.opt.splitright = true

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- diagnostic config
vim.diagnostic.config({
    severity_sort = true,
    float = { source = "if_many" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
    virtual_text = {
        spacing = 2,
        source = "if_many",
    },
})
