-- Check if the current buffer is an nvim-tree buffer
local function nvimtree_buffcheck()
    local bufname = vim.api.nvim_buf_get_name(0)
    if not string.match(bufname, "NvimTree_") then
        print("This command works only in an nvim-tree buffer")
        return false
    end
    return true
end

local function copy_nvim_tree_path()

    if not nvimtree_buffcheck() then
        return
    end

    -- Get the full path of the file/folder under the cursor
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    if node and node.absolute_path then
        -- Copy the path to the clipboard
        vim.fn.setreg("+", node.absolute_path)
        print("Path copied to clipboard: " .. node.absolute_path)
    else
        print("No file or folder under cursor")
    end
end

return {
    copy_nvim_tree_path = copy_nvim_tree_path
}
