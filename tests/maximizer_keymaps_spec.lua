local keymaps = require("maximizer.keymaps")

describe("maximizer.keymaps", function()
	-- Clean up mappings before each test
	before_each(function()
		pcall(vim.keymap.del, "n", "<Space>m")
		pcall(vim.keymap.del, "n", "<leader>m")
	end)

	-- Helper: Check if a mapping exists using vim.fn.maparg
	-- This is more robust than string comparison of vim.api.nvim_get_keymap
	local function has_map(lhs)
		-- maparg(lhs, mode, abbr, dict)
		-- returns a dictionary containing mapping info if it exists
		local map_info = vim.fn.maparg(lhs, "n", false, true)

		-- Check if map_info is a valid table and has the 'lhs' key
		return map_info and map_info.lhs and #map_info.lhs > 0
	end

	it("should register default keymap <Space>m", function()
		local toggle_fn = function() end
		local opts = { keymap = "<Space>m" }

		keymaps.setup_keymaps(opts, toggle_fn)

		assert.is_true(has_map("<Space>m"), "Default keymap <Space>m should be registered")
	end)

	it("should register custom keymap <leader>m", function()
		local toggle_fn = function() end
		local opts = { keymap = "<leader>m" }

		keymaps.setup_keymaps(opts, toggle_fn)

		assert.is_true(has_map("<leader>m"), "Custom keymap <leader>m should be registered")
	end)
end)
