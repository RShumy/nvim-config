return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "windwp/nvim-ts-autotag"
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        -- gain access to treesitter config functions
        local ts_config = require("nvim-treesitter.configs")
        -- call the treesitter setup function with properties to configure our experience
        ts_config.setup({
            -- make sure that highlight servers are installed for these language syntaxes
            ensure_installed = {
                "vim",
                "vimdoc",
                "lua",
                "java",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "tsx",
                "xml",
                "markdown",
                "markdown_inline",
                "gitignore"
            },
            -- make sure highlighting is enabled
            highlight = { enable = true },
            -- enable tsx auto closing tag creation
            autotag = { enable = true }
        })
    end
}
