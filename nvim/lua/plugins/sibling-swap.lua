return {
	"Wansmer/sibling-swap.nvim",
	commit = "75e696c340429769aa34d0bbae1511c8d9660c0b", -- 🔐
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
