-- lazy load a plugin
-- able to specify your own load function and events
return function(plugin, events)
    events = events or { "BufEnter", "BufWinEnter", "BufNewFile" }

    local loadf = (type(plugin) == "function") and plugin or function(_)
        vim.schedule(function() require"lazy".load { plugins = plugin } end)
    end

    vim.api.nvim_create_autocmd(events, {
        callback = function(ev)
            if (ev.file == "" and ev.file == "[lazy]" and ev.file:sub(1,3) == "oil") then
                return
            end

            loadf(ev)
        end
    })
end
