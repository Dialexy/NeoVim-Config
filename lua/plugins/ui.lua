-- Snacks centres floats over the whole screen (statusline included) and puts
-- odd leftover cells on one side; centre over the editor area with equal margins
local function terminal_dim()
	local tabline = (vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)) and 1 or 0
	local rows = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0) - tabline
	local cols = vim.o.columns
	-- outer size (border included), shrunk by 1 if needed so the leftover splits evenly
	local h = math.floor(rows * 0.9)
	h = h - (rows - h) % 2
	local w = math.floor(cols * 0.9)
	w = w - (cols - w) % 2
	return { height = h - 2, width = w - 2, row = tabline + (rows - h) / 2, col = (cols - w) / 2 }
end

return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			table.insert(opts.routes, {
				filter = { event = "lsp", kind = "progress" },
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			opts.presets.lsp_doc_border = true
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			-- keep showing the file while the floating terminal has focus
			opts.options.ignore_focus = { "snacks_terminal" }
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					afilename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	{
		"folke/snacks.nvim",
		opts = {
			scroll = { enabled = false },
			terminal = {
				win = {
					position = "float",
					width = function()
						return terminal_dim().width
					end,
					height = function()
						return terminal_dim().height
					end,
					row = function()
						return terminal_dim().row
					end,
					col = function()
						return terminal_dim().col
					end,
					border = "rounded",
					-- with laststatus=3 the focused float's statusline is drawn, so reuse
					-- the previous window's (see lualine's ignore_focus)
					wo = { statusline = "%{%getwinvar(winnr('#'), '&statusline')%}" },
				},
			},
			dashboard = {
				preset = {
					header = [[
⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⡿⠿⣿⣿⢛⣻⡄⠀⢀⣤⣀⠀⠀⠀⠀
⠀⠀⢀⣤⣤⣀⠘⠿⠀⢻⣿⠈⠋⠁⠀⠛⠛⢿⡷⠀⠀⠀
⠀⠀⢿⣿⡉⠉⠁⠀⠀⢸⣿⡇⠀⠀⠀⢀⣰⣟⣁⣴⣶⣦
⢠⣤⣀⣙⣷⣦⣤⣤⠶⠶⣿⣿⠛⠛⠉⠉⠙⠿⣦⡈⠉⠁
⠙⠿⠋⢉⣾⠋⠀⠀⠀⠀⢻⣿⡆⠀⠀⠀⣤⣤⣿⣿⠀⠀
⠀⠀⠀⢿⣿⣦⣼⠃⠀⠀⢸⣿⣿⡀⠀⠀⠀⠉⠉⠁⠀⠀
⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⢸⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⡇⠀⠀⠀⠀⠀⠀
        ]],
					keys = {},
				},
				sections = {
					{ section = "header" },
				},
			},
		},
	},
}
