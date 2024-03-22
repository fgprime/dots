return {
  -- ✓ Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
  {
    "folke/neodev.nvim",
    commit = "e9bc652", -- 🔐
    -- commit = "8fd2103", -- 🔐
    config = function()
      require("neodev").setup()
    end,
  },
}
