return {
    "monaqa/dial.nvim",
    keys = require("knutwalker.keymap").dial(),
    init = function()
        -- prevent dial from setting up their own keymaps
        vim.g.loaded_dial = 1
    end,
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%H:%M"],
                augend.date.new({
                    pattern = "%a",
                    default_kind = "day",
                    word = true,
                }),
                augend.date.new({
                    pattern = "%A",
                    default_kind = "day",
                    word = true,
                }),
                augend.date.new({
                    pattern = "%b",
                    default_kind = "day",
                    word = true,
                }),
                augend.date.new({
                    pattern = "%B",
                    default_kind = "day",
                    word = true,
                }),
                augend.constant.alias.bool,
                augend.semver.alias.semver,
            },
        })
    end,
}
