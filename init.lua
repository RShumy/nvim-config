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

_G.theme("dracula")

vim.cmd("hi NonText guibg=none ctermbg=none")
vim.cmd("hi NvimTreeNonText guibg=none ctermbg=none")
vim.cmd("hi NvimTreeNormal guibg=none ctermbg=none")

-- Making the Cursor Line Transparent
vim.cmd("hi CursorLine ctermbg=none guibg=#323b2d gui=NONE cterm=NONE")
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
  end,
})
