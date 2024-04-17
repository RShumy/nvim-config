-- Command :set-all to see a bare list of all options
-- Command :options to page with all options and their description
--------------------------------------------------------------
-- Setting the local variable to shorten the calling string
-- instead of vim.opt.<optionname> to call like opt.<optionname>
local opt = vim.opt
--------------------------------------------------------------

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4 
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false 

-- Search
opt.incsearch = true 
opt.ignorecase = true 
opt.smartcase = true 
opt.hlsearch = false 

-- Appeareance
opt.relativenumber = true 
opt.termguicolors = true 
opt.colorcolumn = '150' 
opt.signcolumn = "yes"
opt.number = true 
opt.cmdheight = 2
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true  
opt.errorbells = false 
opt.swapfile = false 
opt.backup = false 
opt.undodir = vim.fn.expand("~/.vim.undodir") 
opt.undofile = true  
opt.backspace = "indent,eol,start"
opt.splitright = true  
opt.splitbelow = true  
opt.autochdir = false 
opt.iskeyword:append("-") 
opt.mouse:append('a')
opt.clipboard:append("unnamed") 
opt.clipboard:append("unnamedplus") 
opt.modifiable = true
opt.encoding = 'UTF-8'

-- which key
opt.timeout = true
opt.timeoutlen = 300
