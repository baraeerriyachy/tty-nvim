return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = true, -- This hides all files starting with a dot
      },
    },
  },

  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",  -- optional: lazy load
    config = function()
      require("code_runner").setup {
        before_run_filetype = function()
                vim.cmd("silent! w") -- Saves the file without showing the "written" message
        end,
        filetype = {
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "python3 -u",
          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          sh = "bash",
          lua = "lua",
        },
        mode = "term",        -- use terminal mode (needed for interactive input)
        focus = true,         -- focus the terminal when running
        startinsert = true,   -- ✅ automatically enter insert mode
      }
    end,
  },
  {
    "lambdalisue/vim-suda",
    lazy = false,
    init = function()
      vim.g.suda_smart_edit = 1
    end,
  },
}
