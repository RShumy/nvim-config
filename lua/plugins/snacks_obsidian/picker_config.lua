-- lua/snacks/picker/source/obsidian.lua

local Vault = require("plugins.snacks_obsidian.vault")
local actions = require("plugins.snacks_obsidian.actions")
local format = require("plugins.snacks_obsidian.format")
local layout = require("plugins.snacks_obsidian.layout")
-- local preview = require("plugins.snacks_obsidian.preview")

local M = {}

---@param opts snacks.picker.Config?
function M.new(vault_opts)
    vault_opts = vault_opts or {}

    local vault = Vault.new(vault_opts.vault)

    ---@type snacks.picker.Source
    return {
        title = "Obsidian",

        obsidian = {
            vault = vault,
        },

        finder = function(_, ctx)

            local items = vault:list()

            local query = vim.trim(ctx.filter.search or "")
            print(vault:can_create(query))
            if vault:can_create(query) then
                table.insert(items, 1, {
                    kind = "create",
                    text = query,
                    title = query,
                })
            end

            return items
        end,

        layout = layout(),

        format = format.format,

        confirm = actions.confirm,

        actions = {
            parent = actions.parent,
            refresh = actions.refresh,
            rename = actions.rename,
            delete = actions.delete,
            create = actions.create_note,
            create_folder = actions.create_folder,
        },


        win = {
            input = {
                keys = {
                    ["<BS>"] = { "parent" },
                    ["<C-r>"] = { "refresh" },
                    ["<F2>"] = { "rename" },
                    ["<C-d>"] = { "delete" },
                    ["<C-n>"] = { "create" },
                    ["<C-f>"] = { "create_folder" },
                },
            },
        },
    }

end

return M
