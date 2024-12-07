-- Obsidian Note Taking plugin keyboard shortcuts
    -- navigate to vault
local vault_path = "/home/shumy/shumy_vault"
-- Function to pick a folder and open a file in the vault
local function open_vault_file()
    local current_path = vim.fn.getcwd()
    local Path = require("plenary.path")
    local telescope = require("telescope.builtin")

  -- Function to handle folder selection and file opening
    local function pick_folder_and_open()
        telescope.find_files({
            prompt_title = "Select Vault Folder",
            cwd = vault_path,
            find_command = { "find", ".", "-type", "d" }, -- Show directories only
            attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                -- Define action for selection
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr) -- Close Telescope
                    local selection = action_state.get_selected_entry() -- Get the folder

                    if not selection then
                        print("No folder selected")
                        return
                    end

                    -- Concatenate with vault_path
                    local selected_folder = Path:new(vault_path):joinpath(selection.value):absolute()

                    -- Prompt for filename
                    local user_input = vim.fn.input("Enter filename: ")
                    if user_input == "" then
                        print("Operation canceled")
                        return
                    end

                    -- Full path to the file
                    local file_path = string.format("%s/%s", selected_folder, user_input .. ".md")

                    -- Open the file
                    vim.cmd(string.format(":e %s", file_path))
                end)
                return true
            end,
        })

        -- Reset cwd(current working directory) to the initial path before calling telescope.find_files
        vim.cmd("cd " .. current_path)

    end

    pick_folder_and_open()
end

return {
    obsidian_open_or_new = open_vault_file,
    vault_path = vault_path
}
