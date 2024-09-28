return ({
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 999,
	config = function()
        require('nightfox').setup({
            
        })
		vim.cmd("colorscheme carbonfox")
	end,

})

