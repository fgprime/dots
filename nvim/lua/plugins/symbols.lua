return {

  -- ✓ A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
  {
    "simrat39/symbols-outline.nvim",
    commit = "5127919", -- 🔐
    config = function()
      require("symbols-outline").setup()
    end,
  },
}
