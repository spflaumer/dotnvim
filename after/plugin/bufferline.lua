local stat, bline = pcall(require,"bufferline")
if (not stat) then
--        print("bufferline unavailable")
        return
end

bline.setup({
        options = {
                mode = "buffers",
                themable = true,
                numbers = "buffer_id",
        }
})
