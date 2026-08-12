require("plugins.lsp.cmp")
require("plugins.lsp.mason")
require("plugins.lsp.mason-lspconfig")
require("plugins.lsp.mason-tools")
require("plugins.lsp.nvim-dap")

local library = {}

for _, plugin in ipairs(vim.pack.get( { "snacks" } )) do
    library[#library + 1] = plugin.path
end

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

            workspace = {
                library = library,
                checkThirdParty = false
            },
        },
    },
})

vim.lsp.enable("lua_ls")
