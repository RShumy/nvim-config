require("plugins.lsp.cmp")
require("plugins.lsp.mason")
require("plugins.lsp.mason-lspconfig")
require("plugins.lsp.nvim-dap")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                },
            },

            completion = {
                callSnippet = "Replace",
            },
        },
    },
})

vim.lsp.enable("lua_ls")
