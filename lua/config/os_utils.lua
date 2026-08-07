local os_info = vim.loop.os_uname()

local function is_Windows() return os_info.sysname == "Windows_NT" end
local function is_Linux() return os_info.sysname == "Linux" end

local function join_path(base, ...)
    local sep = is_Windows() and "\\" or "/"
    local parts = { base, ... }
    return table.concat(parts, sep)
end

local function is_command_available(app_command)
    if vim.fn.executable(app_command) == 1 then
        return true
    end
    return false
end


--- @return table vim_command with specifications  
--- for finding only directories
local find_directory = function ()
    if is_command_available('fd') then
        return { "fd", "type", "directory" }
    end
    if is_Windows then
        return { "cmd", "/c", "dir /s /b /ad" }
    end
    if is_Linux then
        return { "find", ".", "-type", "d" }
    end
    return {}
end


--- @return table vim_command with specifications  
--- for finding only files with extension
local find_file_type = function (extension)
    if is_command_available('fd') then
        return { "fd", "--extension", extension }
    end
    if is_Windows then
        return { "cmd", "/c", "dir /s /b *." .. extension }
    end
    if is_Linux then
        return { "find", ".", "-type", "f", "-name", "*." .. extension }
    end
    return {}
end

local function is_empty(string)
    if  string == nil or string == "" or string:match("^%s+$")
        then
        return true
    end
    return nil
end

local function is_invalid_pattern(string)
    local first_space = "^%s"
    local spaces = "%s+"
    if  string:match(first_space) or
        string:match(spaces) or
        string:match("[#@!$\\/.^&$(*)%[%]%{%}:`|~;'\"><?%%]")
        then
        return true
    end
    return nil
end

local function invalid_or_empty(string)
    return is_empty(string) or is_invalid_pattern(string)
end

local function invalid_input_prompt(count)
    return "Invalid input is one of:\n"..
            " - First character <space>\n"..
            " - Contains multiple spaces \n"..
            " - Contains any of the special characters below: \n" ..
            "   []{}()<>$\\,.;:?\"`'|~!@#$%^&* \n"..
            "Retry Count: " .. count
end

local function empty_input_prompt(count)
    return "Previous input was Empty or Null\n"..
            "Retry Count: " .. count
end

local count_retry_input = 0

local function retry_path_input(folder_or_file_name, type)
    if invalid_or_empty(folder_or_file_name) then
        count_retry_input = count_retry_input + 1
        if is_invalid_pattern(folder_or_file_name) then
            print(invalid_input_prompt(count_retry_input))
        end
        if is_empty(folder_or_file_name) then
            print(empty_input_prompt(count_retry_input))
        end

        folder_or_file_name = vim.fn.input("Enter new ".. type .." name: ")

        if count_retry_input <= 3 then
           return retry_path_input(folder_or_file_name)
        elseif invalid_or_empty(folder_or_file_name) then
            count_retry_input = 0
            print("Opperation Canceled")
            return
        end
    end
    count_retry_input = 0
    return folder_or_file_name
end

return {
    is_Windows = is_Windows,
    is_Linux = is_Linux,
    join_path = join_path,
    is_command_available = is_command_available,
    find_directory = find_directory,
    find_file_type = find_file_type,
    retry_input = retry_path_input
}
