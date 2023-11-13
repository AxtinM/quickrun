local handlers = require("quickrun.handlers")

local M = {}

function M.processTempFile(buf)
  local ext = handlers.language.checkFileLanguage()
  local tempFileName = os.tmpname() .. "." .. ext
  local tempFile = io.open(tempFileName, "w")

  if tempFile then
    for _, line in ipairs(buf) do
      tempFile:write(line .. "\n")
    end
  end

  -- get output after running the file
  local out = handlers.language.runFile(tempFileName)

  handlers.helper.setupNewBuf(out)

  tempFile:close()
  os.remove(tempFileName)
end

function M.run()
  local lines = handlers.helper.GetSelectedText()
  M.processTempFile(lines)
end

function M.setup()
  -- Map a key in visual mode
  vim.api.nvim_set_keymap('x', '<leader>r', ':lua quickrun.run()<CR>', { noremap = true, silent = true })
  -- Map a key in visual line mode
  vim.api.nvim_set_keymap('x', '<leader>R', ':lua quickrun.run()<CR>', { noremap = true, silent = true })
end

return M
