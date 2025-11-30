--- Maximizer keymaps
-- @module maximizer.keymaps

local M = {}

function M.setup_keymaps(opts, toggle_fn)
	vim.keymap.set("n", opts.keymap, toggle_fn, {
		desc = "Maximize/restore window",
		noremap = true,
		silent = true,
	})
end

return M
