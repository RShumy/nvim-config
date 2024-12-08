-- Obsidian Note Taking plugin keyboard shortcuts
    -- navigate to vault
local vault_path = "/home/shumy/shumy_vault"
-- Transforming from variables to functions in order to ensure lazy loading
-- otherwise entire Configuration will fail because telescope plugin is not loaded yet
local function telescope() return require("telescope.builtin") end
local function Path() return require("plenary.path") end
local function actions() return require("telescope.actions") end
local function action_state() return require("telescope.actions.state") end

-- Function to pick a folder and open a file in the vault
local function create_or_open(filename_matches, file_from_selection, file_from_input)
    -- Prompt for filename
    if not filename_matches then
        local user_input = vim.fn.input("To [O]pen maching Note from selection: '".. file_from_selection .."' press \"o\"\n"
        .. "To [C]reate a new Note: '".. file_from_input .."' press \"c\"\n ->" )
        if user_input == "O" or user_input == "o" then
            return file_from_selection
        end
        if user_input == "C" or user_input == "c" then
            return file_from_input
        end
        -- Retry file_from_input if not maching any chosen option
        return create_or_open(filename_matches, file_from_selection, file_from_input)
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
                actions().close(prompt_bufnr) -- Close Telescope picker
                local selection = action_state().get_selected_entry()
                local selected_folder = Path():new(vault_path):absolute()

                if selection then
                    selected_folder = Path():new(vault_path):joinpath(selection.value):absolute()
                else
                    print("No folder selected, creating file in main vault path ...")
                end
                -- Return the absolute path of the selected folder
                callback(selected_folder)

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
                    print("Filr Name with extension" .. file_name_with_ext)
                    print("Selected File Name: " .. file_name) -- Debugging output

                    local filenames_match = file_name == file_from_input

                    if filenames_match then
                        file_name = Path():new(selected_folder):joinpath(file_name..".md"):absolute()
                        callback(file_name)
                    else
                        local final_file = create_or_open(filenames_match, file_name, file_from_input)
                        callback(Path():new(selected_folder):joinpath(final_file..".md"):absolute())
                    end
                else
                    -- No selection, prompt for user input
                    file_from_input = vim.fn.input("Enter new file name: ")
                    if file_from_input == "" then
                        print("Operation canceled")
                        return
                    end

                    local new_file_path = Path():new(selected_folder):joinpath(file_from_input..".md"):absolute()
                    callback(new_file_path) -- Pass the new file name to the callback
                end
            end)

            return true
        end,
    })
end

local function open_vault_file()

    local current_path = vim.fn.getcwd()
  -- Function to handle folder selection and file opening
    pick_folder(function(selected_folder)
        pick_or_create_file(selected_folder, function (file_path)
            vim.cmd("e " .. file_path)
        end)
    end)
        -- Reset cwd(current working directory) to the initial path before calling telescope.find_files
        vim.cmd("cd " .. current_path)

end


return {
    obsidian_open_or_new = open_vault_file,
    vault_path = vault_path
}
