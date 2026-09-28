return {
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "stylua", "shellcheck", "shfmt" } },
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false }, -- toggle with <leader>uh
			servers = {
				cssls = {},
				html = {},
				yamlls = {
					settings = { yaml = { keyOrdering = false } },
				},
				pyright = {
					-- Use the project's virtualenv when there is one
					before_init = function(_, config)
						local root = config.root_dir or vim.fn.getcwd()
						for _, dir in ipairs({ ".venv", "venv", "env", "../.venv", "../../.venv" }) do
							local python = root .. "/" .. dir .. "/bin/python"
							if vim.fn.executable(python) == 1 then
								config.settings.python = vim.tbl_deep_extend("force", config.settings.python or {}, {
									pythonPath = python,
								})
								return
							end
						end
					end,
				},
				-- ruff for formatting only; pyright handles diagnostics
				ruff = {
					init_options = { settings = { lint = { enable = false } } },
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = { formatters_by_ft = { python = { "ruff_format" } } },
	},

	{
		"mrcjkb/rustaceanvim",
		opts = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						-- Don't run cargo check/clippy on every save; rely on
						-- rust-analyzer's own (incl. experimental) diagnostics instead
						checkOnSave = false,
						diagnostics = { experimental = { enable = true } },
					},
				},
			},
		},
	},
}
