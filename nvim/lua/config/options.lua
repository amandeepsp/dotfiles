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
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
end
vim.opt.incsearch = true --enable incremental search
vim.opt.wrap = false -- disable line wrap
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"