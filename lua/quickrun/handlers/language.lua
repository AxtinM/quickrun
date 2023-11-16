local M = {}

SupportedLanguages = {
  -- {name, command, ext}
  PYTHON = {"python", "python", "py"},
  LUA = {"lua", "lua", "lua"},
  JAVASCRIPT = {"javascript", "node", "js"},
  TYPESCRIPT = {"typescript", "node", "ts"},
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

function M.runFile(path)
  local out, result

  local ext = M.checkFileLanguage()
  if ext == nil then
    error("this language is not supported as of right now !")
  end

  if ext == SupportedLanguages.PYTHON[3] then
    out = io.popen(SupportedLanguages.PYTHON[2] .. " " .. path .. " 2>&1")

  elseif ext == SupportedLanguages.LUA[3] then
    out = io.popen(SupportedLanguages.LUA[2] .. " " .. path .. " 2>&1")
  end

  result = out:read("*a")
  out:close()

  return vim.fn.split(result, "\n")
end

return M

