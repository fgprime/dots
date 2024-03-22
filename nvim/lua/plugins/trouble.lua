return {
	-- ✓ A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		commit = "490f7fe", -- 🔐
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	},
}
