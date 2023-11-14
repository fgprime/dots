local M = {}

function M.setup()
	require("mason").setup({
		ui = {
			check_outdated_packages_on_open = false,
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"tsserver",
			"html",
			"cssls",
			-- "tailwindcss",
			-- "sumneko_lua",
			"lua_ls",
		},
		automatic_installation = true,
	})

	-- require("lspconfig").tailwindcss.setup {
	--        root_dir = root_pattern(
	--          'assets/tailwind.config.js',
	--          'tailwind.config.js',
	--          'tailwind.config.ts',
	--          'postcss.config.js',
	--          'postcss.config.ts',
	--          'package.json',
	--          'node_modules'
	--        )
	--  }
	--require("lspconfig").eslint.setup({})
	-- require("mason-lspconfig").setup_handlers({

	-- 	-- The first entry (without a key) will be the default handler
	-- 	-- and will be called for each installed server that doesn't have
	-- 	-- a dedicated handler.
	-- 	-- see :h mason-lspconfig-automatic-server-setup
	-- 	function(server_name)
	-- 		require("lspconfig")[server_name].setup({
	-- 			capabilities = capabilities,
	-- 			on_attach = on_attach,
	-- 		})
	-- 	end,

	-- 	-- Next, you can provide a dedicated handler for specific servers.
	-- 	-- For example, a handler override for the `rust_analyzer`:
	-- 	-- ["rust_analyzer"] = function ()
	-- 	--     require("rust-tools").setup {}
	-- 	-- end
	-- })
end

return M
