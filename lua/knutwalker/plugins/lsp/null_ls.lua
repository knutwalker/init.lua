local M = {}

function M.setup(opts)
	local null_ls = require("null-ls")
	null_ls.setup({
		on_attach = opts.on_attach,
		sources = {
			null_ls.builtins.code_actions.refactoring,
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.formatting.isort,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.google_java_format.with({
				-- milliseconds
				timeout = 10000,
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.rustfmt.with({
				extra_args = { "--edition=2021" },
			}),
		},
	})
end

return M
