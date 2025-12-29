return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 900,
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
		priority = 800,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("oxocarbon")

			local function set_transparency()
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

                vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
                vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
                vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
                vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
			end

			set_transparency()

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "oxocarbon",
				callback = set_transparency,
			})
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
