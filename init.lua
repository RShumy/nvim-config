local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Global variables leader mapped in globals.lua
-- We import configurations from other files by requireing
require('config')
-- options variable to be passed in lazy setup
local lazyopts = {
    defaults = {
 		lazy = false,
 	},
	install = {
		colorscheme = { "dracula" }
	},
	rtp = {
		disabled_puglins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrw",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "nightfox-color-config",
		}
	},
	change_detection = {
		notify = true,
	},
    checker = {
        enabled = true,
        notify = false
    }
}

require("lazy").setup('plugins', lazyopts)
-- Make nvim transparent
--  hi Normal guibg=none ctermbg=none
--  hi NormalNC guibg=none ctermbg=none
vim.cmd [[
    
    hi NonText guibg=none ctermbg=none
    hi NvimTreeNonText guibg=none ctermbg=none
    hi NvimTreeNormal guibg=none ctermbg=none

]]

--Making the Cursor Line Transparent
vim.cmd [[ 
    hi CursorLine ctermbg=none guibg=#323b2d gui=NONE cterm=NONE
]]
