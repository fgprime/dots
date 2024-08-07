return {
	-- ✓ WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing.
	{
		"folke/which-key.nvim",
		-- commit = "e271c28", -- 🔐
		event = "VeryLazy",
		opts = {
			preset = "classic",

			plugins = {
				spelling = {
					enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				},
			},
			win = {
				border = "double", -- none, single, double, shadow
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				wo = {
					winblend = 10,
				},
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 6, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			icons = {
				group = "",
			},
			disable = {
				ft = { "TelescopePrompt", "toggleterm", "NvimTree" },
			},
		},
	},
}
