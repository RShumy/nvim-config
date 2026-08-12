local function get_jdtls(mason_registry)
    local jdtls = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls:get_install_path()

    local launcher = vim.fn.glob(
        jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
    )

    local system = "linux"

    if vim.fn.has("win32") == 1 then
        system = "win"
    elseif vim.fn.has("mac") == 1 then
        system = "mac"
    end

    local os_config = jdtls_path .. "/config_" .. system
    local lombok = jdtls_path .. "/lombok.jar"

    return launcher, os_config, lombok
end

local function get_bundles(mason_registry)
    local bundles = {}

    -- Java Debug Adapter
    local java_debug =
        mason_registry.get_package("java-debug-adapter")

    local java_debug_path =
        java_debug:get_install_path()

    local debug_bundle = vim.fn.glob(
        java_debug_path
            .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        1
    )

    if debug_bundle ~= "" then
        table.insert(bundles, debug_bundle)
    end

    -- Java Test
    local java_test =
        mason_registry.get_package("java-test")

    local java_test_path =
        java_test:get_install_path()

    local test_bundles = vim.split(
        vim.fn.glob(
            java_test_path .. "/extension/server/*.jar",
            1
        ),
        "\n",
        {
            trimempty = true,
        }
    )

    vim.list_extend(bundles, test_bundles)

    return bundles
end

local function get_workspace(root_dir)
    local workspace_path = vim.fn.stdpath("data") .. "/jdtls-workspaces"

    -- Use the project root rather than cwd. This is important when opening
    -- a Java file from a submodule of a multi-module Maven project.
    local project_name = vim.fn.fnamemodify(root_dir, ":t")

    return workspace_path .. "/" .. project_name
end

local function java_keymaps()
    vim.cmd(
        "command! -buffer -nargs=? "
            .. "-complete=custom,v:lua.require'jdtls'._complete_compile "
            .. "JdtCompile lua require('jdtls').compile(<f-args>)"
    )

    vim.cmd(
        "command! -buffer JdtUpdateConfig "
            .. "lua require('jdtls').update_project_config()"
    )

    vim.cmd(
        "command! -buffer JdtBytecode "
            .. "lua require('jdtls').javap()"
    )

    vim.cmd(
        "command! -buffer JdtJshell "
            .. "lua require('jdtls').jshell()"
    )

    vim.keymap.set(
        "n",
        "<leader>Jo",
        "<Cmd>lua require('jdtls').organize_imports()<CR>",
        {
            buffer = true,
            desc = "[J]ava [O]rganize Imports",
        }
    )

    vim.keymap.set(
        "n",
        "<leader>Jv",
        "<Cmd>lua require('jdtls').extract_variable()<CR>",
        {
            buffer = true,
            desc = "[J]ava Extract [V]ariable",
        }
    )

    vim.keymap.set(
        "v",
        "<leader>Jv",
        "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
        {
            buffer = true,
            desc = "[J]ava Extract [V]ariable",
        }
    )

    vim.keymap.set(
        "n",
        "<leader>JC",
        "<Cmd>lua require('jdtls').extract_constant()<CR>",
        {
            buffer = true,
            desc = "[J]ava Extract [C]onstant",
        }
    )

    vim.keymap.set(
        "v",
        "<leader>JC",
        "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
        {
            buffer = true,
            desc = "[J]ava Extract [C]onstant",
        }
    )

    vim.keymap.set(
        "n",
        "<leader>Jt",
        "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
        {
            buffer = true,
            desc = "[J]ava [T]est Method",
        }
    )

    vim.keymap.set(
        "v",
        "<leader>Jt",
        "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>",
        {
            buffer = true,
            desc = "[J]ava [T]est Method",
        }
    )

    vim.keymap.set(
        "n",
        "<leader>JT",
        "<Cmd>lua require('jdtls').test_class()<CR>",
        {
            buffer = true,
            desc = "[J]ava [T]est Class",
        }
    )

    vim.keymap.set(
        "n",
        "<leader>Ju",
        "<Cmd>JdtUpdateConfig<CR>",
        {
            buffer = true,
            desc = "[J]ava [U]pdate Config",
        }
    )
end

local function setup_jdtls()
    -- Deliberately load these only when a Java buffer is opened.
    local mason_registry = require("mason-registry")
    local jdtls = require("jdtls")

    local launcher, os_config, lombok =
        get_jdtls(mason_registry)

    local bundles = get_bundles(mason_registry)

    -- Do not use pom.xml here.
    --
    -- A multi-module project can contain many pom.xml files. Using pom.xml
    -- as a root marker can cause a module to become the JDTLS workspace root
    -- instead of the Maven reactor root.
    local root_dir = jdtls.setup.find_root({
        "mvnw",
        "gradlew",
        ".git",
    })

    if not root_dir then
        vim.notify(
            "JDTLS: unable to determine project root",
            vim.log.levels.WARN
        )
        return
    end

    local workspace_dir = get_workspace(root_dir)

    local capabilities = {
        workspace = {
            configuration = true,
        },

        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    }

    local extended_client_capabilities =
        vim.deepcopy(jdtls.extendedClientCapabilities)

    extended_client_capabilities.resolveAdditionalTextEditsSupport = true

    local cmd = {
        "java",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",

        "-Dlog.protocol=true",
        "-Dlog.level=ALL",

        "-Xmx1g",

        "--add-modules=ALL-SYSTEM",

        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",

        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-javaagent:" .. lombok,

        "-jar",
        launcher,

        "-configuration",
        os_config,

        "-data",
        workspace_dir,
    }

    local settings = {
        java = {
            import = {
                maven = {
                    enabled = true,
                },

                gradle = {
                    enabled = true,
                },

                exclusions = {
                    "**/node_modules/**",
                    "**/.metadata/**",
                    "**/archetype-resources/**",
                    "**/META-INF/maven/**",
                },
            },

            configuration = {
                updateBuildConfiguration = "automatic",
            },

            format = {
                enabled = true,

                settings = {
                    url = vim.fn.stdpath("config")
                        .. "/lang_servers/intellij-java-google-style.xml",

                    profile = "GoogleStyle",
                },
            },

            eclipse = {
                downloadSources = true,
            },

            maven = {
                downloadSources = true,
                updateSnapshots = true,
            },

            signatureHelp = {
                enabled = true,
            },

            contentProvider = {
                preferred = "fernflower",
            },

            saveActions = {
                organizeImports = true,
            },

            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },

                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },

                importOrder = {
                    "java",
                    "jakarta",
                    "javax",
                    "com",
                    "org",
                },
            },

            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticThreshold = 9999,
                },
            },

            codeGeneration = {
                toString = {
                    template =
                        "${object.className}{${member.name()}=${member.value()}, ${otherMembers}}",
                },

                hashCodeEquals = {
                    useJava7Objects = true,
                },

                useBlocks = true,
            },

            referencesCodeLens = {
                enabled = true,
            },

            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
        },
    }

    local init_options = {
        bundles = bundles,

        extendedClientCapabilities =
            extended_client_capabilities,
    }

    local on_attach = function()
        java_keymaps()

        require("jdtls.dap").setup_dap()
        require("jdtls.dap").setup_dap_main_class_configs()

        require("jdtls.setup").add_commands()

        vim.lsp.codelens.refresh()
    end

    local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        capabilities = capabilities,
        init_options = init_options,
        on_attach = on_attach,
    }

    jdtls.start_or_attach(config)
end

return setup_jdtls
