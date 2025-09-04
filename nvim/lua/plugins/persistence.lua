return {
	-- {{{  Session handling
	---- ✓ Persistence is a simple lua plugin for automated session management.
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	},
	--
}
