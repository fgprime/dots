local function getWords()
	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
		if vim.fn.wordcount().visual_words == 1 then
			return tostring(vim.fn.wordcount().visual_words) .. " word"
		elseif not (vim.fn.wordcount().visual_words == nil) then
			return tostring(vim.fn.wordcount().visual_words) .. " words"
		else
			return tostring(vim.fn.wordcount().words) .. " words"
		end
	else
		return ""
	end
end

-- local lineNum = vim.api.nvim_win_get_cursor(0)[1]
local function getLines()
	return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
	local val = vim.api.nvim_win_get_cursor(0)[2]
	-- pad value to 3 units to stop geometry shift
	return string.format("%03d", val)
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function obsession()
	local obsession_status = vim.api.nvim_call_function("ObsessionStatus", { "No Session", "Session" })

	if obsession_status == "" then
		return "No Session"
	else
		return vim.api.nvim_call_function("ObsessionStatus", { "Session", "No Session" })
	end
end

return {
	---- ✓ A blazing fast and easy to configure Neovim statusline written in Lua.
	{
		"nvim-lualine/lualine.nvim",
		commit = "7533b0e", -- 🔐
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "gruvbox",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
					globalstatus = false,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						{
							"diff",
							colored = true, -- Displays a colored diff status if set to true
							color_added = "#a7c080",
							color_modified = "#ffdf1b",
							color_removed = "#ff6666",
							symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
							source = diff_source, -- A function that works as a data source for diff.
							-- It must return a table as such:
							--   { added = add_count, modified = modified_count, removed = removed_count }
							-- or nil on failure. count <= 0 won't be displayed.
						},
						{
							"diagnostics",
							-- Table of diagnostic sources, available sources are:
							--   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
							-- or a function that returns a table as such:
							--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
							sources = { "nvim_lsp", "nvim_diagnostic", "vim_lsp" },
							-- Displays diagnostics for the defined severity types
							sections = { "error", "warn", "info", "hint" },
							diagnostics_color = {
								error = { bg = "#ff6666", fg = "#222222" },
								warn = { bg = "#ffdf1b", fg = "#222222" },
								info = { bg = "#a7c080", fg = "#222222" },
								hint = { bg = "#83a597", fg = "#222222" },
							},
							symbols = { error = " ", warn = " ", info = "? " },
							colored = true, -- Displays diagnostics status in color if set to true.
							update_in_insert = false, -- Update diagnostics in insert mode.
							always_visible = false, -- Show diagnostics even if there are none.
						},
					},
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							path = 1,
							-- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path

							shorting_target = 40, -- Shortens path to leave 40 spaces in the window
							-- for other components. (terrible name, any suggestions?)
							symbols = {
								modified = " ● ", -- Text to show when the file is modified.
								readonly = " RO", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
							},
						},
						obsession,
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						"encoding",
						{
							"fileformat",
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
						},
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
		dependencies = { "nvim-web-devicons" },
	},
	-- A simple statusline/winbar component that uses LSP to show your current code context. Named after the Indian satellite navigation system.
	{
		"SmiteshP/nvim-navic",
		commit = "15704c6", -- 🔐
		dependencies = "neovim/nvim-lspconfig",
	},
}
