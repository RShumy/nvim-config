local M = {}

local Snacks = require("snacks")
local Source = require("plugins.snacks_obsidian.picker_config")

---@param opts? table
function M.setup(opts)
    opts = opts or {}

    Snacks.picker.obsidian = function(picker_opts)
        picker_opts = vim.tbl_deep_extend(
            "force",
            opts,
            picker_opts or {}
        )

        return Snacks.picker.pick(Source.new(picker_opts))
    end

    return Snacks.picker.obsidian
end

return M
