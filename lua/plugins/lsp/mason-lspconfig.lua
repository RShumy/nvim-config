require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls", "jdtls"},
    automatic_enable = {
        exclude = {
            "jdtls",
        },
    },
})
