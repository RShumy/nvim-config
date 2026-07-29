require("vim._core.ui2").enable({
    enable = true,
    msg = {
        target = "cmd",
        pager = {height = 0.5},
        dialog = {height = 0.5},
        cmd = {height = 0.5},
        msg = {height = 0.5, timeout = 4500},
    },
})
require("config")
require("keymaps")
require("plugins")
require("keymaps.plugins")

_G.theme("dracula")

-- Make nvim transparent
    -- hi Normal guibg=none ctermbg=none
    -- hi NormalNC guibg=none ctermbg=none
-- Making the Cursor Line Transparent
    -- hi CursorLine ctermbg=none guibg=#323b2d gui=NONE cterm=NONE
-- Making the Floating Windows backgound transparent
    -- hi NormalFloat ctermbg=none guibg=none 
    -- hi FloatBorder ctermbg=none guibg=none
vim.cmd [[
    hi NonText guibg=none ctermbg=none
    hi NvimTreeNonText guibg=none ctermbg=none
    hi NvimTreeNormal guibg=none ctermbg=none
    hi CursorLine ctermbg=none guibg=#323b2d gui=NONE cterm=NONE
    hi NormalFloat ctermbg=none guibg=none 
    hi FloatBorder ctermbg=none guibg=none
]]
