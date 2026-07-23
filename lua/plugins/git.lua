return {
    {
        "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
        config = function ()

        require("gitsigns").setup({
            signs = {
                  add = { text = "│" },
                  change = { text = "│" },
                  delete = { text = "_" },
                  topdelete = { text = "‾" },
                  changedelete = { text = "~" },
                  untracked = { text = "┆" },
            },
            signs_staged = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable = true,
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })
            -- Set a vim motion to <Space> + g + h to preview changes to the file under the cursor in normal mode
            vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
        end
    },
    {
        "tpope/vim-fugitive",
		config = function()
			-- Set a vim motion to <Space> + g + b to view the most recent contributers to the file
			vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
			-- Set a vim motion to <Space> + g + <Shift>A to all files changed to the staging area
			vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
			-- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
			vim.keymap.set("n", "<leader>ga", ":Git add ", { desc = "[G]it [a]dd - specify file to add" })
			-- Set a vim motion to <Space> + g + c to commit the current chages
			vim.keymap.set("n", "<leader>gc", ":Git commit -m ", { desc = "[G]it [C]ommit" })
			-- Set a vim motion to <Space> + g + p to push the commited changes to the remote repository
			vim.keymap.set("n", "<leader>gp", ":Git push<cr>", { desc = "[G]it [p]ush" })
			-- Set a vim motion to <Space> + g + P to force push to origin the commited changes to the remote repository
			vim.keymap.set("n", "<leader>gP", ":Git push origin --force<cr>", { desc = "[G]it [P]ush force" })
			-- Set a vim motion to <Space> + g + s to switch branch from the remote repository
            vim.keymap.set("n", "<leader>gs", ":Git switch", { desc = "[G]it [S]wich branch" })
			-- Set a vim motion to <Space> + g + u to switch branch from the remote repository
            vim.keymap.set("n", "<leader>gu", ":Git pull", { desc = "[G]it P[u]ll" })

			-- Set a vim motion to <Space> + g + r to rebase interactively
			vim.keymap.set("n", "<leader>gr", ":Git rebase -i HEAD~", { desc = "[G]it [r]ebase - specify number of commits" })
		end,
    }
}
