return {
    {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config =  function()
      local function on_attach_change(bufnr)
        -- Defining nt_api to stand for "nvim-tree.api"
        -- and configure custome keymaps that will be active only when NvimTree buffer is active
        local nt_api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        nt_api.config.mappings.default_on_attach(bufnr)
        -- nvim-tree-api.tree.change_root_to_node()
        vim.keymap.set( 'n', '<C-P>',
            function () nt_api.tree.toggle{file_path = true}
                end,
            opts("Toggle nvimtree")
        )
        -- Defining utf8 char searches for right and down arrow in file exporer to target folders
        vim.keymap.set("n", "!",
            "/\\(\\%uf460\\|\\%uf47c\\)<CR>",
            opts("Find NvimTree folder arrows to navigate to with n=next or N=previous")
        )
        -- Defining BackSpace to find the pattern of parent directory
        -- then accesing it
        vim.keymap.set("n", "<BS>",
            function ()
                vim.fn.search("\\/[A-z.]\\+\\/\\.\\.")
                -- params: 'n' keypressed, 'n' normal mode, true -> non-recursive and should be handeled on-spot
                vim.api.nvim_feedkeys('n', 'n', true)
                nt_api.tree.change_root_to_node()
            end,
            opts("Navigate to the previous root folder")
        )
    end

      require("nvim-tree").setup({
        on_attach = on_attach_change,
        view = { adaptive_size = true }
      })
    end
    }
}

