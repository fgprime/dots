return {
	---- ✓ Super fast git decorations implemented purely in lua/teal.
	{
		"lewis6991/gitsigns.nvim",
		commit = "1b0350ab707713b2bc6c236151f1a324175347b1",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					-- require("notify")("Gitsigns loaded")
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Text object
					-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
