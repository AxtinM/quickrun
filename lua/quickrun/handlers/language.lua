local M = {}

SupportedLanguages = {
  -- {name, command, ext}
  PYTHON = {"python", "python", "py"},
  LUA = {"lua", "lua", "lua"},
  JAVASCRIPT = {"javascript", "node", "js"},
  TYPESCRIPT = {"typescript", "node", "ts"},
  RUST = {"rust", "rustc", "rs"},
}


function M.checkFileLanguage()
    local file_ext = vim.fn.expand('%:e')
    for lang, info in pairs(SupportedLanguages) do
      local name, command, ext = unpack(info)
      if file_ext == ext then
          return ext
      end
    end
    return nil
end


function M.runInterpretedLanguageFile(cmd)
  local handle = io.popen(cmd)
  return handle
end

function M.runCompiledLanguageFile(cmd, fileName)
  local handle = io.popen(cmd .. " " .. "./" .. vim.split(fileName, ".")[1])
  return handle
end

function M.getFileHandle(path)
  local cmd, handle

  local ext = M.checkFileLanguage()
  if ext == nil then
    error("This Language is not Supported as of right now !")
  end

  if ext == SupportedLanguages.PYTHON[3] then
    cmd = SupportedLanguages.PYTHON[2] .. " " .. path .. " 2>&1"
    handle = M.runInterpretedLanguageFile(cmd)
  elseif ext == SupportedLanguages.LUA[3] then
    cmd = SupportedLanguages.LUA[2] .. " " .. path .. " 2>&1"
    handle = M.runInterpretedLanguageFile(cmd)
  elseif ext == SupportedLanguages.JAVASCRIPT[3] then
    cmd = SupportedLanguages.JAVASCRIPT[2] .. " " .. path .. " 2>&1"
    handle = M.runInterpretedLanguageFile(cmd)
  elseif ext == SupportedLanguages.TYPESCRIPT[3] then
    cmd = SupportedLanguages.TYPESCRIPT[2] .. " " .. path .. " 2>&1"
    handle = M.runInterpretedLanguageFile(cmd)
  elseif ext == SupportedLanguages.RUST[3] then
    cmd = SupportedLanguages.RUST[2] .. " " .. path .. " 2>&1"
    handle = M.runCompiledLanguageFile(cmd)
  end

  return handle
end

return M
