return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true, disable = {} },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
