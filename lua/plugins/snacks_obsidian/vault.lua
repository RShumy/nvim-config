---@class ObsidianVault.Entry
---@field kind "folder"|"note"
---@field text string
---@field file string
---@field title string

---@class ObsidianVault
---@field root string
---@field cwd string
local Vault = {}
Vault.__index = Vault

---@param root string
---@return ObsidianVault
function Vault.new(root)
    root = vim.fs.normalize(vim.fn.expand(root))

    return setmetatable({
        root = root,
        cwd = root,
    }, Vault)
end

function Vault:reset()
    self.cwd = self.root
end

---@param path string
function Vault:enter(path)
    self.cwd = vim.fs.normalize(path)
end

function Vault:parent()
    if self.cwd ~= self.root then
        self.cwd = vim.fs.dirname(self.cwd)
    end
end

---@return string
function Vault:cwd_name()
    return vim.fs.basename(self.cwd)
end

---@return string
function Vault:relative_cwd()
    if self.cwd == self.root then
        return "."
    end

    return self.cwd:sub(#self.root + 2)
end

---@param title string
---@return string
function Vault:sanitize_title(title)
    title = vim.trim(title)

    return title
        :gsub("[^%w%s%-_]", "")
        :gsub("%s+", "_")
end

---@param title string
---@return string
function Vault:note_path(title)
    return self.cwd .. "/" .. self:sanitize_title(title) .. ".md"
end

---@param title string
---@return boolean
function Vault:note_exists(title)
    return vim.uv.fs_stat(self:note_path(title)) ~= nil
end

---@param title string
---@return boolean
function Vault:can_create(title)
    title = self:sanitize_title(title)

    if title == "" then
        return false
    end

    return not self:note_exists(title)
end

---@return ObsidianVault.Entry[]
function Vault:list_folders()
    local folders = {}

    for name, t in vim.fs.dir(self.cwd) do
        if t == "directory" then
            table.insert(folders, {
                kind = "folder",
                text = name,
                file = self.cwd .. "/" .. name,
            })
        end
    end

    table.sort(folders, function(a, b)
        return a.text:lower() < b.text:lower()
    end)

    return folders
end

---@return ObsidianVault.Entry[]
function Vault:list_notes()
    local notes = {}

    for name, t in vim.fs.dir(self.cwd) do
        if t == "file" and name:sub(-3) == ".md" then
            table.insert(notes, {
                kind = "note",
                text = name,
                file = self.cwd .. "/" .. name,
            })
        end
    end

    table.sort(notes, function(a, b)
        return a.text:lower() < b.text:lower()
    end)

    return notes
end

---@return ObsidianVault.Entry[]
function Vault:list()
    local entries = {}

    vim.list_extend(entries, self:list_folders())
    vim.list_extend(entries, self:list_notes())

    return entries
end

---@param title string
---@return string
function Vault:create_note(title)
    title = self:sanitize_title(title)

    local obsidian = require("obsidian")
    local note = obsidian.Note.create ({
        id = title,
        title = title,
        dir = self.cwd,
    })

    note:write()

    return self:note_path(title)
end

---@param name string
---@return string
function Vault:create_folder(name)
    name = self:sanitize_title(name)

    local path = self.cwd .. "/" .. name

    vim.fn.mkdir(path, "p")

    return path
end

---@param path string
function Vault:delete(path)
    vim.fn.delete(path, "rf")
end

---@param old_path string
---@param new_path string
function Vault:rename(old_path, new_path)
    assert(vim.uv.fs_rename(old_path, new_path))
end

---@param path string
function Vault:open(path)
    vim.cmd.edit(vim.fn.fnameescape(path))
end

return Vault
