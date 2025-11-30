--- Maximizer.nvim main module
-- @module maximizer

local actions = require("maximizer.actions")
local keymaps = require("maximizer.keymaps")
local commands = require("maximizer.commands")

local default_opts = {
	keymap = "<Space>m",
	disable_keymaps = false,
}

local M = {}

--- Setup Maximizer.nvim
-- @param opts table|nil Optional table of options:
--   - keymap (string): Keymap to toggle maximize (default: "<Space>m")
--   - disable_keymaps (boolean): If true, built-in keymaps are not set
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", {}, default_opts, opts or {})
	if not opts.disable_keymaps then
		keymaps.setup_keymaps(opts, actions.toggle)
	end
	commands.setup_commands(actions.toggle)
end

--- Toggle manually
-- @return nil
function M.toggle()
	actions.toggle()
end

return M
