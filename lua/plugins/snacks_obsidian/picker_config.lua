-- lua/snacks/picker/source/obsidian.lua

local Vault = require("plugins.snacks_obsidian.vault")
local actions = require("plugins.snacks_obsidian.actions")
local format = require("plugins.snacks_obsidian.format")
local layout = require("plugins.snacks_obsidian.layout")
local keymaps = require("plugins.snacks_obsidian.keymaps")

local M = {}

---@param vault_opts snacks.picker.Config?
function M.new(vault_opts)
    vim.inspect(vault_opts)
    vault_opts = vault_opts or {}

    local vault = Vault.new(vault_opts.vault)

    local resolved_keys = keymaps.resolve(vault_opts.action_keys)

    local registered_actions = actions.registered()

    ---@type snacks.picker.Source
    return {
        title = "Obsidian",

        obsidian = {
            vault = vault,
        },

        finder = function(_, ctx)

            local items = vault:list()

            local query = vim.trim(ctx.filter.search or "")

            if vault:can_create(query) then
                table.insert(items, 1, {
                    kind = "create",
                    text = query,
                    title = query,
                })
            end

            return items
        end,

        layout = layout(resolved_keys),

        format = format.format,

        confirm = actions.confirm,

        actions = registered_actions,


        win = {
            input = {
                keys = keymaps.to_snacks(resolved_keys)
            },
        },
    }

end

return M
