local registry = require("mason-registry")

local ensure_installed = {
    -- Java
    "java-debug-adapter",
    "java-test",

    -- Future tools
    -- "stylua",
    -- "prettier",
    -- "eslint_d",
}

for _, package_name in ipairs(ensure_installed) do
    local ok, package = pcall(
        registry.get_package,
        package_name
    )

    if not ok then
        vim.notify(
            ("Mason package '%s' not found"):format(package_name),
            vim.log.levels.WARN
        )
    elseif not package:is_installed() then
        package:install({
            force = false
        })
    end

    package:once(
        "install:success",
        function()
            vim.notify(
                package.name .. " installed"
            )
        end
    )
end
