--------------------------------------------------------------------
-- My mappings
--------------------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true, nowait = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Create box and figlet
map("v", "<F2>", "<cmd>.!boxes -d stone<cr>", opts)
map("v", "<F3>", "<cmd>.!toilet<cr>", opts)

-- Keep the cursor in place while joining lines
map("n", "J", function()
	vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, opts)

-- Make Y behave like other capitals
map("n", "Y", "y$", opts)

-- Quit visual mode
map("v", "v", "<Esc>", opts)
-- Move to the start of line
map("n", "H", "^", opts)
-- Move to the end of line
map("n", "L", "$", opts)
-- Redo
map("n", "U", "<C-r>", opts)

-- qq to record, Q to replay
--   nnoremap Q @q
map("n", "Q", "@q", opts)

-- Compatibility with German keyboard (e.g. vim-unimpaired keybindings [,])
map({ "n", "o", "x" }, "ü", "[", { remap = true, silent = true, nowait = true })
map({ "n", "o", "x" }, "+", "]", { remap = true, silent = true, nowait = true })

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- ----------------------------------------------------------------------------
-- More molecular undo of text
-- ----------------------------------------------------------------------------
map("i", ".", ".<c-g>u", opts)
map("i", "!", "!<c-g>u", opts)
map("i", "?", "?<c-g>u", opts)
map("i", ";", ";<c-g>u", opts)
map("i", ":", ":<c-g>u", opts)
-- ----------------------------------------------------------------------------
-- Moving lines
-- ----------------------------------------------------------------------------
-- Using Meta Key in iTerm and MacOS
-- ----------------------------------------------------------------------------
map("n", "<C-M-j>", ":move+<cr>", opts)
map("n", "<C-M-k>", ":move-2<cr>", opts)
map("n", "<C-M-h>", "<<", opts)
map("n", "<C-M-l>", ">>", opts)

map("x", "<C-M-j>", ":move'>+<cr>gv", opts)
map("x", "<C-M-k>", ":move-2<cr>gv", opts)
map("x", "<C-M-h>", "<gv", opts)
map("x", "<C-M-l>", ">gv", opts)

-- Movement in insert mode
map("i", "<C-M-j>", "<C-o>j", opts)
map("i", "<C-M-k>", "<C-o>k", opts)
map("i", "<C-M-h>", "<C-o>h", opts)
map("i", "<C-M-l>", "<C-o>a", opts)
map("i", "<C-M-^>", "<C-o><C-^>", opts)

-- Stop polluting clipboard with deleted characters
map("n", "dd", '"xdd', opts)
map("n", "d", '"xd', opts)
map("v", "d", '"xd', opts)
map("n", "x", '"xx', opts)
map("v", "x", '"xx', opts)
map("n", "c", '"xc', opts)
map("v", "C", '"xC', opts)

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
map("x", "p", '"_c<Esc>p', opts)
map("n", "gp", '"xp', opts)
map("n", "gP", '"xP', opts)

-- Leave cursor
map("v", "y", "ygv<Esc>", opts)
--
-- Move between windows
-- Replaced with TmuxNavigation
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
map("n", "<C-;>", ":TmuxNavigatePrevious<CR>", opts)

--
-- Move windows
map("n", "<C-M-S-j>", "<C-W>J", opts)
map("n", "<C-M-S-k>", "<C-W>K", opts)
map("n", "<C-M-S-h>", "<C-W>H", opts)
map("n", "<C-M-S-l>", "<C-W>L", opts)
--
-- Remap movement for wrapped lines being the same as for non-wrapped lines
map("n", "k", "gk", opts)
map("n", "gk", "k", opts)
map("n", "j", "gj", opts)
map("n", "gj", "j", opts)
--
-- Set middle of screen for  searches
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
map("n", "#", "#zz", opts)
map("n", "g*", "g*zz", opts)
--
-- Use gt to open definition in new tab
map("n", "gt", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
--
-- Stops using arrow keys in vim
-- map({ "i", "n", "v" }, "<Down>", "<Nop>", opts)
-- map({ "i", "n", "v" }, "<Left>", "<Nop>", opts)
-- map({ "i", "n", "v" }, "<Right>", "<Nop>", opts)
-- map({ "i", "n", "v" }, "<Up>", "<Nop>", opts)

-- CTRL-s save

function saveFile()
	local value = vim.api.nvim_exec("update", true)
	if value ~= nil and value ~= "" then
		require("notify")(value, "info", { title = "File saved", timeout = 500 })
	else
		require("notify")("No changes", "warn", { title = "File not saved", timeout = 1000 })
	end
end

map({ "n", "i", "v" }, "<C-s>", saveFile, opts)
--
-- ----------------------------------------------------------------------------
-- Additional bindings
-- ----------------------------------------------------------------------------
-- Using Meta Key in iTerm and MacOS
-- ----------------------------------------------------------------------------
-- Add Empty space above and below
--   Unimpaired
--  [<space>
--  ]<space>
-- includes newline

-- Definition for lines
map({ "x" }, "al", "$o0", opts)
map({ "o" }, "al", "<cmd>normal val<CR>", opts)
map({ "x" }, "il", "<Esc>^vg_", opts)
map({ "o" }, "il", "<cmd>normal! ^vg_<CR>", opts)

--------------------------------------------------------------------
-- Barbar mappings
--------------------------------------------------------------------

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
map("n", "<A-q>", "<Cmd>BufferWipeout<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

--------------------------------------------------------------------
-- WhichKey mappings
--------------------------------------------------------------------
local wk = require("which-key")

--------------------------------------------------------------------
-- Basic
wk.register({
	["1"] = { "1<C-W>w", "Move to Window 1" },
	["2"] = { "2<C-W>w", "Move to Window 2" },
	["3"] = { "3<C-W>w", "Move to Window 3" },
	["4"] = { "4<C-W>w", "Move to Window 4" },
	["5"] = { "5<C-W>w", "Move to Window 5" },
	["6"] = { "6<C-W>w", "Move to Window 6" },
	["*"] = { "ggVG<c-$>", "Select all" },
	p = { '"xp', "Paste deleted after" },
	P = { '"xP', "Paste deleted before" },
	Q = { "<cmd>:qa<CR>", "[q]uit" },
	h = { "<cmd>:noh<CR>", "No highlight" },
	-- ["!"] = { "<cmd>:qa<CR>", "Quit neovim" },
	["<Space>"] = {
		function()
			if vim.fn.system("git rev-parse --is-inside-work-tree") == true then
				require("telescope.builtin").git_files()
			else
				require("telescope.builtin").find_files()
			end
		end,
		"Find [git]",
	},
	[","] = {
		function()
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end,
		"Lines",
	},
	-- ["_"] = {
	-- 	function()
	-- 		require("telescope.builtin").buffers()
	-- 	end,
	-- 	"Buffers",
	-- },
	["."] = {
		function()
			saveFile()
		end,
		"Save file",
	},
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	-- ["!"] = {
	-- 	function()
	-- 		require("persistence").load()
	-- 	end,
	-- 	"Session: Load last one",
	-- },
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- New
wk.register({
	n = {
		name = "[ New ]",
		f = { ":enew<CR>", "New file" },
		b = { ":lcd %:p:h <CR>:e <CR>", "New file within same directory as current buffer" },
		s = { ":lcd %:p:h <CR>:vsp <CR>", "New split within same directory as current buffer" },
		c = {
			function()
				require("scripts.saveas").input()
			end,
			"New file through copy",
		},
	},
}, { prefix = "<leader>" })

--------------------------------------------------------------------
-- Tabs
wk.register({
	t = {
		name = "[ Tabs ]",
		k = { ":tabfirst<CR>", "tabfirst" },
		l = { ":tabnext<CR>", "tabnext" },
		h = { ":tabprev<CR>", "tabprev" },
		j = { ":tablast<CR>", "tablast" },
		n = { ":tabnew<CR>", "tabnew" },
		c = { ":tabclose<CR>", "tabclose" },
	},
}, { prefix = "<leader>" })

--------------------------------------------------------------------

--------------------------------------------------------------------
-- Window
wk.register({
	w = {
		name = "[ Window ]",
		w = { "<C-W>w", "Window next" },
		r = {
			function()
				require("persistence").load()
			end,
			"Window restore",
		},
		c = { "<C-W>c", "Window close" },
		q = { "<C-W>q", "Window quit" },
		j = { "<C-W>j", "Window up" },
		k = { "<C-W>k", "Window down" },
		h = { "<C-W>h", "Window left" },
		l = { "<C-W>l", "Window right" },
		z = { "<cmd>MaximizerToggle<CR>", "Window maximize or minimize" },
		["-"] = { "<C-W>10<", "Decrease width" },
		["+"] = { "<C-W>10>", "Increase width" },
		["."] = { ":resize -10<CR>", "Decrease height" },
		[":"] = { ":resize +10<CR>", "Increase height" },
		["="] = { "<C-W>=", "Window equal" },
		["_"] = { "<C-W>s", "Window split horizontal" },
		s = { "<C-W>v", "Window split vertical" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Quickfix
wk.register({
	q = {
		name = "[ Quickfix ]",
		o = { ":copen<CR>", "[o]pen" },
		c = { ":cclose<CR>", "[c]lose" },
		gg = { ":cfirst<CR>", "first" },
		n = { ":cnext<CR>", "next" },
		p = { ":cprev<CR>", "previous" },
		G = { ":clast<CR>", "last" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- General
wk.register({
	["_"] = {
		name = "[ General ]",
		c = { "<cmd>ColorizerToggle<CR>", "[ Colorizer ]" },
		n = {
			function()
				vim.cmd([[
      source $MYVIMRC
    ]])
				vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
			end,
			"[ NVIM ]: Relead configuration",
		},
		s = { "<cmd>SymbolsOutline<CR>", "[ Symbols ]" },
		m = { "<cmd>MinimapToggle<CR>", "[ Minimap ]" },
		u = { "<cmd>UndotreeToggle<CR>", "[ Undotree ]" },
		p = { "<cmd>TroubleToggle<CR>", "[ Trouble ]" },
		f = {
			function()
				vim.lsp.buf.format()
			end,
			"Format",
		},
		l = {
			function()
				require("persistence").load()
			end,
			"Session: Load for the current directory",
		},
		d = {
			function()
				require("persistence").load({ last = true })
			end,
			"Session: Load last one",
		},
		t = { "<cmd>NvimTreeToggle<CR>", "[ Tree ]" },
		x = {
			function()
				require("persistence").stop()
			end,
			"Session: Stop recording",
		},
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Helpers
-- Open application
local open = function(application)
	local open = "open -a '" .. application .. "'"
	vim.fn.jobstart(open, { detach = true })
end

map("n", "<C-M-s>", function()
	open("Safari")
end, opts)

wk.register({
	j = {
		name = "[ Jump to Application ]",
		c = {
			function()
				open("Google Chrome")
			end,
			"Google Chrome",
		},
		s = {
			function()
				open("Safari")
			end,
			"Apple Safari",
		},

		o = {
			function()
				open("Obsidian")
			end,
			"Obsidian",
		},

		f = {
			function()
				open("Figma")
			end,
			"Figma",
		},

		t = {
			function()
				open("TailwindCSS")
			end,
			"Tailwind",
		},

		g = {
			function()
				open("ChatGPT")
			end,
			"ChatGPT",
		},
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- -- LSP
-- wk.register({
-- 	l = {
-- 		name = "[ LSP ]",
-- 		f = {
-- 			name = "Format",
-- 		},
-- 	},
-- }, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Harpoon
wk.register({
	h = {
		name = "[ Harpoon ]",

		a = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Add file",
		},
		h = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"Quick menu",
		},
		n = {
			function()
				require("harpoon.ui").nav_next()
			end,
			"Next file",
		},

		p = {
			function()
				require("harpoon.ui").nav_prev()
			end,
			"Previous file",
		},
		-- s = {
		-- 	name = "Surround does not work", -- TODO
		-- 	["'"] = { "ysiw", "Surround word" },
		-- 	[";"] = { "yss", "Surround line" },
		-- },
	},
}, { prefix = "<leader>" })

--------------------------------------------------------------------

--------------------------------------------------------------------
-- Code
wk.register({
	c = {
		name = "[ Code ]",
	},
}, { prefix = "<leader>" })

wk.register({
	d = {
		name = "[ Diagnostics ]",
		x = { "<cmd>TroubleToggle<CR>", "Open/close trouble list" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Open trouble workspace diagnostics" },
		d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Open trouble document diagnostics" },
		q = { "<cmd>TroubleToggle quickfix<CR>", "Open trouble quickfix list" },
		l = { "<cmd>TroubleToggle loclist<CR>", "Open trouble location list" },
		t = { "<cmd>TodoTrouble<CR>", "Open todos in trouble" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- GIT
wk.register({
	g = {
		name = "[ Git ]",
		["/"] = { "<cmd>:!git rev-parse --show-toplevel<CR>", "No highlight" },
		S = { "<cmd>:Git add .", "Stage all" },
		s = {
			function()
				package.loaded.gitsigns.stage_buffer()
			end,
			"Stage buffer",
		},
		b = {
			function()
				package.loaded.gitsigns.blame_line({ full = true })
			end,
			"Blame",
		},
		B = {
			function()
				package.loaded.gitsigns.toggle_current_line_blame()
			end,
			"Blame line",
		},
		["#"] = { "<cmd>:Git blame<CR>", "Blame list" },
		x = { "<cmd>:GBrowse<CR>", "Github" },
		c = { "<cmd>:Git commit<CR>", "Commit" },
		d = {
			function()
				package.loaded.gitsigns.diffthis()
			end,
			"Diff buffer",
		},
		D = {
			function()
				package.loaded.gitsigns.diffthis("~")
			end,
			"Diff to last commit",
		},
		["?"] = { "<cmd>:Git<CR>", "Status" },
		h = {
			name = "Hunk",
		},
		hh = {
			function()
				package.loaded.gitsigns.stage_hunk()
			end,
			"Hunk stage",
		},
		hu = {
			function()
				package.loaded.gitsigns.undo_stage_hunk()
			end,
			"Hunk undo stage",
		},
		hr = {
			function()
				package.loaded.gitsigns.reset_hunk()
			end,
			"Hunk reset",
		},
		R = {
			function()
				package.loaded.gitsigns.reset_buffer()
			end,
			"Hunk undo stage",
		},
		hp = {
			function()
				package.loaded.gitsigns.preview_hunk()
			end,
			"Hunk preview",
		},
		["-"] = {
			function()
				package.loaded.gitsigns.toggle_deleted()
			end,
			"Toggle deleted",
		},
		hj = {
			function()
				package.loaded.gitsigns.next_hunk()
			end,
			"Hunk next",
		},
		hk = {
			function()
				package.loaded.gitsigns.prev_hunk()
			end,
			"Hunk previous",
		},
		l = { "<cmd>:Git log<CR>", "Log" },
		p = { "<cmd>:Git push<CR>", "Push" },
		P = { "<cmd>:Git pull<CR>", "pull" },
		r = { "<cmd>:GRemove<CR>", "Remove" },
		-- v = { "<cmd>:GV<CR>", "View commits" },
		-- V = { "<cmd>:GV!<CR>", "View buffer commits" },
	},
}, { prefix = "<leader>" })

wk.register({
	g = {
		name = "[ Git ]",
		h = {
			function()
				package.loaded.gitsigns.stage_hunk()
			end,
			"Hunk stage",
		},
		r = {
			function()
				package.loaded.gitsigns.reset_hunk()
			end,
			"Hunk reset",
		},
	},
}, { prefix = "<leader>", mode = "v" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Find
wk.register({
	f = {
		name = "[ Find ]",
		a = {
			function()
				require("telescope.builtin").find_files()
			end,
			"Find [all]",
		},
		b = {
			function()
				require("telescope.builtin").buffers()
			end,
			"Buffers",
		},
		["*"] = {
			function()
				require("telescope").extensions.neoclip.default()
			end,
			"Clipboard",
		},
		["#"] = {
			function()
				require("telescope").extensions.file_browser.file_browser()
			end,
			"File browser",
		},
		["-"] = {
			function()
				require("telescope.builtin").find_files({ cwd = "~/.dotfiles" })
			end,
			"Dotfiles",
		},
		["_"] = {
			function()
				require("telescope.builtin").find_files({ cwd = "~/.scripts" })
			end,
			"Dotfiles",
		},
		["?"] = {
			function()
				require("telescope.builtin").find_files({ cwd = "~/Documents/Dokumentation/Knowledge/" })
			end,
			"Obsidian",
		},
		["="] = {
			function()
				require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
			end,
			"Spell suggest",
		},
		d = {
			function()
				require("telescope.builtin").diagnostics()
			end,
			"Diagnostics",
		},
		[","] = {
			function()
				require("telescope").commands()
			end,
			"Commands",
		},
		p = {
			function()
				require("telescope").extensions.repo.list({})
			end,
			"Projects",
		},
		f = {
			function()
				if vim.fn.system("git rev-parse --is-inside-work-tree") == true then
					require("telescope.builtin").git_files()
				else
					require("telescope.builtin").find_files()
				end
			end,
			"Find [git]",
		},
		c = {
			function()
				require("telescope.builtin").git_bcommits()
			end,
			"Commits [buffer]",
		},
		G = {
			function()
				require("telescope.builtin").git_commits()
			end,
			"Commits",
		},
		g = {
			function()
				require("telescope.builtin").live_grep()
			end,
			"Grep",
		},
		w = {
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").find_files({ default_text = word })
			end,
			"Grep word",
		},
		W = {
			function()
				-- local word = vim.fn.expand("<cWORD>")
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ default_text = word })
			end,
			"Grep WORD",
		},
		["."] = {
			function()
				require("telescope.builtin").live_grep()
			end,
			"Grep",
		},
		h = {
			function()
				require("telescope.builtin").help_tags()
			end,
			"Help",
		},
		l = {
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			"Lines",
		},
		k = {
			function()
				require("telescope.builtin").keymaps()
			end,
			"Mappings",
		},
		m = {
			function()
				require("telescope.builtin").marks()
			end,
			"Marks",
		},

		r = {
			function()
				require("telescope.builtin").oldfiles()
			end,
			"Recent files",
		},
		s = {
			function()
				require("telescope.builtin").git_status()
			end,
			"Status [git]",
		},
		q = {
			function()
				require("telescope.builtin").quickfix()
			end,
			"Quickfix",
		},
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Obsidian
wk.register({
	o = {
		name = "[ Obsidian ]",
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Quick replace
-- Normal mode
wk.register({
	r = {
		name = "[ Replace ]",
		b = { ":%s/<C-r><C-w>/", "Replace current word" },
		l = { ":s/<C-r><C-w>/", "Replace current word in line" },
	},
}, { prefix = "<leader>", silent = false })
-- Visual mode
wk.register({
	r = {
		name = "[ Replace ]",
		b = { '""y:%s/<C-r>"/', "Replace current selection" },
	},
}, { prefix = "<leader>", silent = false, mode = "v" })

--------------------------------------------------------------------

--------------------------------------------------------------------
-- Search
-- Open browser
local browser = function(application, parameter)
	local target = vim.fn.trim(application) .. vim.fn.trim(parameter)
	local open_command = vim.fn.extend({ "open" }, { target })

	vim.fn.jobstart(open_command, { detach = true })
end

local function get_visual()
	vim.api.nvim_exec([[ normal "vygv ]], true)
	return vim.api.nvim_exec([[echo getreg('v')]], true):gsub("[\n\r]", "^J")
end

-- Normal mode
wk.register({
	s = {
		name = "[ Search ]",
		d = {
			function()
				browser("https://devdocs.io/#q=", vim.bo.filetype .. "%20" .. vim.fn.expand("<cword>"))
			end,
			"DevDocs",
		},
		g = {
			function()
				browser("https://google.de/search?q=", vim.fn.expand("<cword>"))
			end,
			"Google with selected word",
		},
		i = {
			function()
				require("browse").input_search()
			end,
			"Google with input",
		},
	},
}, { prefix = "<leader>" })

-- Visual mode
wk.register({
	s = {
		name = "[ Search ]",
		g = {
			function()
				browser("https://google.de/search?q=", get_visual())
			end,
			"Google with selected text",
		},
		s = {
			function()
				browser(get_visual(), "")
			end,
			"Open browser with selected text",
		},
	},
}, { prefix = "<leader>", mode = "v" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Buffer
wk.register({
	b = {
		name = "[ Buffer ]",
		b = {
			function()
				require("telescope.builtin").buffers()
			end,
			"List buffers",
		},
		n = "Order by number",
		p = "Order by directory tree",
		l = "Order by language",
		w = "Order by window number",
		s = { "<cmd>w<CR>", "Save buffer" },
		d = { "<Cmd>close<CR>", "Close file" },
		c = { "<Cmd>bd<CR>", "Close buffer view" },
		x = { "<cmd>bd!<CR>", "DELETE buffer" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Buffer
wk.register({
	l = {
		name = "[ Location ]",
		["-"] = { "<cmd>cd ~/.dotfiles<CR>", ".dotfiles" },
		["_"] = { "<cmd>cd ~/.scripts<CR>", ".scripts" },
		["p"] = { "<cmd>cd ~/Documents/Projects<CR>", "Projects" },
		["d"] = { "<cmd>cd ~/Documents<CR>", "Documents" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Time Date
wk.register({
	["#"] = {
		name = "[ Time/Date ]",
		t = { "<cmd>Time<CR>", "Time" },
		d = { "<cmd>Date<CR>", "Date" },
		u = { "<cmd>USDate<CR>", "US Date" },
		c = { "<cmd>TimeDiff<CR>", "Time Diff" },
	},
}, { prefix = "<leader>" })
--------------------------------------------------------------------
