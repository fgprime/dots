-- Based on https://github.com/akinsho/toggleterm.nvim/blob/193786e0371e3286d3bc9aa0079da1cd41beaa62/lua/toggleterm/utils.lua#L24
function gitDir()
	local gitdir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
	local isgitdir = vim.fn.matchstr(gitdir, "^fatal:.*") == ""
	if not isgitdir then
		return "~/Documents/Projects/"
	end
	return vim.trim(gitdir)
end

function isGitDir()
	return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

return {
	-- {{{ CMP Autocomplete
	-- ✓ A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
	{
		"hrsh7th/nvim-cmp",

		commit = "abacd4c", -- 🔐
		dependencies = {

			{
				"hrsh7th/cmp-nvim-lua",
				commit = "f12408b", -- 🔐
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				commit = "fa13fd6", -- 🔐
			},
			{
				"hrsh7th/cmp-buffer",
				commit = "3022dbc", -- 🔐
			},
			{
				"hrsh7th/cmp-path",
				commit = "91ff86c", -- 🔐
			},
			{
				"hrsh7th/cmp-calc",
				commit = "5947b41", -- 🔐
			},
			{
				"hrsh7th/cmp-cmdline",
				commit = "d250c63", -- 🔐
			},
			{
				"ray-x/cmp-treesitter",
				commit = "958fcfa", -- 🔐
			}, -- nvim-cmp source for treesitter nodes. Using all treesitter highlight nodes as completion candicates. LRU cache is used to improve performance.
			{
				"lukas-reineke/cmp-rg",
				commit = "dde00ad", -- 🔐
			},
			{
				"saadparwaiz1/cmp_luasnip",
				commit = "05a9ab2", -- 🔐
			},
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local lspkind = require("lspkind")
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			}

			local luasnip = require("luasnip")
			local cmp = require("cmp")
			cmp.setup({
				window = {
					documentation = cmp.config.window.bordered(),
					completion = {
						-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -5,
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
						scrolloff = 0,
						side_padding = 1,
						scrollbar = "┃",
					},
				},
				completion = {
					scrollbar = "┃",
					completeopt = "menu,menuone,preview",
					keyword_length = 2,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							symbol_map = kind_icons,
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    " .. (strings[2] or "") .. ""

						return kind
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					-- TODO: use CR or C-y?
					["<C-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "luasnip", priority = 4 },
					{ name = "path", priority = 3 },
					{ name = "nvim_lsp", priority = 3 },
					{ name = "buffer", priority = 1 },
					{ name = "calc", priority = 5 },
					{ name = "treesitter", priority = 1 },
					{ name = "nvim_lsp_signature_help", priority = 10 },
					{
						name = "rg",
						cwd = gitDir(),
						-- keyword_length = 3,
						-- priority = 5,
					},
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
				view = { name = "wildmenu", separator = "|" },
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
			-- Might fix autopairs error
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			-- require("plugins/cmp").setup()

			-- Colors
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
			vim.api.nvim_set_hl(0, "Pmenu", { fg = "#fbf1c7", bg = "#3c3836" })

			vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#928374", bg = "NONE", strikethrough = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#83a598", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#83a598", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#7c6f64", bg = "NONE", italic = true })

			vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#282828", bg = "#e78a4e" })
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#282828", bg = "#e78a4e" })
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#282828", bg = "#e78a4e" })

			vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#7c6f64", bg = "#282828" })

			vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#282828", bg = "#d8a657" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#282828", bg = "#d8a657" })
			vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#282828", bg = "#d8a657" })

			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#282828", bg = "#d3869b" })
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#282828", bg = "#d3869b" })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#282828", bg = "#d3869b" })
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#282828", bg = "#d3869b" })
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#282828", bg = "#d3869b" })

			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#282828", bg = "#7c6f64" })
			vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#282828", bg = "#7c6f64" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#282828", bg = "#7c6f64" })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#282828", bg = "#7c6f64" })

			vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#282828", bg = "#d8a657" })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#282828", bg = "#d8a657" })
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#282828", bg = "#d8a657" })

			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#282828", bg = "#7daea3" })
			vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#282828", bg = "#7daea3" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#282828", bg = "#7daea3" })

			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#282828", bg = "#89b482" })
			vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#282828", bg = "#89b482" })
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#282828", bg = "#89b482" })
		end,
	},

	-- ✓ This tiny plugin adds vscode-like pictograms to neovim built-in lsp
	{
		"onsails/lspkind-nvim",
		commit = "1735dd5", -- 🔐
	},

	-- ✓ Luasnip is a snippet-engine written entirely in lua.
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- 🔐
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
