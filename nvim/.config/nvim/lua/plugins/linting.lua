local linters_by_filetypes = {
    python = { "ruff" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    yaml = { "yamllint" },
}

local function try_lint()
    local nvim_lint = require("lint")
    local names = nvim_lint._resolve_linter_by_ft(vim.bo.filetype)
    -- Add fallback linters.
    if #names == 0 then
        vim.list_extend(names, nvim_lint.linters_by_ft["_"] or {})
    end
    -- Add global linters.
    vim.list_extend(names, nvim_lint.linters_by_ft["*"] or {})

    -- Filter out linters that don't exist or don't match the condition.
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
    names = vim.tbl_filter(function(name)
        local linter = nvim_lint.linters[name]
        if not linter then
            vim.notify("Linter " .. name .. " does not exist", vim.log.levels.WARN)
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
    end, names)

    local fidget = require("fidget")
    -- Run linters.
    if #names > 0 then
        nvim_lint.try_lint(names)
        local linters = nvim_lint.get_running()

        -- run notify only when linters are present
        if #linters == 0 then
            fidget.notify("✔ Linting completed", vim.log.levels.INFO, { title = "Linting" })
        else
            fidget.notify("Linting using " .. table.concat(linters, ", "), vim.log.levels.INFO, { title = "Linting" })
        end
    end
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local linter = require("lint")
        linter.linters_by_ft = linters_by_filetypes

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("linting", { clear = true }),
            callback = try_lint,
        })
    end,
}
