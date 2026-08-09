local M = {}

---@param picker snacks.Picker
---@return ObsidianVault
local function vault(picker)
    return assert(
        picker.opts.obsidian and picker.opts.obsidian.vault,
        "Obsidian vault not attached to picker"
    )
end

---@param picker snacks.Picker
local function refresh(picker)
    picker:find()
end

---@param picker snacks.Picker
---@param item ObsidianVault.Entry?
function M.confirm(picker, item)
    if not item then
        return
    end

    local v = vault(picker)

    if item.kind == "folder" then
        v:enter(item.file)
        refresh(picker)
        return
    end

    if item.kind == "note" then
        picker:close()
        v:open(item.file)
        return
    end
    
    if item.kind == "create" then
      picker:close()

      local path = v:create_note(item.title)

      v:open(path)
      return
    end
end

---@param picker snacks.Picker
function M.parent(picker)
    local v = vault(picker)

    if v.cwd == v.root then
        return
    end

    v:parent()
    refresh(picker)
end

---@param picker snacks.Picker
function M.refresh(picker)
    refresh(picker)
end

---@param picker snacks.Picker
function M.create_note(picker)
    local v = vault(picker)

    local title = vim.fn.input("New note: ")

    if vim.trim(title) == "" then
        return
    end

    print("Trying to create note with title: " .. title)
    title = v:sanitize_title(title)

    if title == "" then
        return
    end

    if v:note_exists(title) then
        vim.notify(
            ("Note '%s' already exists"):format(title),
            vim.log.levels.WARN
        )
        return
    end

    local path = v:create_note(title)

    picker:close()
    v:open(path)
end


---@param picker snacks.Picker
function M.create_folder(picker)
    local v = vault(picker)

    local name = vim.fn.input("New folder: ")

    if vim.trim(name) == "" then
        return
    end

    name = v:sanitize_title(name)

    if name == "" then
        return
    end

    local path = v.cwd .. "/" .. name

    if vim.uv.fs_stat(path) then
        vim.notify(
            ("Folder '%s' already exists"):format(name),
            vim.log.levels.WARN
        )
        return
    end

    v:create_folder(name)

    picker:find()
end

---@param picker snacks.Picker
---@param item ObsidianVault.Entry?
function M.rename(picker, item)
    if not item then
        return
    end

    local v = vault(picker)

    local new_name = vim.fn.input("Rename to: ", item.text)

    if vim.trim(new_name) == "" then
        return
    end

    local sanitized = v:sanitize_title(new_name)

    local new_path

    if item.kind == "folder" then
        new_path = v.cwd .. "/" .. sanitized
    else
        new_path = v:note_path(sanitized)
    end

    v:rename(item.file, new_path)

    refresh(picker)
end

---@param picker snacks.Picker
---@param item ObsidianVault.Entry?
function M.delete(picker, item)
    if not item then
        return
    end

    local answer = vim.fn.confirm(
        ("Delete '%s'?"):format(item.text),
        "&Yes\n&No",
        2
    )

    if answer ~= 1 then
        return
    end

    vault(picker):delete(item.file)

    refresh(picker)
end

function M.registered()
    return {
        parent = M.parent,
        refresh = M.refresh,
        rename = M.rename,
        delete = M.delete,
        create_note = M.create_note,
        create_folder = M.create_folder,
    }
end

return M
