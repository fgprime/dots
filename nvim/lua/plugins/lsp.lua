-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- local function make_conf(...)
-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 	capabilities.textDocument.foldingRange = {
-- 		dynamicRegistration = false,
-- 		lineFoldingOnly = true,
-- 	}
-- 	capabilities.textDocument.completion.completionItem.snippetSupport = true
-- 	capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 		properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" },
-- 	}
-- 	capabilities.textDocument.colorProvider = { dynamicRegistration = false }
-- 	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--
-- 	return vim.tbl_deep_extend("force", {
-- 		handlers = {
-- 			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
-- 			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
-- 			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 				virtual_text = true,
-- 			}),
-- 		},
-- 		capabilities = capabilities,
-- 	}, ...)
-- end

local function lsp_organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local function lsp_rename_file()
	local old_name = vim.fn.expand("%:p:.")
	vim.ui.input({ "Rename file to: ", default = old_name, "file" }, function(new_name)
		if new_name == "" then
			return
		end

		local old_path = vim.fn.getcwd() .. "/" .. old_name
		local new_path = vim.fn.getcwd() .. "/" .. new_name

		local old_uri = vim.uri_from_fname(old_path)
		local new_uri = vim.uri_from_fname(new_path)

		local params = {
			command = "_typescript.applyRenameFile",
			arguments = {
				{
					sourceUri = old_uri,
					targetUri = new_uri,
				},
			},
		}

		vim.lsp.util.rename(old_path, new_path)
		vim.lsp.buf.execute_command(params)
		vim.api.nvim_command("edit" .. new_path)
	end)
end

return {

	-----------------------------------------------------------------------------
	-- {{{ LSP
	-- ✓ Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		lazy = true,
		cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstallAll", "MasonLog" },
		commit = "c43eeb5", -- 🔐
		config = function() end,
	},

	-- ✓ mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
	{
		"williamboman/mason-lspconfig.nvim",
		commit = "fe4cce4", -- 🔐
		config = function()
			require("mason").setup({
				ui = {
					check_outdated_packages_on_open = false,
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"eslint",
					-- "emmet_ls",
					"html",
					"cssls",
					"cssmodules_ls",
					"tailwindcss",
					"lua_ls",
					"bashls",
					"jsonls",
					"marksman",
					"intelephense",
					"pyright",
					"sqlls",
					"yamlls",
				},
				automatic_installation = true,
				ui = { check_outdated_servers_on_open = false },
			})

			-- Set it to true to update context only on CursorHold event. Could be usefull if
			-- you are facing performance issues on large files. Example usage
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if vim.api.nvim_buf_line_count(0) > 10000 then
						vim.b.navic_lazy_update_context = true
					end
				end,
			})

			-- Set up lspconfig.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local installed_servers = require("mason-lspconfig").get_installed_servers()

			-- local function lsp_show_diagnostics()
			--   vim.diagnostic.open_float({ border = border })
			-- end

			for _, server_name in ipairs(installed_servers) do
				local settings = {}
				local commands = {}
				if server_name == "cssls" then
					settings = {
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
				elseif server_name == "tailwindcss" then
					settings = {
						root_dir = {
							root_pattern = {
								"assets/tailwind.config.js",
								"tailwind.config.js",
								"tailwind.config.ts",
								"postcss.config.js",
								"postcss.config.ts",
								"package.json",
								"node_modules",
							},
						},
					}
				elseif server_name == "tsserver" then
					settings = {
						typescript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
					}
					commands = {
						OrganizeImports = {
							lsp_organize_imports,
							description = "Organize Imports",
						},
						RenameFile = {
							lsp_rename_file,
							description = "Rename File",
						},
					}
				end

				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						if client.server_capabilities.documentSymbolProvider then
							require("nvim-navic").attach(client, bufnr)
						end
						on_attach(client, bufnr)
					end,

					settings = lspsettings,
					commands = commands,
				})
			end
		end,
	},

	-- ✓ Configs for the Nvim LSP client
	{
		"neovim/nvim-lspconfig",
		event = "InsertEnter",
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		commit = "946c58c", -- 🔐
		config = function()
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>de", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<space>dq", vim.diagnostic.setloclist, opts)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end

						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
					end

					local vmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end

						vim.keymap.set("v", keys, func, { buffer = ev.buf, desc = desc })
					end
					--
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					nmap("<leader>ci", lsp_organize_imports, "Organize [i]mports")
					nmap("<leader>cR", lsp_rename_file, "[R]ename file")
					nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					nmap("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					nmap("<leader>ck", vim.lsp.buf.signature_help, "Signature Documentation")
					nmap("<leader>cw", vim.lsp.buf.add_workspace_folder, "[w]orkspace Add Folder")
					nmap("<leader>cW", vim.lsp.buf.remove_workspace_folder, "[W]orkspace Remove Folder")
					nmap("<leader>cL", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "Workspace [L]ist Folders")
					nmap("<leader>cD", vim.lsp.buf.type_definition, "Type [D]efinition")
					nmap("<leader>cr", vim.lsp.buf.rename, "[r]ename")
					-- 2x code action nmap, vmap
					nmap("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")
					vmap("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")

					nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					nmap("<leader>c#", require("telescope.builtin").lsp_document_symbols, "Document [S]ymbols")
					nmap(
						"<leader>c+",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace Symbols"
					)
					nmap("<leader>ca", vim.lsp.buf.references, "Code [A]ction")

					nmap("<space>cf", function()
						vim.lsp.buf.format({ async = true })
					end, "Format")
				end,
			})
		end,
	},

	-- ✓ Standalone UI for nvim-lsp progress. Eye candy for the impatient.
	{
		"j-hui/fidget.nvim",
		commit = "ad8873c", -- 🔐
		config = function()
			require("fidget").setup()
		end,
	},

	-- ✓ Show function signature when you type
	{
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
	},
	-- }}} LSP

	-----------------------------------------------------------------------------
	-- {{{ NULL LSP
	-- ✓ Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	{

		"nvimtools/none-ls.nvim",
		commit = "d991c89", -- 🔐
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"scss",
						"html",
						"json",
						"yaml",
						"markdown",
						"graphql",
						"md",
						"txt",
					},
				}),
				-- null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
			}
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
									-- On Neovim v0.8+, when calling vim.lsp.buf.format as done in the examples above, you may want to filter the available formatters so that only null-ls receives the formatting request
									filter = function(client)
										return client.name == "null-ls"
									end,
									timeout_ms = 2000,
								})
							end,
						})
					end
				end,
			})
		end,
	},
	-- ✓ mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
	{
		"jay-babu/mason-null-ls.nvim",
		commit = "ae0c5fa", -- 🔐
		config = function()
			require("mason-null-ls").setup({
				-- A list of sources to install if they're not already installed.
				-- This setting has no relation with the `automatic_installation` setting.
				ensure_installed = {},
				-- Run `require("null-ls").setup`.
				-- Will automatically install masons tools based on selected sources in `null-ls`.
				-- Can also be an exclusion list.
				-- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
				automatic_installation = true,

				-- Whether sources that are installed in mason should be automatically set up in null-ls.
				-- Removes the need to set up null-ls manually.
				-- Can either be:
				-- 	- false: Null-ls is not automatically registered.
				-- 	- true: Null-ls is automatically registered.
				-- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
				-- 	Ex: { types = { eslint_d = {'formatting'} } }
				automatic_setup = true,

				handlers = {},
			})

			-- require("mason-null-ls").setup_handlers({
			--   function(source_name, methods)
			--     -- all sources with no handler get passed here
			--
			--     -- To keep the original functionality of `automatic_setup = true`,
			--     -- please add the below.
			--     require("mason-null-ls.automatic_setup")(source_name, methods)
			--   end,
			-- })
			-----------------------------------------------------------------------------
		end,
	},
	-- }}} NULL LSP
}
