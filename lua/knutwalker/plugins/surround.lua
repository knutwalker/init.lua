return {
	"kylechui/nvim-surround",
	tag = "v1.0.0",
	event = "BufReadPost",
	opts = {
		surrounds = {
			["y"] = {
				add = function()
					local result = require("nvim-surround.config").get_input("Enter the type name: ")
					if result then
						return { { result .. "<" }, { ">" } }
					end
				end,
				find = function()
					local selection
					if vim.g.loaded_nvim_treesitter then
						selection = require("nvim-surround.config").get_selection({
							query = {
								capture = "@call.outer",
								type = "textobjects",
							},
						})
					end
					if selection then
						return selection
					end
					return require("nvim-surround.config").get_selection({ pattern = "[%a_'][%w:_]*%b<>" })
				end,
				delete = "^(.-<)().-(>)()$",
				change = {
					target = "^.-([%a_'][%w:_]*)()<.->()()$",
					replacement = function()
						local result = require("nvim-surround.config").get_input("Enter the type name: ")
						if result then
							return { { result }, { "" } }
						end
					end,
				},
			},
		},
	},
}
