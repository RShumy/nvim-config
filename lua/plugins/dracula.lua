return {
  -- add dracula
    { "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 999,
        config = function()
            local dracula = require('dracula')
            dracula.setup( require('plugins.color-configs.dracula-config'))
            vim.cmd.colorscheme "dracula"
        end
    },
}
