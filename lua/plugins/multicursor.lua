return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()
		local set = vim.keymap.set

		-- <C-v> block select, then I/A types on every line live
		set("x", "I", mc.insertVisual, { desc = "Multicursor insert" })
		set("x", "A", mc.appendVisual, { desc = "Multicursor append" })

		set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor at next match" })
		set({ "n", "x" }, "<C-p>", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })

		mc.addKeymapLayer(function(layer_set)
			layer_set("n", "<Esc>", mc.clearCursors)
		end)
	end,
}
