local state_file = vim.fn.stdpath("state") .. "/last_colorscheme"

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				vim.api.nvim_create_autocmd("ColorScheme", {
					group = vim.api.nvim_create_augroup("user_colorscheme", { clear = true }),
					callback = function(ev)
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
						pcall(vim.fn.writefile, { ev.match }, state_file)
					end,
				})

				local ok, lines = pcall(vim.fn.readfile, state_file)
				if not (ok and lines[1] and pcall(vim.cmd.colorscheme, lines[1])) then
					vim.cmd.colorscheme("oxocarbon")
				end
			end,
		},
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		build = false, -- repo ships compiled Lua; its luarocks/fennel build fails
		lazy = false,
		priority = 1000,
	},

	-- Port of the VSCode Ayu theme; pick "ayu-dark" with <leader>uC
	{ "Shatur/neovim-ayu", lazy = true },

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
