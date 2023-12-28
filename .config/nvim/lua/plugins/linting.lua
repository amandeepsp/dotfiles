local linters_by_filetypes = {
  python = { "ruff" },
}

local function debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local linter = require("lint")
    linter.linters_by_ft = linters_by_filetypes

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("linting", { clear = true }),
      callback = debounce(100, function()
        linter.try_lint()
      end),
    })
  end,
}
