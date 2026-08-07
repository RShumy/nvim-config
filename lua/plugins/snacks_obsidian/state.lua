---@class ObsidianPicker.State
---@field vault ObsidianVault

local M = {}
M.__index = M

---@param opts? { vault?: string }
---@return ObsidianPicker.State
function M.new(opts)
    opts = opts or {}

    return setmetatable({
        vault = require("plugins.snacks_obsidian.vault").new(opts.vault),
    }, M)
end

---@return ObsidianVault.Entry[]
function M:list()
    return self.vault:list()
end

function M:reset()
    self.vault:reset()
end

return M
