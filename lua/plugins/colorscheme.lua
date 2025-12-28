return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night", -- storm, moon, night, or day
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 900,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 800,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = false,
				treesitter = true,
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				telescope = {
					enabled = true,
				},
				which_key = true,
				mason = true,
				noice = true,
				blink_cmp = true,
			},
		},
	},
}
