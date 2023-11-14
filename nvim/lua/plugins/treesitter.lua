local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    auto_install = true,
    autotag = {
      enable = true,
      filetypes = {
        "bash",
        "c",
        "cpp",
        "ruby",
        "rust",
        "python",
        "diff",
        "comment",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "php",
        "pug",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "markdown",
        "markdown_inline",
        "yaml",
        "vim",
        "lua",
        "xml",
      },
    },
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = true,
      -- custom_captures = {["new_import"] = "CustomImportName"}
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = true },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<Leader>cx"] = "@parameter.inner" },
        swap_previous = { ["<Leader>cX"] = "@parameter.inner" },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<Leader>df"] = "@function.outer",
          ["<Leader>dF"] = "@class.outer",
        },
      },
    },
    autopairs = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      --      config = {
      --        -- Languages that have a single comment style
      --        typescript = "// %s",
      --        css = "/* %s */",
      --        scss = "/* %s */",
      --        html = "<!-- %s -->",
      --        svelte = "<!-- %s -->",
      --        vue = "<!-- %s -->",
      --        json = "",
      --      },
    },
    -- textsubjects = {
    -- 	enable = true,
    -- 	keymaps = {
    -- 		["<Leader>"] = "textsubjects-smart",
    -- 		["<Leader>"] = "textsubjects-container-outer",
    -- 		["<Leader>"] = "textsubjects-container-inner",
    -- 	},
    -- },
    matchup = { enable = true },
  })
end

return M
