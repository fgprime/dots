return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	commit = "8f2af76", -- 🔐
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end,
}
