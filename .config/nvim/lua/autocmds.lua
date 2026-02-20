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

vim.api.nvim_create_autocmd("TermRequest", {
  callback = function()
    -- This hears the "OSC 7" message from Bash
    if string.sub(vim.v.termrequest, 1, 4) == "\x1b]7;" then
      local dir = string.gsub(vim.v.termrequest, "\x1b]7;file://[^/]*", "")
      if vim.fn.isdirectory(dir) == 1 then
        vim.api.nvim_set_current_dir(dir)
      end
    end
  end,

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TermOpen", {
  group = augroup("CodeRunnerNumbers", { clear = true }),
  callback = function()
    -- Force these settings on a delay to beat NvChad's defaults
    vim.schedule(function()
      vim.opt_local.number = true
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "yes"
      vim.opt_local.statuscolumn = "" -- NvChad sometimes uses this to hide numbers
    end)
  end,
})
})
