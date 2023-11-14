local M = {}

function M.setup()
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	local navic = require("nvim-navic")

	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>de", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>dq", vim.diagnostic.setloclist, opts)

	local lsp_attach = function(client, bufnr)
		-- Add navic
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end

		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
		nmap("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")

		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
		nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document [S]ymbols")
		nmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<leader>lk", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Lesser used LSP functionality
		nmap("<leader>lw", vim.lsp.buf.add_workspace_folder, "[W]orkspace Add Folder")
		nmap("<leader>lW", vim.lsp.buf.remove_workspace_folder, "[W]orkspace Remove Folder")
		nmap("<leader>lL", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "Workspace [L]ist Folders")

		vim.keymap.set("n", "<space>lf", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end

	local lspconfig = require("lspconfig")
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			local lspsettings = {}
			if server_name == "cssls" then
				lspsettings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				}
			end
			lspconfig[server_name].setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
				settings = lspsettings,
				--     settings = {
				--       ["rust-analyzer"] = {}
				--     }
			})
		end,
	})
end

return M
