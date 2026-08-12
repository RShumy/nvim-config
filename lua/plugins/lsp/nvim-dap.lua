require("mason-nvim-dap").setup({
    ensure_installed = {"java-debug-adapter","java-test"}
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
-- Open DAP UI whenever a debug session is launched. 
dap.listeners.before.launch.dapui_config = function() dapui.open() end

-- Toggle breakpoint. 
vim.keymap.set( "n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" } )
-- Start/continue debugging. 
vim.keymap.set( "n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" } )
-- Close DAP UI.
vim.keymap.set( "n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" } )
