local jdtls = require("plugins.lsp.java-config.jdtls")
local augroup = vim.api.nvim_create_augroup("UserLsp", { clear = true, })


-- vim.api.nvim_create_autocmd("UserLsp", {
--     clear = true,
-- })

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "java",
    callback = jdtls,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    pattern = "*.java",
    callback = function()
        pcall(vim.lsp.codelens.refresh)
    end,
})
