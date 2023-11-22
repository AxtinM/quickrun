local config = require("quickrun.handlers.config")
local M = {}

function M.GetSelectedText()
  local vis_start, vis_end = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  return vim.fn.getline(vis_start[2], vis_end[2])
end

function M.getEditorDimensions() 
  local width = vim.api.nvim_get_option('columns')
  local height = vim.api.nvim_get_option('lines')

  return { width = width, height = height }
end

function M.writeToBuffer(handle, new_buf)
 local line = ""
 while true do
   local c = handle:read(1)
   if c == nil then break end
   if c == "\n" then
     vim.api.nvim_buf_set_lines(new_buf, -1, -1, false, {line})
     line = ""
   else
     line = line .. c
   end
 end
end

function M.createBufWindow()
  local new_buf = vim.api.nvim_create_buf(false, true)
  -- set buffer default options 

  vim.api.nvim_buf_set_keymap(new_buf, 'n', 'q', '<Cmd>bdelete!<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_option(new_buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(new_buf, 'bufhidden', 'wipe')

  if config.options.style == "popup" then
    -- get dimensions
    local dimensions = M.getEditorDimensions()
    local win_col = (dimensions.width - config.options.width) / 2
    local win_row = (dimensions.height - config.options.height) / 2

    vim.api.nvim_open_win(new_buf, true, {relative="editor", width=config.options.width, height=config.options.height, col=win_col, row=win_row})

  elseif config.options.style == "attached" then
    if config.options.position == "top" then
      vim.api.nvim_command("topleft split")
      vim.api.nvim_win_set_height(0, config.options.height)

    elseif config.options.position == "bottom" then
      vim.api.nvim_command("botright split")
      vim.api.nvim_win_set_height(0, config.options.height)

    elseif config.options.position == "left" then
      vim.api.nvim_command("topleft vsplit")
      vim.api.nvim_win_set_width(0, config.options.height)

    elseif config.options.position == "right" then
      vim.api.nvim_command("botright vsplit")
      vim.api.nvim_win_set_width(0, config.options.height)
    end
    vim.api.nvim_win_set_buf(0, new_buf)
  else
    error("config style must either be 'popup' or 'attached' !")
  end

  return new_buf
end

function M.createTempFile(lines, ext)
  local tempFileName = os.tmpname() .. "." .. ext
  local tempFile = io.open(tempFileName, "w")

  if tempFile then
    for _, line in ipairs(lines) do
      tempFile:write(line .. "\n")
    end
  end

  return {tmpFile = tempFile, tmpFileName = tempFileName}
end

return M
