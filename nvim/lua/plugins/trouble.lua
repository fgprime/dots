return {
	-- ✓ A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		commit = "748ca2789044607f19786b1d837044544c55e80a", -- 🔐
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	},
}
