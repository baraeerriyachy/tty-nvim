vim.api.nvim_create_autocmd("TermRequest", {
  callback = function()
    if string.sub(vim.v.termrequest, 1, 4) == "\x1b]7;" then
      local dir = string.gsub(vim.v.termrequest, "\x1b]7;file://[^/]*", "")
      if vim.fn.isdirectory(dir) == 1 then
        vim.api.nvim_set_current_dir(dir)
      end
    end
  end,
})
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
  }
}
