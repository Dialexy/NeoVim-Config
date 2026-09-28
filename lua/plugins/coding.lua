return {
	-- Go forward/backward with square brackets
	{
		"nvim-mini/mini.bracketed",
		event = "BufReadPost",
		opts = {
			file = { suffix = "" },
			window = { suffix = "" },
			quickfix = { suffix = "" },
			yank = { suffix = "" },
			treesitter = { suffix = "n" },
		},
	},

	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "enter",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			completion = {
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},
			signature = { enabled = true },
		},
	},
}
