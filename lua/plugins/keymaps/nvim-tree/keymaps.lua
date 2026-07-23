local functions = require("plugins.keymaps.nvim-tree.functions")

vim.keymap.set(
    "n",
    "<leader>cp",
    functions.copy_nvim_tree_path,
    { noremap = true, silent = true, desc = "Copy nvim-tree path to clipboard" }
)

vim.keymap.set(
    "n",
    "<C-]>",
    functions.cd_into_dir,
    { noremap = true, desc = "Nvim-tree \"cd\" into directory under the cursor for all buffers" }
)

