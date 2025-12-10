return {
	"nvim-neo-tree/neo-tree.nvim",
	-- Completely disable the init function that auto-opens on directory
	init = function()
		-- Override with empty function to prevent auto-open
	end,
	-- Disable the default keybindings
	keys = {
		{ "<leader>e", false },
		{ "<leader>E", false },
		{ "<leader>fe", false },
		{ "<leader>fE", false },
	},
}
