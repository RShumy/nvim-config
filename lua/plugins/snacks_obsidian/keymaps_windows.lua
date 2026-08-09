local M = {}

function M.text(action_keys, category)
    local result = {}

    for _, entry in ipairs(action_keys) do
        if entry.enabled ~= false
            and entry.desc_category == category
        then
            table.insert(
                result,
                ("%s  %s"):format(entry.key, entry.desc)
            )
        end
    end

    return { text = result, }
end

return M
