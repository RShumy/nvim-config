local os_info = vim.loop.os_uname()

local function is_Windows() return os_info.sysname == "Windows_NT" end
local function is_Linux() return os_info.sysname == "Linux" end

local function join_path(base, ...)
    local sep = is_Windows() and "\\" or "/"
    local parts = { base, ... }
    return table.concat(parts, sep)
end

return {
    is_Windows = is_Windows,
    is_Linux = is_Linux,
    join_path = join_path
}
