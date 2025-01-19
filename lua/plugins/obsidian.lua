local os_info = require("config.os_utils")

local is_Windows = os_info.is_Windows()
local is_Linux = os_info.is_Linux()

-- Setting the base drive and directory path
local windows_vault = "D:\\shumy_vault"
local linux_vault = "~/shumy_vault"

-- Obsidian Note Taking plugin keyboard shortcuts
    -- navigate to vault
    -- TODO: Can make vault_path a switch function, depending on the OS
local vault_path = function()
    local base_dir
    if is_Windows then
        base_dir = windows_vault
    end
    if is_Linux then
        base_dir = linux_vault
    end
    return vim.fn.expand(base_dir)
end

vim.opt.conceallevel = 1

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  opts = {
    workspaces = {
      {
        name = "learning",
        path = vault_path(),
      },
    },
    ui = { enable = false }
  },
}
