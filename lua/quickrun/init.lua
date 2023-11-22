local handlers = require("quickrun.handlers")
local config = require("quickrun.handlers.config")

local M = {}

function M.processTempFile(lines)
  local ext = handlers.language.checkFileLanguage()
  local fileHandler = handlers.helper.createTempFile(lines, ext)

  local file = fileHandler.tmpFile
  local fileName = fileHandler.tmpFileName

  local handle = handlers.language.getFileHandle(fileName)
  local buf = handlers.helper.createBufWindow()
  handlers.helper.writeToBuffer(handle, buf)

  handle:close()
  os.remove(fileName)
end

function M.setup(options)
  config.setup(options)
end

function M.run()
  local lines = handlers.helper.GetSelectedText()
  M.processTempFile(lines)
end

return M
