local M = {}

function M.GetSelectedText()
  local vis_start, vis_end = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  return vim.fn.getline(vis_start[2], vis_end[2])
end

function M.setupNewBuf(input)
  local new_buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, input)

  vim.cmd("botright split | resize 10")

  vim.api.nvim_buf_set_option(new_buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(new_buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(new_buf, 'modifiable', false)

  vim.api.nvim_win_set_buf(0, new_buf)
end

return M
