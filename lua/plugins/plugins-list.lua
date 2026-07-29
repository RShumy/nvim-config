local plugin = function(plugin, name)
    return { src = _G.ghpack(plugin), name = name }
end

vim.pack.add({
    -- themes
    plugin("Mofiqul/dracula.nvim", "dracula-theme"),
    -- nvim basics
    plugin("nvim-lua/plenary.nvim", "plenary"),
    -- treesitter dependency
    plugin("windwp/nvim-ts-autotag"),
    plugin("nvim-treesitter/nvim-treesitter", "treesitter"),

    plugin("folke/which-key.nvim", "whichkey"),
    plugin("folke/snacks.nvim", "snacks"),
    plugin("nvim-tree/nvim-web-devicons", "web-dev-icons")
})

