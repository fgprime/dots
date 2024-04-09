return {
	-- {{{ TMUX
	--
	{
		"christoomey/vim-tmux-navigator",
		commit = "7db70e0", -- 🔐
		config = function()
			vim.g.tmux_navigator_no_mappings = true
		end,
	},

	-- cmd = {
	--    "TmuxNavigateLeft",
	--    "TmuxNavigateDown",
	--    "TmuxNavigateUp",
	--    "TmuxNavigateRight",
	--    "TmuxNavigatePrevious",
	--  },
	--  keys = {
	--    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	--    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	--    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	--    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	--    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	--  },
	-- }}} TMUX
}
