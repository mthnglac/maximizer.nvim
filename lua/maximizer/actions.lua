--- Maximizer actions
-- @module maximizer.actions

local M = {}

function M.maximize()
  if vim.t.maximized then return end

  local win = vim.api.nvim_get_current_win()
  
  -- TÜM pencerelerin boyut düzenini geri getirecek komutu kaydet
  vim.t.restore_cmd = vim.fn.winrestcmd()
  
  vim.t.maximized_win = win
  vim.t.maximized = true

  -- Daha temiz maximize komutları (wincmd _ = yükseklik, wincmd | = genişlik)
  vim.cmd("wincmd _")
  vim.cmd("wincmd |")
end

function M.restore()
  if not vim.t.maximized then return end

  -- Kaydedilen düzen komutunu çalıştır (sessizce ve hata olursa yutarak)
  if vim.t.restore_cmd then
    vim.cmd(vim.t.restore_cmd)
  end

  -- Değişkenleri temizle
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
