return {
	-- {{{ TMUX
	{
		"christoomey/vim-tmux-navigator",
		commit = "412c474e97468e7934b9c217064025ea7a69e05e", -- 🔐
		config = function()
			vim.g.tmux_navigator_no_mappings = true
		end,
	},
	-- }}} TMUX
}
