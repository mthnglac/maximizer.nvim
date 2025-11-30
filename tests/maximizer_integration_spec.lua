local maximizer = require("maximizer")

describe("maximizer.integration", function()
	before_each(function()
		vim.t.maximized = nil
		vim.cmd("silent! only")
	end)

	it("should setup commands and verify execution via command line", function()
		maximizer.setup()

		-- Create a split to visualize maximization
		vim.cmd("vsplit")
		local start_width = vim.api.nvim_win_get_width(0)

		-- Execute the command: :MaximizeToggle
		vim.cmd("MaximizeToggle")

		-- Check state and verify width changed
		assert.is_true(vim.t.maximized, "State should be maximized after command")
		assert.is_true(vim.api.nvim_win_get_width(0) > start_width, "Window width should increase")

		-- Execute the command again (Restore)
		vim.cmd("MaximizeToggle")

		assert.is_false(vim.t.maximized, "State should be restored")
		assert.are.same(start_width, vim.api.nvim_win_get_width(0), "Width should return to original")
	end)
end)
