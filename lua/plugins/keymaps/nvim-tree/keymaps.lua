local functions = require("plugins.keymaps.nvim-tree.functions")

vim.keymap.set(
    "n",
    "<leader>cp",
    functions.copy_nvim_tree_path,
    { noremap = true, silent = true, desc = "Copy nvim-tree path to clipboard" }
)

