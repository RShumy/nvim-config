local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- global variables leader mapped in globals.lua
require('config.globals')
require('config.options')

-- options variable to be passed in lazy setup
local opts = {
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
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
               -- "tutor",
                "zipPlugin",
		}
	},
	change_detection = {
		notify = true,
	},
}


require("lazy").setup('plugins', opts)
