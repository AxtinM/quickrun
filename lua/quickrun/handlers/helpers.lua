local M = {}

function M.GetSelectedText()
  local vis_start, vis_end = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  return vim.fn.getline(vis_start[2], vis_end[2])
end

function M.setupNewBuf(input)
  local new_buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, input)

  vim.api.nvim_buf_set_keymap(new_buf, 'n', 'q', '<Cmd>bdelete!<CR>', { noremap = true, silent = true })

  -- Open the buffer in a new split
  vim.cmd("botright split | resize 20")


  vim.api.nvim_buf_set_option(new_buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(new_buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(new_buf, 'modifiable', false)

  vim.api.nvim_win_set_buf(0, new_buf)

end

return M
