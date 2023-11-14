local M = {}

require("plugins.cmp_colors")

function M.setup()
  -- Set up lspconfig.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local installed_servers = require("mason-lspconfig").get_installed_servers()

  for _, servers in ipairs(installed_servers) do
    require("lspconfig")[servers].setup({
      capabilities = capabilities,
    })
  end

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local lspkind = require("lspkind")
  local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  local luasnip = require("luasnip")
  local cmp = require("cmp")
  cmp.setup({
    window = {
      documentation = cmp.config.window.bordered(),
      completion = {
        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -5,
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
        scrolloff = 0,
        side_padding = 1,
        scrollbar = "┃",
      },
    },
    completion = {
      scrollbar = "┃",
      completeopt = "menu,menuone,preview",
      keyword_length = 2,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    " .. (strings[2] or "") .. ""

        return kind
      end,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = {
      { name = "luasnip",                 priority = 4 },
      { name = "path",                    priority = 3 },
      { name = "nvim_lsp",                priority = 3 },
      { name = "buffer",                  priority = 1 },
      { name = "calc",                    priority = 5 },
      { name = "treesitter",              priority = 1 },
      { name = "nvim_lsp_signature_help", priority = 10 },
      -- TODO: Implement conditional rg / not running it on home directory
      -- {
      --   name = "rg",
      --   keyword_length = 3,
      --   priority = 5,
      -- },
    },
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = "buffer" },
    }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
    view = { name = "wildmenu", separator = "|" },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
  -- Might fix autopairs error
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
