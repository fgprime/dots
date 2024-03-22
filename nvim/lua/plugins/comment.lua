return {
  -- ✓ Smart and Powerful commenting plugin for neovim / old Alternative use({ "tpope/vim-commentary" })
  {
    "numToStr/Comment.nvim",
    commit = "0236521", -- 🔐,
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- event = "VeryLazy",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    -- opts = {
    --   pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    -- },
    -- config = function()
    -- 	require("Comment").setup({
    -- 		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    -- 	})
    -- end,
  },

  -- ✓ todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
  {
    "folke/todo-comments.nvim",
    commit = "09b0b17", -- 🔐
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
}
