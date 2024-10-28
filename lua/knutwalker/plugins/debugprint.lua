-- std.debug.print("auto-gen DEBUG string\n", .{});
-- std.debug.print("auto-gen DEBUG string, variable={any}\n", .{variable});
local zig_format = {
    left = 'std.debug.print("',
    right = '\\n", .{});',
    mid_var = '{any}\\n", .{',
    right_var = '});',
}

return {
    "andrewferrier/debugprint.nvim",
    keys = "g?",
    opts = {
        filetypes = { ["zig"] = zig_format, }
    },
}
