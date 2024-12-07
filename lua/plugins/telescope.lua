return {
    {
        'nvim-telescope/telescope.nvim',
        -- pull specific version of the plugin
        tag = '0.1.8',
        dependencies = {
            -- general purpose plugin used to build user interfaces in neovim plugins
            'nvim-lua/plenary.nvim'
        },
        config = function()
            -- get access to telescopes built in function
            local builtin = require('telescope.builtin')
            -- set vim motion to <Space> + f + f to find files by name
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = '[F]ind [F]iles'})
            -- set vim motion to <Space> + f + f to find files by name
             vim.keymap.set('n', '<leader>fg', builtin.live_grep , {desc = '[F]ind [G]rep'})       
            -- set vim motion to <Space> + f + f to find files by name
             vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {desc = '[F]ind [D]iagnostics'})
            -- set vim motion to <Space> + f + f to find files by name
             vim.keymap.set('n', '<leader>fr', builtin.resume, {desc = '[F]inder [R]esume'})
            -- set vim motion to <Space> + f + f to find files by name
             vim.keymap.set('n', '<leader>f.', builtin.oldfiles, {desc = '[F]ind recent files ("." for repeat) '})
             -- set vim motion to <Space> + f + f to find files by name
             vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[F]ind existing [B]uffers'})
        end,
        event = "VeryLazy",
    },    
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        lazy = true,
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                },
                mappings = {
                    i = {
                        -- use <ctrl> + n to go to the next option
                        ["<C-n>"] = actions.cycle_history_next,
                        -- use <ctrl> + p to go to the previous option
                        ["<C-p>"] = actions.cycle_history_prev,
                        -- use <ctrl> + j to go to the next preview
                        ["<C-j>"] = actions.move_selection_next,
                        -- use <ctrl> + k to go to the previous preview
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                },
                require("telescope").load_extension("ui-select")
            })
        end
    }
}
