local functions = require("plugins.keymaps.obsidian.functions")
-- Map the function to a keybinding

vim.keymap.set("n", "<leader>oo", ":cd ".. functions.vault_path .."<cr>")
-- search for files in full vault
vim.keymap.set("n", "<leader>of", ":Telescope find_files search_dirs={\""..functions.vault_path.."\"}<cr>")
vim.keymap.set("n", "<leader>os", ":Telescope live_grep search_dirs={\""..functions.vault_path.."\"}<cr>")
vim.keymap.set("n", "<leader>on", functions.obsidian_open_or_new, { desc = "Select folder and open file in the vault" } )


