local M = {}

---@class ObsidianActionKey
---@field key string
---@field action string
---@field desc_category string
---@field desc string
---@field enabled? boolean

---@type ObsidianActionKey[]
M.defaults = {
    {
        key = "<BS>",
        action = "parent",
        desc_category = "navigation",
        desc = "Parent directory",
    },

    {
        key = "<C-r>",
        action = "refresh",
        desc_category = "modify",
        desc = "Refresh",
    },

    {
        key = "<F2>",
        action = "rename",
        desc_category = "modify",
        desc = "Rename",
    },

    {
        key = "<C-d>",
        action = "delete",
        desc_category = "modify",
        desc = "Delete",
    },

    {
        key = "<C-n>",
        action = "create_note",
        desc_category = "create",
        desc = "Create note",
    },

    {
        key = "<C-f>",
        action = "create_folder",
        desc_category = "create",
        desc = "Create folder",
    },
}

---@param defaults ObsidianActionKey[]
---@param overrides ObsidianActionKey[]?
---@return ObsidianActionKey[]
local function merge(defaults, overrides)
    validate_entries(defaults, "default")

    local result = {}
    local indexes = {}

    for _, entry in ipairs(defaults) do
        local copy = vim.deepcopy(entry)

        table.insert(result, copy)
        indexes[copy.action] = #result
    end

    if not overrides then
        return result
    end

    for index, entry in ipairs(overrides) do
        -- An incomplete user definition is not a mapping.
        --
        -- In particular, don't allow a missing key to accidentally
        -- overwrite the default mapping for an action.
        if entry.action ~= nil and entry.key ~= nil then
            local result_index = indexes[entry.action]

            if result_index then
                result[result_index] = vim.tbl_deep_extend(
                    "force",
                    result[result_index],
                    entry
                )
            else
                table.insert(result, vim.deepcopy(entry))
                indexes[entry.action] = #result
            end
        end
    end

    validate_entries(result, "resolved")

    return result
end

---Resolve the default action keys against user configuration.
---
---Entries are merged by `key`, rather than by array position.
---
---@param overrides ObsidianActionKey[]?
---@return ObsidianActionKey[]
function M.resolve(overrides)
    return merge(M.defaults, overrides)
end

---Return only enabled action-key definitions.
---@param action_keys ObsidianActionKey[]
---@return ObsidianActionKey[]
function M.enabled(action_keys)
    local result = {}

    for _, entry in ipairs(action_keys) do
        if entry.enabled ~= false then
            table.insert(result, entry)
        end
    end

    return result
end

---Convert action-key definitions to Snacks' input key configuration.
---
---@param action_keys ObsidianActionKey[]
---@return table<string, table>
function M.to_snacks(action_keys)
    local result = {}

    for _, entry in ipairs(M.enabled(action_keys)) do
        result[entry.key] = {
            entry.action,
        }
    end

    return result
end

---Return action-key definitions belonging to a display category.
---@param action_keys ObsidianActionKey[]
---@param category string
---@return ObsidianActionKey[]
function M.category(action_keys, category)
    local result = {}

    for _, entry in ipairs(M.enabled(action_keys)) do
        if entry.desc_category == category then
            table.insert(result, entry)
        end
    end

    return result
end

local function validate_entries(entries, source)
    local actions = {}
    local keys = {}

    for index, entry in ipairs(entries) do
        if entry.action == nil or entry.key == nil then
            error((
                "obsidian action key #%d in %s must define both 'action' and 'key'"
            ):format(index, source))
        end

        if actions[entry.action] then
            error((
                "duplicate action '%s' in %s action keys"
            ):format(entry.action, source))
        end

        if keys[entry.key] then
            error((
                "duplicate key '%s' in %s action keys"
            ):format(entry.key, source))
        end

        actions[entry.action] = true
        keys[entry.key] = true
    end
end

return M
