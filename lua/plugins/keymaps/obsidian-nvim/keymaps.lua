--_G.debug_functions = require("plugins.keymaps.obsidian-nvim.functions")
local functions = require("plugins.keymaps.obsidian-nvim.functions")
-- Map the function to a keybinding
print(vim.inspect(functions))
--print(vim.inspect(_G.debug_functions))
vim.keymap.set("n", "<leader>oo", ":cd ".. functions.vault_path .."<cr>")
-- search for files in full vault
vim.keymap.set("n", "<leader>of", ":Telescope find_files search_dirs={\""..functions.vault_path.."\"}<cr>")
vim.keymap.set("n", "<leader>os", ":Telescope live_grep search_dirs={\""..functions.vault_path.."\"}<cr>")
vim.keymap.set("n", "<leader>on", functions.obsidian_open_or_new, { desc = "Select folder and open file in the vault" } )
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown"},
    callback = function()
        vim.schedule(
        function()
            vim.keymap.set(
                "n",
                "<leader>od",
                function()
                    local absolute_path = vim.fn.expand("%:p")
                    print("Trying to delete " .. absolute_path)
                    functions.delete_note(absolute_path)
                end,
                {buffer = true, desc = "Delete Note open in the current buffer"}
            )
        end
        )
    end
})


