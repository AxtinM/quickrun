local helper = require("quickrun.handlers.helpers")
local language = require("quickrun.handlers.language")

function processTempFile(buf)
  local ext = language.checkFileLanguage()
  local tempFileName = os.tmpname() .. "." .. ext
  local tempFile = io.open(tempFileName, "w")

  if tempFile then
    for _, line in ipairs(buf) do
      tempFile:write(line .. "\n")
    end
  end

  -- get output after running the file
  local out = language.runFile(tempFileName)

  helper.setupNewBuf(out)

  tempFile:close()
  os.remove(tempFileName)
end

function main_runner()
  local lines = helper.GetSelectedText()
  processTempFile(lines)
end

-- Map a key in visual mode
vim.api.nvim_set_keymap('x', '<leader>r', ':lua main_runner()<CR>', { noremap = true, silent = true })

-- Map a key in visual line mode
vim.api.nvim_set_keymap('x', '<leader>R', ':lua main_runner()<CR>', { noremap = true, silent = true })
