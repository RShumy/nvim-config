local M = {}

local icons = {
    folder = "󰉋",
    note = "󰈙",
    create = "",
}

local hl = {
    folder = "SnacksPickerDirectory",
    note = "SnacksPickerFile",
    create = "SnacksPickerSpecial",
}


---@param item ObsidianVault.Entry
---@return snacks.picker.Highlight[]
function M.format(item)
    if item.kind == "create" then
        return {
            { " ", "SnacksPickerSpecial" },
            { "Create ", "Comment" },
            { item.text, "String" },
        }
    end

    return {
        {
            icons[item.kind] .. " ",
            hl[item.kind],
        },
        {
            item.text,
            hl[item.kind],
        },
    }
end

return M
