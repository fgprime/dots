-- Custom Folds, make them look better
vim.cmd([[
  function! CustomFold()
    return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
  endfunction
]])

local options = {
	equalalways = true,
	clipboard = "unnamed", --- Copy-paste between vim and everything else
	expandtab = true, --- Use spaces instead of tabs
	number = true, --- Shows current line number
	hlsearch = true,
	incsearch = true, --- Start searching before pressing enter
	autoindent = true, --- Good auto indent
	ignorecase = true, --- Needed for smartcase
	smartcase = true, --- Uses case in search
	shiftwidth = 2, --- Change a number of space characeters inseted for indentation
	encoding = "utf-8", --- The encoding displayed
	errorbells = false, --- Disables sound effect for errors
	fileencoding = "utf-8", --- The encoding written to file
	smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
	tabstop = 2, --- Insert 2 spaces for a tab
	mouse = "a", --- Enable mouse
	relativenumber = true, --- Enables relative number
	splitright = true, --- Vertical splits will automatically be to the right
	cursorline = true, --- Highlight of current line
	scrolloff = 15, --- Always keep space when scrolling to bottom/top edge
	backspace = "indent,eol,start", --- Making sure backspace works
	undofile = true, --- Sets undo to file
	undodir = os.getenv("HOME") .. "/.config/nvim/.undo//",
	completeopt = "menu,menuone,noselect", --- Better autocompletion
	termguicolors = true, --- Correct terminal colors
	-- cc = "80", --- Show ruler at 80 characters
	title = true,
	hidden = true,
	switchbuf = "useopen,uselast",
	spell = true,
	spelllang = "en_gb,en_us,de_de",
	splitbelow = true,
	inccommand = "split",
	background = "dark",
	list = true,
	ttimeoutlen = 0,
	cmdheight = 2, --- Give more space for displaying messages
	emoji = false, --- Fix emoji display
	foldlevelstart = 99, --- Expand all folds by default
	foldtext = "CustomFold()", --- Emit custom function for foldtext
	-- lazyredraw = true, --- Makes macros faster & prevent errors in complicated mappings
	showtabline = 2, --- Always show tabs
	signcolumn = "yes", --- Add extra sign column next to line number
	smartindent = true, --- Makes indenting smart
	softtabstop = 2, --- Insert 2 spaces for a tab
	swapfile = false, --- Swap not needed
	-- timeout = true, -- Maybe needed for Which-Key?
	timeoutlen = 600, --- increased from 300 to use surround keys fast enough --> maybe not Faster completion
	updatetime = 100, --- Faster completion
	viminfo = "'1000", --- Increase the size of file history
	wildignore = "*node_modules/**", --- Don't search inside Node.js modules (works for gutentag)
	wrap = false, --- Display long lines as just one line
	writebackup = false, --- Not needed
	-- Neovim defaults
	backup = false, --- Recommended by coc
	conceallevel = 1, --- Show `` in markdown files
	showmode = true, --- Don't show things like -- INSERT -- anymore
	filetype = "on",
}

vim.api.nvim_exec("language en_US.UTF-8", true)

-- Disalbe netrw in favour of NvimTree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Disalbe some data in saved sessions
vim.opt.ssop:remove("options")
vim.opt.ssop:remove("folds")

local globals = {
	fillchars = "fold:\\ ", --- Fill chars needed for folds
	mapleader = " ", --- Map leader key to SPC
	--- speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
}

-- Font
vim.opt.guifont = "MesloLGS NF"
-- Cursor
vim.opt.guicursor = "n-v-c-sm:block-blinkon400-blinkoff250,i-ci-ve:hor20,r-cr-o:hor20"

vim.opt.listchars["tab"] = "▸ "
vim.opt.listchars["trail"] = "·"
vim.opt.listchars["eol"] = "¬"
vim.opt.listchars["nbsp"] = "_"
vim.opt.listchars["precedes"] = "«"
vim.opt.listchars["extends"] = "»"
vim.opt.listchars["space"] = "·"

---  SETTINGS  ---
vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

--  Abbrevations for inserting time and date
vim.cmd("iabbrev itime <C-R>=strftime('%H:%M')<cr>")
vim.cmd("iabbrev igdate <C-R>=strftime('%d.%m.%Y')<cr>")
vim.cmd("iabbrev idate <C-R>=strftime('%Y-%m-%d')<cr>")
vim.api.nvim_create_user_command("TimeDiff", ":. !~/.scripts/timediff.sh", {})

-- Fix spelling issues
vim.cmd("iabbrev cosnt const")

-- Commands for inserting time and date
vim.api.nvim_create_user_command("Time", "normal a<C-R>=strftime('%H:%M')<CR><ESC>", {})
vim.api.nvim_create_user_command("USDate", "normal a<C-R>=strftime('%Y-%m-%d')<CR><ESC>", {})
vim.api.nvim_create_user_command("Date", "normal a<C-R>=strftime('%d.%m.%Y')<CR><ESC>", {})

--   " Return to last edit position when opening files (You want this!)
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

--   " Execute a macro for the all selection
--   function ExecuteMacroOverVisualRange() abort
--       echo "@".getcmdline()
--       execute ":'<,'>normal @".nr2char(getchar())
--   endfunction
--   xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
--
--   " Create new js file, if it does not exist
--   au BufRead,BufNewFile *.js map gf :execute "drop ".expand('%:p:h').'/'.expand('<cfile>').'.js'<cr>

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "#141517" })
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "#1d2021" })
	end,
})
