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

    local api = require("nvim-tree.api")
    -- Get the full path of the file/folder under the cursor
    local node = api.tree.get_node_under_cursor()

    if node and node.absolute_path then
        -- Copy the path to the clipboard
        vim.fn.setreg("+", node.absolute_path)
        print("Path copied to clipboard: " .. node.absolute_path)
    else
        print("No file or folder under cursor")
    end
end

local function is_directory_node(local_node)

  if not local_node then
    return false
  end

  -- check if it's a regular directory
  if local_node.type == "directory" then
    return true
  end

  -- check if it's a symlink to a directory
  if local_node.type == "link" and node.link_to then
    local stat = uv.fs_stat(local_node.link_to)
    return stat and stat.type == "directory"
  end

  return false

end


local function cd_into_dir()

    if not nvimtree_buffcheck() then
        return
    end

    local api = require("nvim-tree.api")
    -- Get the full path of the file/folder under the cursor
    local node = api.tree.get_node_under_cursor()

    if is_directory_node(node) then
       local dir_path = node.absolute_path

       if node.link_to then
           dir_path = node.link_to
       end
    vim.cmd("cd " .. vim.fn.fnameescape(dir_path))
    end
end


return {
    copy_nvim_tree_path = copy_nvim_tree_path,
    cd_into_dir = cd_into_dir
}
