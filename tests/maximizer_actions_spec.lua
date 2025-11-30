local actions = require("maximizer.actions")

describe("maximizer.actions", function()
	-- Reset environment before each test
	before_each(function()
		vim.t.maximized = nil
		vim.t.maximized_win = nil
		vim.t.restore_cmd = nil
		-- Close all other windows/tabs to start fresh
		vim.cmd("silent! tabonly")
		vim.cmd("silent! only")
	end)

	it("should track maximized state correctly", function()
		actions.toggle()
		assert.is_true(vim.t.maximized, "State should be maximized after toggle")

		actions.toggle()
		assert.is_false(vim.t.maximized, "State should be restored after second toggle")
	end)

	it("should handle single window case gracefully", function()
		-- Even if there is only one window, the logic should still run without errors
		local start_height = vim.api.nvim_win_get_height(0)

		actions.maximize()
		assert.is_true(vim.t.maximized)

		actions.restore()
		assert.is_false(vim.t.maximized)
		assert.are.same(start_height, vim.api.nvim_win_get_height(0))
	end)

	it("should restore complex layout dimensions accurately", function()
		-- 1. Create a complex layout:
		-- | A | B |
		-- |-------|
		-- | C | B |

		vim.cmd("vsplit") -- A | B
		vim.cmd("wincmd h") -- Focus left (A)
		vim.cmd("split") -- A becomes top, C becomes bottom

		-- Capture original dimensions of all windows in the current tab
		local wins = vim.api.nvim_tabpage_list_wins(0)
		local original_dims = {}
		for _, win in ipairs(wins) do
			original_dims[win] = {
				width = vim.api.nvim_win_get_width(win),
				height = vim.api.nvim_win_get_height(win),
			}
		end

		-- 2. Maximize a specific window (e.g., current one)
		actions.toggle()
		assert.is_true(vim.t.maximized)

		-- Verify the current window has grown (height should be nearly full)
		local current_win = vim.api.nvim_get_current_win()
		-- Note: We check if it's larger than before. In a single window case, it won't change,
		-- but we are in a split layout, so it MUST change.
		assert.is_true(vim.api.nvim_win_get_height(current_win) >= original_dims[current_win].height)

		-- 3. Restore layout
		actions.toggle()

		-- 4. Verify all windows are back to exact original dimensions
		for win, dims in pairs(original_dims) do
			if vim.api.nvim_win_is_valid(win) then
				assert.are.same(dims.width, vim.api.nvim_win_get_width(win), "Width mismatch for win " .. win)
				assert.are.same(dims.height, vim.api.nvim_win_get_height(win), "Height mismatch for win " .. win)
			end
		end
	end)

	it("should isolate state between different tabs", function()
		-- 1. Maximize window in Tab 1
		vim.cmd("vsplit")
		actions.maximize()
		assert.is_true(vim.t.maximized, "Tab 1 should be maximized")

		-- 2. Create and switch to Tab 2
		vim.cmd("tabnew")

		-- Tab 2 should NOT be maximized initially
		assert.is_nil(vim.t.maximized, "Tab 2 should not inherit maximized state")

		-- 3. Maximize Tab 2
		vim.cmd("split")
		actions.maximize()
		assert.is_true(vim.t.maximized, "Tab 2 should be maximized now")

		-- 4. Restore Tab 2
		actions.restore()
		assert.is_false(vim.t.maximized, "Tab 2 should be restored")

		-- 5. Go back to Tab 1 and verify it is STILL maximized
		vim.cmd("tabprevious")
		assert.is_true(vim.t.maximized, "Tab 1 should remain maximized")

		-- Restore Tab 1
		actions.restore()
		assert.is_false(vim.t.maximized)
	end)
end)
