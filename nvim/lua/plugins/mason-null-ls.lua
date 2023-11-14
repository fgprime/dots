local M = {}

function M.setup()
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
end

return M
