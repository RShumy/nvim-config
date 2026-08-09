local snacks = require("snacks")
local key_helper_windows = require("plugins.snacks_obsidian.keymaps_windows")

local function create_key_window(opts)
    return snacks.win(vim.tbl_deep_extend("force", {
        show = false,
        enter = false,
        focusable = false,
        border = "rounded",
        minimal = true,

        bo = {
            buftype = "nofile",
            bufhidden = "wipe",
            swapfile = false,
            modifiable = false,
        },

        wo = {
            cursorline = false,
            cursorcolumn = false,
            wrap = false,
        },
    }, opts))
end

return function(action_keys) 
    return 
    {
    wins = {
        -- input = input,
        -- list = list,
        -- preview = preview,

        create_keys = create_key_window(key_helper_windows.text(action_keys, "create")),
        modify_keys = create_key_window(key_helper_windows.text(action_keys, "modify")),
    },

    layout = { 
        box = "vertical",
        backdrop = false,
        width = 0.90,
        height = 0.90,

        {
            box = "horizontal",
            height = 0,

            {
                box = "vertical",
                width = 0.50,

                {
                    win = "list",
                    title = " Results ",
                    title_pos = "center",
                    border = "rounded",
                },

                {
                    win = "input",
                    height = 1,
                    border = "rounded",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                },
            },

            {
                win = "preview",
                width = 0.50,
                title = "{preview:Preview}",
                title_pos = "center",
                border = "rounded",
            },
      
        },
        {
            box = "horizontal",
            height = 4,
            border = "rounded",

            {
                win = "create_keys",
                width = 0.50,
                title = " Create ",
                title_pos = "center",
                border = "right",
            },

            {
                win = "modify_keys",
                width = 0.50,
                title = " Modify ",
                title_pos = "center",
                border = "none",
            },
        },
    }
}
end
