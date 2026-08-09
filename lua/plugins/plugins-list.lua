local plugin = function(plugin, name)
    if name ~= nil then
        return { src = ghpack(plugin), name = name }
    end
    return ghpack(plugin) 
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

    plugin("folke/which-key.nvim", "whichkey"),
    plugin("folke/snacks.nvim", "snacks"),
    plugin("obsidian-nvim/obsidian.nvim", "obsidian"),
    plugin("MeanderingProgrammer/render-markdown.nvim"),
    plugin("lewis6991/gitsigns.nvim")
})

