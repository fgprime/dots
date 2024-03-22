return {
  -- {{{ Telescope
  -- ✓ An implementation of the Popup API from vim in Neovim.
  {
    "nvim-lua/popup.nvim",
    commit = "b7404d3", -- 🔐
  },

  --- ✓ telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- 🔐
    config = function()
      local function getGrepArguments()
        -- {{{ Follow symbolic links for grep
        local telescopeConfig = require("telescope.config")
        -- Get the default Telescope configuration
        table.unpack = table.unpack or unpack -- 5.1 compatibility
        local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }

        -- Search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")

        -- Follow symbolic links
        table.insert(vimgrep_arguments, "--follow")
        local IGNORE_GLOBS = {
          ".git",
          ".svn",
          "node_modules",
        }
        local GLOB_TEXT = "!{" .. table.concat(IGNORE_GLOBS, ",") .. "}"

        -- Ignore specific directories
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, GLOB_TEXT)
        -- }}} Follow symbolic links for grep
        return ""
      end

      -- {{{ Follow symbolic links for grep
      local telescopeConfig = require("telescope.config")
      -- Get the default Telescope configuration
      table.unpack = table.unpack or unpack -- 5.1 compatibility
      local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }

      -- Search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")

      -- Follow symbolic links
      table.insert(vimgrep_arguments, "--follow")
      local IGNORE_GLOBS = {
        ".git",
        ".svn",
        "node_modules",
      }
      local GLOB_TEXT = "!{" .. table.concat(IGNORE_GLOBS, ",") .. "}"

      -- Ignore specific directories
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, GLOB_TEXT)
      -- }}} Follow symbolic links for grep

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-h>"] = "which_key",
            },
          },
        },
        pickers = {
          find_files = {
            -- follow symlinks
            follow = true,
            -- show hidden files
            hidden = true,
            file_ignore_patterns = { ".git/", ".undo/" },
          },
          live_grep = {

            vimgrep_arguments = vimgrep_arguments,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,               -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case",   -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        -- vimgrep_arguments = GREP_COMMAND,
        follow = true,
      })
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("repo")
      require("telescope").load_extension("neoclip")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("harpoon")
    end,
  },

  -- ✓ fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- commit = "fab3e22", -- 🔐
    build = "make",
  },

  -- ✓ An extension for telescope.nvim that searches the filesystem for git repositories.
  {
    "cljoly/telescope-repo.nvim",
    commit = "d069994", -- 🔐
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    commit = "6eb6bb4", -- 🔐
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "ThePrimeagen/harpoon",
    commit = "c1aebba", -- 🔐
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- }}} Telescope
}
