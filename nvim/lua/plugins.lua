local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	max_jobs = 50,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function()
	--  Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-----------------------------------------------------------------------------
	-- {{{ Loading optimization
	-- Speed up loading Lua modules in Neovim to improve startup time.
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})
	-- Easily speed up your neovim startup time!
	-- use({ "nathom/filetype.nvim" })
	-- }}} Loading optimization

	-----------------------------------------------------------------------------
	-- {{{ UI
	-- ✓ A Lua module for asynchronous programming using coroutines.
	use({ "nvim-lua/plenary.nvim" })

	-- With the release of Neovim 0.6 we were given the start of extensible core UI hooks (vim.ui.select and vim.ui.input). They exist to allow plugin authors to override them with improvements upon the default behavior, so that's exactly what we're going to do.
	use({ "stevearc/dressing.nvim" })
	--  UI Component Library for Neovim.
	use({ "MunifTanjim/nui.nvim" })

	---- ✓ Icons
	use({ "kyazdani42/nvim-web-devicons" })
	--  use({ "ryanoasis/vim-devicons" })

	---- ✓ Colorschema
	use({
		"sainnhe/gruvbox-material",
		config = function()
			vim.cmd("let g:gruvbox_material_background = 'hard'")
			vim.cmd("let g:gruvbox_material_float_style = 'dim'")
			vim.cmd("let g:gruvbox_material_enable_italic=1")
			vim.cmd("colorscheme gruvbox-material")
		end,
	})

	-- ✓ A fancy, configurable, notification manager for NeoVim
	use({
		"rcarriga/nvim-notify",
	})
	---- ✓ Dashboard
	use({
		"glepnir/dashboard-nvim",
		commit = "e517188", -- 🔐
		config = function()
			require("plugins/dashboard").setup()
		end,
	})
	---- ✓ Super fast git decorations implemented purely in lua/teal.
	use({
		"lewis6991/gitsigns.nvim",
		commit = "0d4fe37",
		config = function()
			require("plugins/git").setup()
		end,
	})

	-- Marks
	---- ✓ vim-signature is a plugin to place, toggle and display marks.
	use({
		"kshenoy/vim-signature",
		commit = "6bc3dd1", -- 🔐
	})

	---- ✓ A blazing fast and easy to configure Neovim statusline written in Lua.
	use({
		"nvim-lualine/lualine.nvim",
		commit = "7533b0e", -- 🔐
		config = function()
			require("plugins/lualine").setup({})
		end,
		--      after = "nvim-gps",
		requires = { "nvim-web-devicons" },
	})

	-- x A simple statusline/winbar component that uses LSP to show your current code context. Named after the Indian satellite navigation system.
	use({
		"SmiteshP/nvim-navic",
		commit = "15704c6", -- 🔐
		requires = "neovim/nvim-lspconfig",
	})

	---- ✓ barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode. Plus the tab names are made unique when two filenames match.
	use({
		"romgrk/barbar.nvim",
		commit = "065c6d7", -- 🔐
		config = function()
			require("plugins/barbar").setup()
		end,
		wants = "nvim-web-devicons",
	})

	---- ✓ Neoscroll: a smooth scrolling neovim plugin written in lua
	use({
		"karb94/neoscroll.nvim",
		commit = "d7601c2", -- 🔐
		config = function()
			require("neoscroll").setup()
		end,
	})

	-- ✓ Blazing fast minimap for vim, powered by code-minimap written in Rust.
	use({
		"wfxr/minimap.vim",
		commit = "2b0151d", -- 🔐
	})
	-- }}} UI

	-- {{{ TMUX
	--
	use({
		"christoomey/vim-tmux-navigator",
		commit = "7db70e0", -- 🔐
		config = function()
			vim.g.tmux_navigator_no_mappings = true
			-- vim.cmd("let g:tmux_navigator_no_mappings = 1")
		end,
	})
	-- use({
	--   "alexghergh/nvim-tmux-navigation",
	--
	--   commit = "", -- 🔐
	--   config = function()
	--     local nvim_tmux_nav = require("nvim-tmux-navigation")
	--
	--     nvim_tmux_nav.setup({
	--       disable_when_zoomed = true, -- defaults to false
	--     })
	--
	--     vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
	--     vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
	--     vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
	--     vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
	--     vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
	--     vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
	--   end,
	-- })
	-- }}} TMUX
	--
	-----------------------------------------------------------------------------
	-- {{{ Treesitter
	-- ✓ Use treesitter to autoclose and autorename html tag
	use({
		"windwp/nvim-ts-autotag",
		commit = "40615e9", -- 🔐

		before = "nvim-treesitter/nvim-treesitter",
	})
	-- Load before treesitter - led to bug

	-- ✓ A framework for running functions on Tree-sitter nodes, and updating the buffer with the result.
	use({
		"ckolkey/ts-node-action",
		requires = { "nvim-treesitter" },
		commit = "", -- 🔐
		config = function()
			require("ts-node-action").setup({})
			require("hurl").setup()
			vim.keymap.set({ "n" }, "<leader>ci", require("ts-node-action").node_action, { desc = "[Code][Toggle]" })
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "9c9e12f", -- 🔐
		run = ":TSUpdate",
		config = function()
			require("plugins/treesitter").setup()
		end,
		requires = {
			{
				"pfeiferj/nvim-hurl",
				commit = "3a34efe", -- 🔐
				branch = "main",
			},
			{
				-- ✓ Syntax aware text-objects, select, move, swap, and peek support.
				"nvim-treesitter/nvim-treesitter-textobjects",
				commit = "2d6d3c7", -- 🔐
			},
			{
				-- ✓ Location and syntax aware text objects which *do what you mean*
				"RRethy/nvim-treesitter-textsubjects",
				commit = "b913508", -- 🔐
			},
			{
				-- ✓ A super powerful autopair plugin for Neovim that supports multiple characters.
				"windwp/nvim-autopairs",
				commit = "59df87a", -- 🔐
				config = function()
					require("plugins/autopairs").setup()
				end,
			},
			{
				-- ✓ This plugin adds indentation guides to all lines (including empty lines).
				"lukas-reineke/indent-blankline.nvim",
				commit = "7075d78", -- 🔐
				config = function()
					require("plugins/indentblankline").setup()
				end,
			},
			{
				-- Necessary for comments in JSX
				-- ✓ A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
				"JoosepAlviste/nvim-ts-context-commentstring",
				commit = "0bf8fbc", -- 🔐
				config = function()
					require("nvim-treesitter.configs").setup({
						context_commentstring = {
							enable = true,
							enable_autocmd = false,
						},
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
	})
	-- }}} Treesitter

	-----------------------------------------------------------------------------
	-- {{{ Telescope
	-- ✓ An implementation of the Popup API from vim in Neovim.
	use({
		"nvim-lua/popup.nvim",
		commit = "b7404d3", -- 🔐
	})

	--- ✓ telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- 🔐
		config = function()
			require("plugins/telescope").setup()
		end,
	})

	-- ✓ fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "fab3e22", -- 🔐
		run = "make",
	})

	-- ✓ An extension for telescope.nvim that searches the filesystem for git repositories.
	use({
		"cljoly/telescope-repo.nvim",
		commit = "d069994", -- 🔐
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		commit = "6eb6bb4", -- 🔐
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

	use({
		"ThePrimeagen/harpoon",
		commit = "c1aebba", -- 🔐
		requires = "nvim-lua/plenary.nvim",
	})
	-- }}} Telescope

	-- {{{ Telescope
	-- use({
	--   "jackMort/ChatGPT.nvim",
	--   commit = "9f8062c", -- 🔐
	--   config = function()
	--     require("chatgpt").setup({
	--    })
	--   end,
	--   requires = {
	--     "MunifTanjim/nui.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "nvim-telescope/telescope.nvim",
	--   },
	-- })
	-- }}} ChatGPT

	-----------------------------------------------------------------------------
	-- {{{ LSP
	-- ✓ Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
	use({
		"williamboman/mason.nvim",
		commit = "0942198", -- 🔐
		config = function()
			require("mason").setup()
		end,
	})

	-- ✓ mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
	use({
		"williamboman/mason-lspconfig.nvim",

		commit = "2997f46", -- 🔐
		config = function()
			require("plugins/masonlspconfig").setup()
		end,
	})

	-- ✓ Configs for the Nvim LSP client
	use({
		"neovim/nvim-lspconfig",
		commit = "67f151e", -- 🔐
		config = function()
			require("plugins/lsp").setup()
		end,
	})

	-- ✓ Standalone UI for nvim-lsp progress. Eye candy for the impatient.
	use({
		"j-hui/fidget.nvim",

		tag = "legacy",
		-- commit = "44585a0", -- 🔐
		config = function()
			require("fidget").setup()
		end,
	})

	-- ✓ Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
	use({
		"folke/neodev.nvim",
		commit = "e9bc652", -- 🔐
		-- commit = "8fd2103", -- 🔐
		config = function()
			require("neodev").setup()
		end,
	})

	-- ✓ Show function signature when you type
	use({
		"ray-x/lsp_signature.nvim",
		commit = "51784ba", -- 🔐
		-- commit = "17ff7a4", -- 🔐
		config = function()
			require("lsp_signature").setup({
				bind = true,
				max_height = 40,
				handler_opts = {
					border = "rounded",
				},
				floating_window_above_cur_line = true,
			})
		end,
	})
	-- }}} LSP

	-----------------------------------------------------------------------------
	-- {{{ NULL LSP
	-- ✓ Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	use({
		"jose-elias-alvarez/null-ls.nvim",
		commit = "c3e6781", -- 🔐
		config = function()
			require("plugins/null-ls").setup()
		end,
	})
	-- ✓ mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
	use({
		"jay-babu/mason-null-ls.nvim",
		commit = "ae0c5fa", -- 🔐
		config = function()
			require("plugins/mason-null-ls").setup()
			-----------------------------------------------------------------------------
		end,
	})
	-- }}} NULL LSP

	-----------------------------------------------------------------------------
	-- {{{ CMP Autocomplete
	-- ✓ A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
	use({
		"hrsh7th/nvim-cmp",

		commit = "b8c2a62", -- 🔐
		requires = {
			{
				"hrsh7th/cmp-nvim-lua",
				commit = "f12408b", -- 🔐
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				commit = "0e6b2ed", -- 🔐
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
				commit = "50792f3", -- 🔐
			},
			{
				"hrsh7th/cmp-cmdline",
				commit = "8ee981b", -- 🔐
			},
			{
				"ray-x/cmp-treesitter",
				commit = "389eadd", -- 🔐
			}, -- nvim-cmp source for treesitter nodes. Using all treesitter highlight nodes as completion candicates. LRU cache is used to improve performance.
			{
				"lukas-reineke/cmp-rg",
				commit = "1cad8eb", -- 🔐
			},
			{
				"saadparwaiz1/cmp_luasnip",
				commit = "1809552", -- 🔐
			},
		},
		config = function()
			require("plugins/cmp").setup()
		end,
	})

	-- ✓ This tiny plugin adds vscode-like pictograms to neovim built-in lsp
	use({
		"onsails/lspkind-nvim",
		commit = "c68b3a0", -- 🔐
	})

	-- ✓ A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
	use({
		"folke/trouble.nvim",
		commit = "490f7fe", -- 🔐
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})

	-- ✓ Luasnip is a snippet-engine written entirely in lua.
	use({
		"L3MON4D3/LuaSnip",
		tag = "v1.*", -- 🔐
		requires = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	})

	-- ✓ emmet-vim is a vim plug-in which provides support for expanding abbreviations similar to emmet.
	use({
		"mattn/emmet-vim",
		commit = "def5d57", -- 🔐
	})

	-- }}} LSP Autocomplete

	-----------------------------------------------------------------------------
	-- {{{ Helpers
	-- ✓ Browse for anything using your choice of method
	use({
		"lalitmee/browse.nvim",
		commit = "d3a3278", -- 🔐
		requires = { "nvim-telescope/telescope.nvim" },
	})

	-- ✓ File manager for Neovim powered by nnn.
	-- use({
	-- 	"luukvbaal/nnn.nvim",
	-- 	commit = "4616ec6", -- 🔐
	-- 	config = function()
	-- 		require("nnn").setup()
	-- 	end,
	-- })
	-- ✓ A File Explorer For Neovim Written In Lua
	use({
		"kyazdani42/nvim-tree.lua", -- NOTE: Alternative "nvim-telescope/telescope-file-browser.nvim"
		commit = "18c7a31", -- 🔐
		event = "VimEnter",
		config = function()
			require("plugins/tree").setup()
		end,
	})

	-- ✓ A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
	use({
		"simrat39/symbols-outline.nvim",
		commit = "5127919", -- 🔐
		config = function()
			require("symbols-outline").setup()
		end,
	})

	-- ✓ A high-performance color highlighter for Neovim
	-- Alternative uga-rosa / ccc.nvim
	use({
		"NvChad/nvim-colorizer.lua",
		commit = "dde3084", -- 🔐
		config = function()
			require("colorizer").setup()
		end,
	})

	-- ✓ Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
	use({
		"sindrets/diffview.nvim",
		commit = "ab3757c", -- 🔐
		requires = "nvim-lua/plenary.nvim",
	})

	-- ✓ More Pleasant Editing on Commit Message
	use({
		"rhysd/committia.vim",
		commit = "0b4df1a", -- 🔐
		opt = true,
		setup = [[vim.cmd('packadd committia.vim')]],
		config = function()
			-- TODO: Add keybindings
		end,
	})

	-- ✓ Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.
	use({
		"mbbill/undotree",
		commit = "1a23ea8", -- 🔐
		cmd = "UndotreeToggle",
		setup = function()
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
	})

	-- ✓ Smart and Powerful commenting plugin for neovim / old Alternative use({ "tpope/vim-commentary" })
	use({
		"numToStr/Comment.nvim",
		commit = "c804329", -- 🔐
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	})

	-- ✓ fm-nvim is a Neovim plugin that lets you use your favorite terminal file managers (and fuzzy finders) from within Neovim.
	use({
		"is0n/fm-nvim",
		config = function()
			require("plugins/fm-nvim").setup()
		end,
	})

	-- ✓ A neovim plugin to persist and toggle multiple terminals during an editing session
	--
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins/term").setup()
		end,
	})

	-- ✓ todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
	use({
		"folke/todo-comments.nvim",
		commit = "09b0b17", -- 🔐
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})

	-- ✓ switching between a single-line statement and a multi-line one
	use({
		"AndrewRadev/splitjoin.vim",
		commit = "956d67c", -- 🔐
	})
	-- }}} Helpers
	-- {{{ Move & Search & replace
	-- ✓ Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing a new standard interface for moving around in the visible area in Vim-like modal editors.
	use({
		"ggandor/leap.nvim",
		commit = "5efe985", -- 🔐
		config = function()
			vim.keymap.set("n", "s", function()
				local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
					return vim.api.nvim_win_get_config(win).focusable
				end, vim.api.nvim_tabpage_list_wins(0))
				require("leap").leap({ target_windows = focusable_windows_on_tabpage })
			end)
			-- require("leap").add_default_mappings()
		end,
	})

	-- {{{  Session handling
	---- ✓ Persistence is a simple lua plugin for automated session management.
	use({
		"folke/persistence.nvim",
		commit = "d8a3eda", -- 🔐
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	})
	-- }}}  Session handling

	-- {{{  Registers & clipboard
	---- ✓ neoclip is a clipboard manager for neovim inspired by for example clipmenu. It records everything that gets yanked in your vim session (up to a limit which is by default 1000 entries but can be configured).
	use({
		"AckslD/nvim-neoclip.lua",
		commit = "5b9286a", -- 🔐
		requires = {
			{ "tami5/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("plugins/neoclip").setup()
		end,
	})
	-- }}}  Registers & clipboard

	-- {{{ Log file highlight
	--
	use({
		"fei6409/log-highlight.nvim",
		commit = "4f5cf26", -- 🔐
		config = function()
			require("log-highlight").setup({})
		end,
	})
	--
	-- }}} Log file hightlight

	-- {{{ Basics - Tim Pope
	use({
		"tpope/vim-speeddating",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					vim.cmd([[SpeedDatingFormat %d.%m.%y]])
					vim.cmd([[SpeedDatingFormat %d.%m.%Y]])
					vim.cmd([[SpeedDatingFormat %d/%m/%y]])
					vim.cmd([[SpeedDatingFormat %d/%m/%Y]])
					vim.cmd([[SpeedDatingFormat %d-%m-%y]])
					vim.cmd([[SpeedDatingFormat %d-%m-%Y]])
				end,
			})
		end,
	})
	use({ "tpope/vim-surround" }) -- NOTE: Alternative "kylechui/nvim-surround"
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-sensible" })
	use({ "tpope/vim-obsession" })
	use({ "tpope/vim-rhubarb" })
	use({ "tpope/vim-unimpaired" })
	use({ "tpope/vim-abolish" })
	use({ "tpope/vim-eunuch" })
	use({ "tpope/vim-capslock" })
	use({ "tpope/vim-dadbod" })
	use({ "tpope/vim-jdaddy" })
	use({ "tpope/vim-fugitive" })
	-- Load on specific commands
	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	--  Basics - Tim Pope

	-- {{{ Mappings
	-- ✓ WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing.
	use({
		"folke/which-key.nvim",
		commit = "e271c28", -- 🔐
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("plugins/which-key").setup({})
		end,
	})
	-- }}} Mappings

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
