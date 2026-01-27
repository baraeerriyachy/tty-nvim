require "nvchad.autocmds"

local colorify = require "nvchad.colorify"

colorify.run = function()
  vim.api.nvim_create_autocmd({
    "TextChanged", "TextChangedI", "TextChangedP",
    "VimResized", "LspAttach", "WinScrolled", "BufEnter",
  }, {
    callback = function(args)
      -- Your improved safe check
      if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].bl then
        colorify.attach(args.buf, args.event)
      end
    end,
  })
end
