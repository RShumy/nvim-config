return {
    {
        "williamboman/mason.nvim",
        config = function()
            -- setup mason with default setup
            require('mason').setup()
        end
    },
    -- mason lsp config utilizes mason to automatically ensure instalation of lsp servers you want
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "ts_ls", "jdtls"}
            })
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            -- ensure that required debug adapters are installed
            require("mason-nvim-dap").setup({
                ensure_installed = {"java-debug-adapter","java-test"}
            })
        end
    },
    -- utility plugin for configuring the java language server
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            --get access to the lspconfig plugin function
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- lua language server setup
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            -- type script language server setup
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            -- Set vim motion for <Space> + c + r to display references to the code under the cursor
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
            -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end
    },
}
