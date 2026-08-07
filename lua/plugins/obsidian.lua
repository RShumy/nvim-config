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

require("obsidian").setup({
  legacy_commands = false, -- this will be removed in 4.0.0
  workspaces = {
    {
      name = "personal",
      path = vault_path(),
    },
  },
}
)
