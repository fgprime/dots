return {
	"Wansmer/sibling-swap.nvim",
	commit = "a9a0fbb", -- 🔐
	dependencies = { "nvim-treesitter" },
	keys = {
		{
			"<leader>cx",
			function()
				require("sibling-swap").swap_with_right_with_opp()
			end,
			desc = "SS: E[X]change with right with opp",
		},
		{
			"<leader>cX",
			function()
				require("sibling-swap").swap_with_left_with_opp()
			end,
			desc = "SS: E[X]change with left with opp",
		},
		{
			"<leader>cs",
			function()
				require("sibling-swap").swap_with_right()
			end,
			desc = "SS: [s]wap with right",
		},
		{
			"<leader>cS",
			function()
				require("sibling-swap").swap_with_left()
			end,
			desc = "SS: [S]wap with left",
		},
	},
	config = function()
		require("sibling-swap").setup({
			use_default_keymaps = false,
			allow_interline_swaps = true,
		})
	end,
}
