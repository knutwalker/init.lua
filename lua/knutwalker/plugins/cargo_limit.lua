return {
	"alopatindev/cargo-limit",
	build = "cargo install cargo-limit nvim-send",
	init = function()
		vim.api.nvim_create_user_command("CargoLimit", function()
			require("lazy").load({
				plugins = { "cargo-limit" },
				show = true,
				wait = true,
			})
		end, { desc = "Enable cargo limit support" })
	end,
	lazy = true,
}
