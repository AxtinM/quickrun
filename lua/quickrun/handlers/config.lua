local M = {}

local default = {
  style = "popup", -- popup or attached
  position = "bottom", -- based on position & style, differently will use the width and height
  width = 80,
  height = 24,
}

M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", default, options or {}) 
end

return M
