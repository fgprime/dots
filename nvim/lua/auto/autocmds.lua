-- Source
-- https://github.com/joshmedeski/dotfiles/blob/main/.config/nvim/lua/config/autocmds.lua

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*tmux.conf" },
	command = "execute 'silent !tmux source <afile> --silent'",
})
