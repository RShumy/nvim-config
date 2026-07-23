return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "windwp/nvim-ts-autotag"
    },
    lazy = false,
    build = ':TSUpdate',
    -- Specificăm noul modul principal de configurare
    main = "nvim-treesitter.config",
    opts = {
        -- Limbajele pe care dorești să le instalezi automat
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
        highlight = { enable = true },
        -- Mutat direct sub structura principală conform noilor standarde
        autotag = { enable = true }
    }
}
