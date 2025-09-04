return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	commit = "c271c9082886a24866353764cf96c9d957e95b2b", -- 🔐
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end,
}
