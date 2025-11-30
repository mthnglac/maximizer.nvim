--- Maximizer actions
-- @module maximizer.actions

local M = {}

function M.maximize()
  if vim.t.maximized then return end

  local win = vim.api.nvim_get_current_win()
  
  -- Save the command to restore all window layouts
  vim.t.restore_cmd = vim.fn.winrestcmd()
  
  vim.t.maximized_win = win
  vim.t.maximized = true

  -- Cleaner maximize commands (wincmd _ = height, wincmd | = width)
  vim.cmd("wincmd _")
  vim.cmd("wincmd |")
end

function M.restore()
  if not vim.t.maximized then return end

  -- Run the saved layout restore command (silently, swallowing errors)
  if vim.t.restore_cmd then
    vim.cmd(vim.t.restore_cmd)
  end

  -- Clear variables
  vim.t.restore_cmd = nil
  vim.t.maximized = false
  vim.t.maximized_win = nil
end

function M.toggle()
  if vim.t.maximized then
    M.restore()
  else
    M.maximize()
  end
end

return M
