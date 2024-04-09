return {
	-- ✓ It enhances some builtin textobjects (like a(, a), a', and more), creates new ones (like a*, a<Space>, af, a?, and more), and allows user to create their own (like based on treesitter, and more).
	{
		"echasnovski/mini.ai",
		commit = "ee9446a",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
}
