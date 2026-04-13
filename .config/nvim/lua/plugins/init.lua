return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.lspconfig")
      vim.lsp.enable({ "pyright", "jdtls" })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local conf = require("nvchad.configs.cmp")
      local cmp = require("cmp")

      conf.completion = { 
        autocomplete = false,
        completeopt = "menu,menuone,noselect", -- CRITICAL: Don't auto-select the first word
      }

      conf.mapping = vim.tbl_deep_extend("force", conf.mapping, {
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false, -- Only confirm if you actually highlighted a choice
        },
      })

      return conf
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
  {
    "windwp/nvim-ts-autotag",
    ft = { "xml", "html", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pair of tags
          enable_close_on_slash = true, -- Auto close when writing </
        },
      })
    end,
  },
  
}
