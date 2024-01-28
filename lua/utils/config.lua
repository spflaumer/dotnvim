-- check if it's a function or a table as config
local function config_or_function(res)
    if type(res) == "function" then
        return res()
    else
        return res
    end
end

-- look into the configs directory and find a lua module named `config`
-- or a key named `config` within a table returned by a a misc.lua file
return function(config)
    -- TODO: 
    -- - expand function to set a custom configs directory
    -- - expand function to set a custom misc.lua filename

    local res, config_or_msg = pcall(require, "configs."..config)

    if res then
        return config_or_function(config_or_msg)
    end

    -- possibly expand this to support a user supplied config file
    local misc = require"configs.misc"
    return misc[config] and config_or_function(misc[config]) or error(config_or_msg)
end
