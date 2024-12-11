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

-- Quality of Life improvements for Text Movement and Copy, Paste  
    -- Persistent yanking into register "a 
    vim.keymap.set({"n","v"}, "y", "\"ay", {desc = "Copy selection into register: \"a "} )
    vim.keymap.set({"n","v"}, "Y", "\"aY", {desc = "Copy line into register: \"a "} )

    vim.keymap.set({"n","v"}, "x", "\"xx", {desc = "Cut selection into register: \"x "} )
    vim.keymap.set({"n","v"}, "X", "\"xX", {desc = "Cut selection into register: \"x "} )
    vim.keymap.set({"n","v"}, "d", "\"dd", {desc = "Delete (Cut) selection into register: \"d "} )
    vim.keymap.set({"n","v"}, "D", "\"dD", {desc = "Delete (Cut) to end of line into register: \"d "} )
    vim.keymap.set({"n","v"}, "c", "\"cc", {desc = "Insertion Cut selection into register: \"c "} )
    vim.keymap.set({"n","v"}, "C", "\"cC", {desc = "Insertion Cut to end of line into register: \"c "} )

     -- Much more versatile paste
       -- \"a represents the name of the register from which we paste text
       -- that is not overwritten by cutting or deleitng text with "c, x, d" 
    vim.keymap.set({"n","v"}, "p", "\"ap", {desc = "Paste append selection from register \"a"} )
    vim.keymap.set({"n","v"}, "P", "\"aP", {desc = "Paste insert selection from register \"a"} )
    vim.keymap.set({"n","v"}, "pc", "\"cp", {desc = "Paste append selection from Insertion Cut register\"c "} )
    vim.keymap.set({"n","v"}, "pC", "\"cP", {desc = "Paste insert selection from Insertion Cut register\"c "} )
    vim.keymap.set({"n","v"}, "pd", "\"dp", {desc = "Paste append selection from Delete register\"d "} )
    vim.keymap.set({"n","v"}, "pD", "\"dP", {desc = "Paste insert selection from Delete register\"d "} )
    vim.keymap.set({"n","v"}, "px", "\"xp", {desc = "Paste append selection from Eager Cut register\"x "} )
    vim.keymap.set({"n","v"}, "pX", "\"xP", {desc = "Paste insert selection from Eager Cut register\"x "} )
    vim.keymap.set({"n","v"}, "<leader>po", "<ESC><cr>i<cr><ESC>k\"ap", {desc = "Paste selection from register \"a on a new line below"} )
    vim.keymap.set({"n","v"}, "<leader>pO", "<esc>0i<cr><esc>k\"ap", {desc = "Paste selection from register \"a on a new line above"} )

    -- Mapping Ctrl-Alt - k or j to move the line under the cursor up or down
    -- Mapping Alt - k or j to move selected lines up or down
    --
    -- Move one line above
    vim.keymap.set("v", "<ESC><C-k>", ":m -2<CR>`[V`]", {desc = "Move visual selection lines one line up"} )
    vim.keymap.set("n", "<ESC><C-k>", ":m -2<CR>", {desc = "Move line under cursor one line up"} )

    -- Move one line below (Much more complicated than originally thought) explanation:
        -- We send the key ":" that will populate the command line with the visual mode expression ":'<'>"
        -- Then we send "m" to indicate the move command, and send the " +" to indicate we want to move the selection down
        -- Sending <C-r> will translate to Ctrl-r and will enter the registers buffer 
        -- From which we select the evaluate expression register by sending "=" key
        -- We evaluate the expression `line(\"'>\") - line(\"'<\") + 1` and return the result by sending the <CR>    
        -- The result is inserted in the command line mode and the final <CR> will execute the command
    vim.keymap.set("v", "<ESC><C-j>", ":m +<C-r>=line(\"'>\") - line(\"'<\") + 1<CR><CR>`[V`]", {desc = "Move visual selection lines one line down"} )
    vim.keymap.set("n", "<ESC><C-j>", ":m +1<CR>", {desc = "Move line under cursor one line down"} )

-- Navigation
    vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", {noremap = true})

-- Practice simple navigation in normal mode with H-left J-down K-up L-right
    vim.api.nvim_set_keymap("n", "<left>", ":lua print(\"USE 'h' to move lft\")<cr>", { noremap = true })
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

-- Plugin Keymaps
    -- Obsidian Notetaking plugin
    require("plugins.keymaps.obsidian-nvim.keymaps")
    require("plugins.keymaps.nvim-tree.keymaps")

--local function comment()
--    end
