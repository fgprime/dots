local M = {}

function M.input()
	require("dressing").setup({
		input = {
			relative = "editor",
			win_options = {
				winhighlight = "NormalFloat:HintFloat",
			},
		},
	})

	local fpath = vim.fn.expand("%:h")
	if fpath ~= nil and fpath ~= "" then
		vim.ui.input({
			prompt = "Enter new file name:",
			-- default = "default value",
			completion = "file",
		}, function(input)
			if input then
				local value = vim.api.nvim_exec("saveas %:h/" .. input, true)
				if value ~= nil and value ~= "" then
					require("notify")(value, "info", { title = "File saved", timeout = 500 })
				else
					require("notify")("No changes", "warn", { title = "File not saved", timeout = 1000 })
				end
			end
		end)
	else
		require("notify")("No base directory found", "warn", { title = "File not saved", timeout = 1000 })
	end
end

M.input()

return M
