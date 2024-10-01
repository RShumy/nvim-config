local function get_jdtls()
    -- Get the Mason Registry to gain access to downloaded binaries
    local mason_registry = require("mason-registry")
    -- Find JDTLS pacakge in the Mason Registry
    local jdtls = mason_registry.get_pacakge("jdtls")
    -- Find the full path to directory where Mason has downloaded the JDTLS binaries
    local jdtls_path = jdtls:get_install_path()
    -- Obtain the path to the jar that runs the language server
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    -- Declare operating system, for linux use linux, windows use win, macos use mac
    local SYSTEM = "linux"
    -- Obtain path to configuration files for running opperating system
    local config = jdtls_path .. "/config" .. SYSTEM
end
