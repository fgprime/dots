return {
  ---- ✓ Neoscroll: a smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    commit = "d7601c2", -- 🔐
    config = function()
      require("neoscroll").setup()
    end,
  },
}
