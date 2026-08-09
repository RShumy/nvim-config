local picker = require("plugins.snacks_obsidian").setup({
    vault = "~/shumy_vault",
    action_keys = {}
})

vim.keymap.set("n", "<leader>oo", picker, { desc = "Browse Vault" })
