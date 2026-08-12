require("mason-nvim-dap").setup()

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

vim.keymap.set( "n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })

vim.keymap.set( "n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })

vim.keymap.set( "n", "<leader>do", dap.step_over, { desc = "[D]ebug Step [O]ver" })

vim.keymap.set( "n", "<leader>di", dap.step_into, { desc = "[D]ebug Step [I]nto" })

vim.keymap.set( "n", "<leader>dO", dap.step_out, { desc = "[D]ebug Step [O]ut" })

vim.keymap.set( "n", "<leader>dr", dap.repl.open, { desc = "[D]ebug [R]EPL" })

vim.keymap.set( "n", "<leader>du", dapui.toggle, { desc = "[D]ebug [U]I" })
