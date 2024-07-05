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
	-- }}} TMUX
}
