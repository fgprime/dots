return {
  -- ✓ Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing a new standard interface for moving around in the visible area in Vim-like modal editors.
  {
    "ggandor/leap.nvim",
    commit = "5efe985", -- 🔐
    config = function()
      vim.keymap.set("n", "s", function()
        local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
          return vim.api.nvim_win_get_config(win).focusable
        end, vim.api.nvim_tabpage_list_wins(0))
        require("leap").leap({ target_windows = focusable_windows_on_tabpage })
      end)
      -- require("leap").add_default_mappings()
    end,
  },
}
