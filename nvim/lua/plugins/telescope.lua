return {
  'nvim-telescope/telescope.nvim', 
  branch = '0.1.x',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = vim.fn.executable("make") == 1,
      config = function()
        require('telescope').load_extension('fzf')
      end
    },
  },
  keys = {
    { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
    { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Find Buffers" },
    { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  }
}
