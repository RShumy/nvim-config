local plugin = function(plugin, name, opts)

    local plug = {}

    if name then
        plug = { src = ghpack(plugin), name = name }
    end

    if opts then
        plug["version"] = opts.version
    end 

    if plug["name"] or plug["version"] then
        return plug
    else
        return ghpack(plugin)
   end
end

vim.pack.add({
    -- themes
    -- plugin("Mofiqul/dracula.nvim"),
    plugin("AndresYague/dracula.nvim", "dracula"),

    -- nvim basics
    plugin("nvim-lua/plenary.nvim", "plenary"),
    -- treesitter dependency
    plugin("windwp/nvim-ts-autotag"),
    plugin("nvim-treesitter/nvim-treesitter", "treesitter"),
    plugin("nvim-tree/nvim-web-devicons", "web-dev-icons"),

    plugin("folke/which-key.nvim", "which-key"),
    plugin("folke/snacks.nvim", "snacks"),
    plugin("obsidian-nvim/obsidian.nvim", "obsidian"),
    plugin("MeanderingProgrammer/render-markdown.nvim", "render-markdown"),
    plugin("lewis6991/gitsigns.nvim", "gitsigns"),

    -- LSP
    plugin("mfussenegger/nvim-dap", "nvim-dap"),
    plugin("mfussenegger/nvim-jdtls", "nvim-jdtls"),
    plugin("mason-org/mason.nvim", "mason"),
    plugin("mason-org/mason-registry", "mason-registry"),
    plugin("neovim/nvim-lspconfig", "nvim-lspconfig"),
    plugin("mason-org/mason-lspconfig.nvim", "mason-lspconfig"),
    plugin("jay-babu/mason-nvim-dap.nvim", "mason-nvim-dap"),
    plugin("rcarriga/nvim-dap-ui", "nvim-dap-ui"),
    plugin("nvim-neotest/nvim-nio", "nvim-nio"),
    -- completions capabilities -- need to research
    -- blink.cmp use v1 until v2 is stable 
    plugin("saghen/blink.cmp", "blink-cmp", { version = vim.version.range("1.*") } ),
    plugin("L3MON4D3/LuaSnip", "luasnip", { version = vim.version.range("^2") }),
    plugin("rafamadriz/friendly-snippets", "friendly-snippets"),
})

