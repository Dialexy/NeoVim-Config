return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		-- Patch nvim-ts-autotag: newer Neovim returns nil instead of erroring
		-- when no parser exists, so guard against a nil parser after pcall.
		"windwp/nvim-ts-autotag",
		opts = {},
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
			local internal = require("nvim-ts-autotag.internal")
			for _, fn_name in ipairs({ "close_tag", "close_slash_tag", "rename_tag" }) do
				local orig = internal[fn_name]
				internal[fn_name] = function()
					local ok, parser = pcall(vim.treesitter.get_parser)
					if not ok or not parser then
						return
					end
					orig()
				end
			end
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"astro",
				"cmake",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"php",
				"rust",
				"scss",
				"sql",
				"svelte",
			},

			-- matchup = {
			-- 	enable = true,
			-- },

			-- https://github.com/nvim-treesitter/playground#query-linter
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},

			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = true, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")
			TS.setup(opts)

			-- MDX
			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
