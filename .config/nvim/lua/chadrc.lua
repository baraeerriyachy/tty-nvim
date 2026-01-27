local M = {}

-- Move theme to base46
M.base46 = {
  theme = "onedark",
}

-- Statusline must remain under ui
M.ui = {
  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = {
      -- This removes the [x] buttons from the right side
      btns = function()
        return ""
      end,
    },
  },
  statusline = {
    modules = {
      -- 1. Separate dot function
      dot = function()
        -- Only returns the yellow dot if the buffer is modified
        return vim.bo.modified and "%#St_LspWarning# " or ""
      end,

      -- 2. Your custom cursor logic
      custom_cursor = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        
        -- Safety check for empty buffers
        if total_lines == 0 then total_lines = 1 end

        local chars = { "  ", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        
        -- Ensure index is valid (1-9)
        index = math.max(1, math.min(index, #chars))
        
        local percentage = string.format("%d%%%%", math.ceil(line_ratio * 100))
        local progress_bar = chars[index]

        return "%#St_pos_sep#" .. "%#St_pos_icon# " .. "%#St_pos_text# " .. progress_bar .. " " .. percentage .. " %l:%c "
      end,
    },

    order = {
      "mode",
      "file",
      "dot",               -- Dot placed right after file
      "git",
      "%=",               -- Push to the right
      "lsp_msg",
      "diagnostics",
      "lsp",
      "cwd",
      "custom_cursor",    -- Our combined pill with half-circle
    },
  },
}

return M
