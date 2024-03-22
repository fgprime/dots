return {
	-- ✓ Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.
	{
		"mbbill/undotree",
		commit = "1a23ea8", -- 🔐
		cmd = "UndotreeToggle",
		config = function()
			vim.g.undotree_WindowLayout = 2 -- layout with diff at the bottom
			vim.g.undotree_DiffpanelHeight = 7 -- most of the time only one line changes
			vim.g.undotree_ShortIndicators = 1 -- time indicators 's,m,h,d'
			vim.g.undotree_SplitWidth = 40 -- it fits 3 branches
			vim.g.undotree_TreeNodeShape = ""
			vim.g.undotree_TreeVertShape = "│"
			vim.g.undotree_DiffAutoOpen = 0 -- it does not carry much info
			vim.g.undotree_SetFocusWhenToggle = 1 -- better for using it for complicated undo and not informative
			vim.g.undotree_HelpLine = 0 -- do not show the help line hint
		end,
	},
}
