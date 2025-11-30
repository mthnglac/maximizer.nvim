--- Maximizer commands
-- @module maximizer.commands

local M = {}

function M.setup_commands(toggle_fn)
	vim.api.nvim_create_user_command("MaximizeToggle", toggle_fn, {})
end

return M
