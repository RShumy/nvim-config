local plugin = function(plugin, name)
    return { src = _G.ghpack(plugin), name = name }
end

vim.pack.add({
    -- themes
    plugin("Mofiqul/dracula.nvim", "dracula-theme"),
    -- nvim basics
    plugin("nvim-lua/plenary.nvim", "plenary"),
    plugin("folke/which-key.nvim", "whichkey"),
    -- treesitter dependency
    plugin("windwp/nvim-ts-autotag"),
    plugin("nvim-treesitter/nvim-treesitter", "treesitter"),
})

