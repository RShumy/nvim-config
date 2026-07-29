_G.ghpack = function(repo)
    return "https://github.com/" .. repo
end
-- _G.plugin = function(plugin)
--     local platform = plugin.platform
--     local repo = plugin.repo
--     local url = ""
--
--     if (platform == nil) then
--             url = "https://github.com/"
--     elseif (platform == "gl") then
--             url = "https://gitlab.com/"
--     end
--
--     if (plugin.name ~= nil) then
--         return { src = url .. repo, name = plugin.name }
--     end
--
--     return url .. repo
-- end
--
-- _G.gh_plug = function(plugin, name)
--     if (name ~= nil) then
--         return _G.plugin{ repo = plugin, name = name}
--     end
--     return _G.plugin{ repo = plugin }
-- end
--
-- _G.gl_plug = function(plugin, name)
--     if (name ~= nil) then
--         return _G.plugin{ repo = plugin, name = name, platform = "gl"}
--     end
--     return _G.plugin{ repo = plugin, platform = "gl" }
-- end

--- Function fetches theme configuration from lua/plugins/themes/<theme>.lua
--- Vim add should have the parameter 'name' set with the same name as the sourced file:
--- vim.pack.add({ { src = "https://github.com/example/example-theme", name = "example"} })
--- lua/plugins/themes/example.lua
--- @param theme string The name of the theme as defined in the vim.pack.add function
_G.theme = function(theme)
    require("plugins.themes." .. theme)
    vim.cmd("colorscheme " .. theme)
end
