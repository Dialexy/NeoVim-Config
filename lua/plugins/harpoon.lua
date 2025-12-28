return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("harpoon"):setup()
	end,

	keys = {

		{
			"<leader>a",
			function()
				require("harpoon"):list():append()
			end,
			desc = "Harpoon: add file",
		},

		{
			"<leader>A",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon: quick menu",
		},

		{
			"<C-d>",
			function()
				require("harpoon"):list():remove()
			end,
			desc = "Harpoon: remove current file",
		},

		{
			"<C-n>",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Harpoon: next file",
		},

		{
			"<C-p>",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Harpoon: previous file",
		},

		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Harpoon: file 1",
		},

		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Harpoon: file 2",
		},

		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Harpoon: file 3",
		},

		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Harpoon: file 4",
		},

		{
			"<leader>5",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "Harpoon: file 5",
		},
	},
}
