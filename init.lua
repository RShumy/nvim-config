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
		lazy = true,
	},
	install = {
		colorscheme = { "nightfox" } 
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
