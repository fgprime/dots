return {
  -- ✓ A high-performance color highlighter for Neovim
  -- Alternative uga-rosa / ccc.nvim
  {
    "NvChad/nvim-colorizer.lua",
    commit = "dde3084", -- 🔐
    config = function()
      require("colorizer").setup()
    end,
  },
}
