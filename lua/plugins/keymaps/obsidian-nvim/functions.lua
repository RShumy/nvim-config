-- Obsidian Note Taking plugin keyboard shortcuts
    -- navigate to vault
local vault_path = "/home/shumy/shumy_vault"

-- Transforming from variables to functions in order to ensure lazy loading
local function telescope() return require("telescope.builtin") end
local function Path() return require("plenary.path") end
local function actions() return require("telescope.actions") end
local function action_state() return require("telescope.actions.state") end
local function obsidian() return require("obsidian").setup(
   { workspaces = { {
        name = "learning",
        path = vault_path,
      }, } }
) end

local count_retry_input = 0

local function is_empty(string)
    if  string == nil or
        string == ""
        then
        return true
    end
    return nil
end

local function is_invalid_pattern(string)
    local first_space = "^%s"
    local two_spaces = "%s"
    if  string:match(first_space) or
        string:match(two_spaces) or
        string:match("[!$\\/.^&$(*)%[%]%{%}:`|~;'\"><?%%]")
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
            " - Contains Two spaces \n"..
            " - Contains Punctuation characters\n"..
            "Retry Count: " .. count
end

local function empty_input_prompt(count)
    return "Previous input was Empty or Null\n"..
            "Retry Count: " .. count
end

local function retry_input(folder_or_file_name, type)
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
           return retry_input(folder_or_file_name)
        elseif invalid_or_empty(folder_or_file_name) then
            count_retry_input = 0
            print("Opperation Canceled")
            return
        end
    end
    count_retry_input = 0
    return folder_or_file_name
end

local function input_prompt(selection, input, type)
    type = (type==nil or type:match("^%d+$")) and "" or type
    return "To [O]pt for maching ".. type .." from selection: '".. selection .."' press \"o\"\n"
        .. "To [C]reate a new ".. type ..": '".. input .."' press \"c\"\n ->"
end

-- Function to pick a folder and open a file in the vault
local function create_or_open(string_matches, selection, input, type)
    -- Prompt for filename or foldername
    if not string_matches then
        local user_input = vim.fn.input(input_prompt(selection, input, type) )
        if user_input == "O" or user_input == "o" then
            return selection
        end
        if user_input == "C" or user_input == "c" then
            return retry_input(input)
        end
        -- Retry input if not maching any chosen option
        return create_or_open(string_matches, selection, input)
    end
end

local function pick_folder(callback)
    -- Use Telescope to pick a folder in the vault
    telescope().find_files({
        prompt_title = "Select Vault Folder",
        cwd = vault_path,
        find_command = { "find", ".", "-type", "d" }, -- Show directories only
        attach_mappings = function(prompt_bufnr, map)

            actions().select_default:replace(function()
                -- Capture search input string
                local folder_from_input = action_state().get_current_line()

                actions().close(prompt_bufnr) -- Close Telescope picker
                local folder_selection = action_state().get_selected_entry()
                local selected_folder = Path():new(vault_path):absolute()

                if folder_selection then
                    -- Get the selected folder name and remove its extension
                    local folder_name = folder_selection.value
                    selected_folder = Path():new(vault_path):joinpath(folder_name):absolute()

                    print("Pressed Key: " .. folder_from_input) -- Debugging output
                    print("Selected folder Name: " .. folder_name) -- Debugging output

                    local foldernames_match = folder_name == folder_from_input

                    if foldernames_match then
                        callback(selected_folder)
                    else
                        local final_folder = create_or_open(foldernames_match, folder_name, folder_from_input, "folder")
                        final_folder = Path():new(vault_path):joinpath(final_folder):absolute()
                        callback(final_folder)
                    end
                else
                    local new_folder = retry_input(folder_from_input, "folder")
                    callback(Path():new(vault_path):joinpath(new_folder):absolute())
                end

            end)

            return true
        end,
    })
end

local function pick_or_create_file(selected_folder, callback)

    -- Open Telescope to create or select a file in the selected folder
    telescope().find_files({
        prompt_title = "Create or Select File in: " .. selected_folder,
        cwd = selected_folder,
        find_command = { "find", ".", "-type", "f", "-name", "*.md" }, -- Show directories only
        attach_mappings = function(file_bufnr, file_map)

            actions().select_default:replace(function()
                -- Capture search input string
                local file_from_input = action_state().get_current_line()

                actions().close(file_bufnr) -- Close Telescope picker
                local file_selection = action_state().get_selected_entry()

                if file_selection then
                    -- Get the selected file name and remove its extension
                    local file_name_with_ext = file_selection.value
                    local file_name = file_name_with_ext:match("^(.*)%.") or file_name_with_ext

                    print("Pressed Key: " .. file_from_input) -- Debugging output
                    print("File Name with extension" .. file_name_with_ext)
                    print("Selected File Name: " .. file_name) -- Debugging output

                    local filenames_match = file_name == file_from_input

                    if filenames_match then
                        callback(file_name, selected_folder)
                    else
                        local final_file = create_or_open(filenames_match, file_name, file_from_input, "file")
                        callback(final_file, selected_folder)
                    end
                else
                    callback(retry_input(file_from_input, "file"), selected_folder) -- Pass the new file name to the callback
                end
            end)

            return true
        end,
    })
end

local function delete_confirm_input(file_name)
    local input = vim.fn.input("Detele currently open file ".. file_name .." ? \"Yes\"/\"No\":")
    print("\n")
    if input:match("^%s*[Yy][Ee][Ss]%s*$") then
        return true
    elseif input:match("^%s*[Nn[Oo]%s*$") then
        print("Delete ".. file_name .." operation canceled !")
        return false
    else
        return delete_confirm_input(file_name)
    end
end

----------------------------------------
------- EXPORTED FUNCTIONS -------------
----------------------------------------

-- Function to dynamically create a file under an existing or new folder 
-- using Telescope as the chosen picker
local function open_vault_file()

    local current_path = vim.fn.getcwd()
  -- Function to handle folder selection and file opening
    pick_folder(function(selected_folder) -- First Callback
        -- other instuctions if needed, 
        -- for now just calling 
        pick_or_create_file(selected_folder, function (file_name, folder)
            file_name = file_name:gsub("[^%w%s]", ""):gsub("%s+", "_")
            print(file_name, folder)
            obsidian():create_note({ title = file_name, id = file_name, dir = folder })
            vim.cmd("e " .. folder .."/".. file_name .. ".md" )
        end)
    end)
        -- Reset cwd(current working directory) to the initial path before calling telescope.find_files
        vim.cmd("cd " .. current_path)

end

local function delete_note_current_buffer(file)
    if delete_confirm_input(file) then
         vim.cmd("!rm ".. file)
     else
         return
     end
end

return {
    delete_note = delete_note_current_buffer,
    obsidian_open_or_new = open_vault_file,
    vault_path = vault_path
}
