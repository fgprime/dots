local M = {}

function M.setup()
	local sources = {}
	if pcall(require, "gitsigns") then
		table.insert(sources, require("null-ls").builtins.code_actions.gitsigns)
	end
	-- print(vim.inspect(sources))
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	require("null-ls").setup({
		sources = sources,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							-- 	-- On Neovim v0.8+, when calling vim.lsp.buf.format as done in the examples above, you may want to filter the available formatters so that only null-ls receives the formatting request
							-- 	-- filter = function(client)
							-- 	-- 	return client.name == "null-ls"
							-- 	-- end,
							timeout_ms = 2000,
						})
					end,
				})
			end
		end,
	})
end

return M
