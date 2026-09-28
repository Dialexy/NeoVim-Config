return {
	{ "folke/flash.nvim", enabled = false },

	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "background",
			enable_hsl_without_function = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_tailwind = true,
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
			{
				";f",
				function()
					require("telescope.builtin").find_files({ hidden = true })
				end,
				desc = "Find files (cwd, respects .gitignore)",
			},
			{
				";r",
				function()
					require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
				end,
				desc = "Live grep (cwd)",
			},
			{ "\\\\", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ ";t", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ ";;", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
			{ ";e", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ ";s", "<cmd>Telescope treesitter<cr>", desc = "Treesitter symbols" },
			{ ";c", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "LSP incoming calls" },
			{
				"sf",
				function()
					require("telescope").extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = vim.fn.expand("%:p:h"),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = true,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "File browser (current buffer's dir)",
			},
		},
		opts = function(_, opts)
			local actions = require("telescope.actions")
			local fb_actions = require("telescope._extensions.file_browser.actions")

			local function move(action, n)
				return function(prompt_bufnr)
					for _ = 1, n do
						action(prompt_bufnr)
					end
				end
			end

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			})
			opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = { preview_cutoff = 9999 },
				},
			})
			opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
				file_browser = {
					theme = "dropdown",
					hijack_netrw = true,
					mappings = {
						n = {
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = move(actions.move_selection_previous, 10),
							["<C-d>"] = move(actions.move_selection_next, 10),
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			})
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("file_browser")
		end,
	},

	{
		"kazhala/close-buffers.nvim",
		keys = {
			{
				"<leader>th",
				function()
					require("close_buffers").delete({ type = "hidden" })
				end,
				desc = "Close hidden buffers",
			},
			{
				"<leader>tu",
				function()
					require("close_buffers").delete({ type = "nameless" })
				end,
				desc = "Close nameless buffers",
			},
		},
	},
}
