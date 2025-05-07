return {
    cmd = {
        "clangd",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "-j=4",
        "--rename-file-limit=0",
        "--background-index",
        "--background-index-priority=normal",
    },
    filetypes = { "c", "cpp" },
}
