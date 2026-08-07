local obisdian_create_keys = {
    enter = false,
    focusable = false,
    bo = {
        buftype = "nofile",
        bufhidden = "wipe",
        swapfile = false,
    },
    text = "<C-n> to create note"
}

local obisdian_modify_keys = {
    enter = false,
    focusable = false,
    bo = {
        buftype = "nofile",
        bufhidden = "wipe",
        swapfile = false,
    },
    text = "Press <C-r> to rename\nPress <C-d> to delete",
}


return {
    window_create_keys = obisdian_create_keys,
    window_modify_keys = obisdian_modify_keys,
    -- create_key_window = create_key_window,
}
