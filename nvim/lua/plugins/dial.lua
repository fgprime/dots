return {
  {
    "monaqa/dial.nvim",
    -- lazy = true,
    -- keys = {
    --   { "<C-a>",  desc = "increment in normal" },
    --   { "<C-x>",  desc = "decretment in normal" },
    --   { "g<C-a>", desc = "increment in gnormal" },
    --   { "g<C-x>", desc = "decrement in gnormal" },
    --   { "<C-a>",  desc = "increment in visual",  mode = "v" },
    --   { "<C-x>",  desc = "increment in visual",  mode = "v" },
    --   { "g<C-a>", desc = "increment in gvisual", mode = "v" },
    --   { "g<C-x>", desc = "decrement in gvisual", mode = "v" },
    -- },
    config = function()
      local augend = require("dial.augend")


      require("dial.config").augends:register_group {
        default = {

          -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
          augend.constant.new {
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
          augend.constant.alias.de_weekday,
          augend.constant.alias.de_weekday_full,
          augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool,    -- boolean value (true <-> false)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.date.alias["%d.%m.%Y"], -- date (02/19/2022, etc.)
          augend.date.alias["%d.%m.%y"],
          augend.date.alias["%d/%m/%Y"],
          augend.date.alias["%d-%m-%y"],
        },
      }

      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  },
}
