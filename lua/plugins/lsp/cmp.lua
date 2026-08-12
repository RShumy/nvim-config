local function ensure_luasnip_build()
  local luasnip_path = vim.api.nvim_get_runtime_file("lua/luasnip/init.lua", false)[1]
  if not luasnip_path then return end

  local root = vim.fn.fnamemodify(luasnip_path, ":h:h:h")
  local lib = root .. "/deps/jsregexp/jsregexp.so"
  if vim.fn.has("win32") == 1 then lib = root .. "/deps/jsregexp/jsregexp.dll" end

  if not vim.uv.fs_stat(lib) then
    vim.notify("Building LuaSnip jsregexp...", vim.log.levels.INFO)
    vim.system({ "make", "install_jsregexp" }, { cwd = root }, function(out)
      if out.code ~= 0 then
        vim.notify("LuaSnip build failed", vim.log.levels.ERROR)
      else
        vim.notify("LuaSnip build complete", vim.log.levels.INFO)
      end
    end)
  end
end

ensure_luasnip_build()

-- 3. Configure LuaSnip
require("luasnip").setup({
  enable_autosnippets = true,
})

-- Load friendly-snippets (VSCode format)
require("luasnip.loaders.from_vscode").lazy_load()

-- EXTEND FILETYPES FOR JAVA, LUA, C#
-- Critical for documentation snippets (javadoc, luadoc, csharpdoc)
require("luasnip").filetype_extend("java", { "javadoc" })
require("luasnip").filetype_extend("lua", { "luadoc" })
require("luasnip").filetype_extend("cs", { "csharpdoc" }) -- 'cs' is Neovim's filetype for C#

-- 4. Configure blink.cmp
require("blink.cmp").setup({
  snippets = {
    preset = "luasnip", -- Use LuaSnip engine instead of native vim.snippet
  },
  keymap = {
    preset = "enter", -- Handles <CR> confirmation logic
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  sources = {
    default = { "lsp", "snippets", "buffer", "path" },
  },
  completion = {
    documentation = {
      auto_show = false, -- Manual trigger only (matches your original setup)
    },
  },
})
