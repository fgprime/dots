return {
	-- {{{ Treesitter
	-- ✓ Use treesitter to autoclose and autorename html tag
	{
		"windwp/nvim-ts-autotag",
		commit = "a1d526af391f6aebb25a8795cbc05351ed3620b5", -- 🔐
	},
	-- Load before treesitter - led to bug

	-- ✓ A framework for running functions on Tree-sitter nodes, and updating the buffer with the result.
	{
		"ckolkey/ts-node-action",
		dependencies = { "nvim-treesitter" },
		commit = "bfaa787cc85d753af3c19245b4142ed727a534b5", -- 🔐
		config = function()
			require("ts-node-action").setup({})
			-- require("hurl").setup()
			vim.keymap.set(
				{ "n" },
				"<leader>ct",
				require("ts-node-action").node_action,
				{ desc = "TS: Toggle node action" }
			)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		commit = "42fc28ba918343ebfd5565147a42a26580579482", -- 🔐
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					"comment",
					"cpp",
					"css",
					"csv",
					"dart",
					"diff",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gotmpl",
					"html",
					"http",
					"hurl",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"jsonc",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"php",
					"pod",
					"pug",
					"python",
					"regex",
					"ruby",
					"rust",
					"scss",
					"sql",
					"svelte",
					"swift",
					"tmux",
					"toml",
					"tsx",
					"twig",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
				},
				auto_install = true,
				autotag = {
					enable = true,
					filetypes = {
						"bash",
						"c",
						"cpp",
						"ruby",
						"rust",
						"python",
						"diff",
						"comment",
						"git_rebase",
						"gitcommit",
						"gitignore",
						"html",
						"hurl",
						"php",
						"pug",
						"css",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"jsdoc",
						"json",
						"json5",
						"jsonc",
						"svelte",
						"vue",
						"tsx",
						"jsx",
						"markdown",
						"markdown_inline",
						"yaml",
						"vim",
						"lua",
						"xml",
					},
				},
				highlight = {
					enable = true,
					disable = {},
					additional_vim_regex_highlighting = true,
					-- custom_captures = {["new_import"] = "CustomImportName"}
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-w>",
						node_decremental = "<C-M-space>",
					},
				},
				indent = { enable = true },
				rainbow = { enable = true, extended_mode = true },
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							-- ["aa"] = "@parameter.outer",
							-- ["ia"] = "@parameter.inner",
							-- ["af"] = "@function.outer",
							-- ["if"] = "@function.inner",
							-- ["ac"] = "@class.outer",
							-- ["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					-- Replaced by swap-sibling
					-- swap = {
					-- 	enable = true,
					-- 	swap_next = { ["<Leader>lu"] = "TS @parameter.inner" },
					-- 	swap_previous = { ["<Leader>lU"] = "TS @parameter.inner" },
					-- },
					lsp_interop = {
						enable = true,
						border = "none",
						-- TODO: What is peek definition?
						-- peek_definition_code = {
						-- 	["<Leader>df"] = "@function.outer",
						-- 	["<Leader>dF"] = "@class.outer",
						-- },
					},
				},
				autopairs = {
					enable = true,
				},
				-- textsubjects = {
				-- 	enable = true,
				-- 	keymaps = {
				-- 		["<Leader>"] = "textsubjects-smart",
				-- 		["<Leader>"] = "textsubjects-container-outer",
				-- 		["<Leader>"] = "textsubjects-container-inner",
				-- 	},
				-- },
				matchup = { enable = true },
			})
		end,
		dependencies = {
			{
				"pfeiferj/nvim-hurl",
				commit = "5b7c61364e1872ab1cbaf0ff1da941f0ec94a04a", -- 🔐
				branch = "main",
			},
			{
				-- ✓ Syntax aware text-objects, select, move, swap, and peek support.
				"nvim-treesitter/nvim-treesitter-textobjects",
				commit = "0f051e9813a36481f48ca1f833897210dbcfffde", -- 🔐
			},
			{
				-- ✓ Location and syntax aware text objects which *do what you mean*
				"RRethy/nvim-treesitter-textsubjects",
				commit = "abcbb0e537c9c24800b03b9ca33bee5806604629", -- 🔐
			},
			{
				-- ✓ A super powerful autopair plugin for Neovim that supports multiple characters.
				"windwp/nvim-autopairs",
				commit = "4d74e75913832866aa7de35e4202463ddf6efd1b", -- 🔐
				dependencies = { "hrsh7th/nvim-cmp" },
				config = function()
					local npairs = require("nvim-autopairs")
					npairs.setup({
						check_ts = true,
					})
					npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
				end,
			},

			{
				-- ✓ This plugin adds indentation guides to all lines (including empty lines).
				"lukas-reineke/indent-blankline.nvim",
				dependencies = {
					{
						"HiPhish/rainbow-delimiters.nvim",
						commit = "97bf4b8ef9298644a29fcd9dd41a0210cf08cac7", -- 🔐
						config = function()
							vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#fb4934" })
							vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#fabd2f" })
							vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#83a598" })
							vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#fe8016" })
							vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#8ec07c" })
							vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#d3869b" })
							vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#ebdbb2" })
							require("rainbow-delimiters.setup").setup({})
						end,
					},
				},
				-- commit = "7075d78", -- 🔐
				main = "ibl",
				config = function()
					local highlight = {
						"Whitespace",
					}

					require("ibl").setup({
						exclude = {
							filetypes = {
								"help",
								"dashboard",
								"packer",
								"NvimTree",
								"Trouble",
								"TelescopePrompt",
								"Float",
							},
							buftypes = { "terminal", "nofile", "telescope" },
						},
						indent = {
							char = "│",
							tab_char = "│",
							smart_indent_cap = true,
							highlight = highlight,
						},
						whitespace = {
							highlight = highlight,
							remove_blankline_trail = true,
						},
						scope = {
							enabled = true,
							show_start = false,
						},
					})
				end,
			},
			{
				-- Necessary for comments in JSX
				-- ✓ A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
				"JoosepAlviste/nvim-ts-context-commentstring",
				commit = "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f", -- 🔐
				config = function()
					-- Speed up nvim-ts-context-commentstring
					vim.g.skip_ts_context_commentstring_module = true

					require("ts_context_commentstring").setup({
						enable_autocmd = false,
					})
				end,
			},
			-- {
			-- 	 ✓ Lightweight alternative to context.vim implemented with nvim-treesitter.
			-- 	 "romgrk/nvim-treesitter-context",
			-- 	 commit = "cacee48", -- 🔐
			-- 	 config = function()
			-- 	 	require("treesitter-context").setup({ enable = true })
			-- 	 end,
			-- },
		},
	},
	-- }}} Treesitter
}
