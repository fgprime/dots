local M = {}

function M.setup()
	require("fm-nvim").setup({

		ui = {
			-- Default UI (can be "split" or "float")
			default = "float",

			float = {
				-- Floating window border (see ':h nvim_open_win')
				border = "rounded",

				-- Highlight group for floating window/border (see ':h winhl')
				float_hl = "Black",
				border_hl = "FloatBorder",

				-- Floating Window Transparency (see ':h winblend')
				blend = 0,

				-- Num from 0 - 1 for measurements
				height = 0.8,
				width = 0.8,

				-- X and Y Axis of Window
				x = 0.5,
				y = 0.5,
			},

			split = {
				-- Direction of split
				direction = "topleft",

				-- Size of split
				size = 24,
			},
		},
	})
end

return M
