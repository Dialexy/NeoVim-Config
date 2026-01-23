return {
	-- messages, cmdline and the popupmenu.
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

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
			terminal = {
				win = {
					position = "float",
					width = 0.9,
					height = 0.9,
					row = 0.05,
					col = 0.075,
					border = "none",
				},
			},
		},
		keys = {
			{
				"<leader>ft",
				function()
					Snacks.terminal.toggle()
				end,
				desc = "Toggle Terminal",
			},
		},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
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

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					-- Wrap entire render in pcall to catch any errors
					local ok, result = pcall(function()
						local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
						if filename == "" then
							filename = "[No Name]"
						end
						if vim.bo[props.buf].modified then
							filename = "[+] " .. filename
						end

						-- Use mini.icons with error handling
						local icon_ok, icon, hl = pcall(MiniIcons.get, "file", filename)
						if not icon_ok or not icon then
							return { { filename } }
						end

						local icon_color = "#c0caf5" -- default color
						if hl then
							local color_ok, color = pcall(vim.fn.synIDattr, vim.fn.hlID(hl), "fg")
							if color_ok and color and color ~= "" then
								icon_color = color
							end
						end

						return { { icon, guifg = icon_color }, { " " }, { filename } }
					end)

					if ok then
						return result
					else
						-- Fallback: just show buffer number on error
						return { { "buf:" .. props.buf } }
					end
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
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
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},

	{
		"folke/snacks.nvim",
		opts = {
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
