return {
	{
		"nyoom-engineering/oxocarbon.nvim",
		build = false, -- repo ships compiled Lua; its luarocks/fennel build fails
		lazy = false,
		priority = 1000,
		config = function()
			local function set_transparency()
				-- nvim_set_hl replaces the whole group, so keep the existing fg etc.
				for _, group in ipairs({
					"Normal",
					"NormalFloat",
					"NormalNC",
					"LineNr",
					"CursorLineNr",
					"SignColumn",
					"FoldColumn",
				}) do
					local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
					hl.bg = nil
					vim.api.nvim_set_hl(0, group, hl)
				end
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "oxocarbon",
				callback = set_transparency,
			})
		end,
	},

	-- Alternative, selectable with <leader>uC
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
		},
	},
}
