return {
  { "folke/which-key.nvim", opts = {} },
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup()
    end,
  },
}
