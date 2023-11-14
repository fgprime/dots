local M = {}

function M.setup()
	-- e.g. https://github.com/josephsdavid/dots/blob/f78c7efedcf3398e35da79c51a6d62b0563905f8/config/nvim/lua/core/plugins.lua

	local mappings = {
		{ "n", "<leader>ls", "<Plug>Lightspeed_s" },
		{ "n", "<leader>lS", "<Plug>Lightspeed_S" },
		{ "v", "<leader>ls", "<Plug>Lightspeed_s" },
		{ "v", "<leader>lS", "<Plug>Lightspeed_S" },

		{ "n", "<leader>lf", "<Plug>Lightspeed_f" },
		{ "n", "<leader>lF", "<Plug>Lightspeed_F" },
		{ "v", "<leader>lf", "<Plug>Lightspeed_f" },
		{ "v", "<leader>lF", "<Plug>Lightspeed_F" },

		{ "n", "<leader>lt", "<Plug>Lightspeed_t" },
		{ "n", "<leader>lT", "<Plug>Lightspeed_T" },
		{ "v", "<leader>lt", "<Plug>Lightspeed_t" },
		{ "v", "<leader>lT", "<Plug>Lightspeed_T" },
	}

	for _, m in ipairs(mappings) do
		vim.keymap.set(m[1], m[2], m[3], { noremap = true, silent = true })
	end

	require("lightspeed").setup({
		ignore_case = true,
		special_keys = {
			next_match_group = "<TAB>",
			prev_match_group = "<S-Tab>",
		},
	})
end

return M
