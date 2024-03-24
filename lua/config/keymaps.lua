-- Map Leader key "<leader>"
vim.g.mapleader = " " 
vim.g.maplocalleader = " "
-- Which Key
vim.keymap.set("n", "<leader>", ":WhichKey<cr>", {desc = "Toggle WhichKey"})
-- Nvim Tree file explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", {desc = "Toggle NvimTree Explorer window"} )
-- Defining utf8 char searches for right and down arrow in file exporer
-- to target folders
-- vim.keymap.set("n", "!", "/\\(\\%uf460\\|\\%uf47c\\)<CR>", {desc = "Find NvimTree folder arrows to navigate to with (n)ext"})
-- vim.keymap.set("n", "<BS>", "/\\/[A-z.]+\\/\\.\\.<CR><Ctrl-]>")
-- Search
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<cr>", {silent = true, noremap = true})

-- Navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", {noremap = true})

-- Practice simple navigation in normal mode with H-left J-down K-up L-right
vim.api.nvim_set_keymap("n", "<left>", ":lua print(\"USE 'h' to move left\")<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<right>", ":lua print(\"USE 'l' to move right\")<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<up>", ":lua print(\"USE 'k' to move up\")<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<down>", ":lua print(\"USE 'j' to move down\")<cr>", { noremap = true })

-- Indenting
vim.keymap.set("n", ">", "v0$>g<ESC>", {desc = "Indent right in normal mode"})
vim.keymap.set("n", "<", "v0$<g<ESC>", {desc = "Indent left in normal mode"})

vim.keymap.set("v", ">", ">gv", {desc = "Indent right in visual mode"})
vim.keymap.set("v", "<", "<gv", {desc = "Indent left in visual mode"})

-- Split Windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", {desc = "Window Split vertical"})
vim.keymap.set("n", "<leader>wh", ":split<cr>", {desc = "Window Split horizontal"})

-- Comment Lines
local function comment()
end
