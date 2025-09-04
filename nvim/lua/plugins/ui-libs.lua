return {

	--  UI Component Library for Neovim.
	-- { "MunifTanjim/nui.nvim" },

	---- ✓ Icons
	{
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},

	---- ✓ Colorschema
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.cmd("let g:gruvbox_material_background = 'hard'")
			vim.cmd("let g:gruvbox_material_float_style = 'dim'")
			vim.cmd("let g:gruvbox_material_enable_italic=1")
			vim.cmd("colorscheme gruvbox-material")
		end,
	},

	-- ✓ A fancy, configurable, notification manager for NeoVim
	{
		"rcarriga/nvim-notify",
	},

	{
		-- ✓ A Lua module for asynchronous programming using coroutines.
		"nvim-lua/plenary.nvim",
	},
}
