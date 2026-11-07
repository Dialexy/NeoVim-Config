return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave", "QuitPre", "FocusLost" }, {
			pattern = vim.fn.stdpath("data") .. "/leetcode/*",
			command = "silent! update",
		})
	end,
	opts = {
		lang = "python3",
		editor = { reset_previous_code = false },
		hooks = {
			-- description as a swappable buffer in the code window instead of a split
			question_enter = {
				function(q)
					q.description:hide()
					vim.wo[q.winid].winfixbuf = false
					local function swap()
						local desc = q.description.bufnr
						local to_desc = vim.api.nvim_get_current_buf() ~= desc
						vim.api.nvim_win_set_buf(0, to_desc and desc or q.bufnr)
						if to_desc then
							q.description.renderer.winid = vim.api.nvim_get_current_win()
							vim.opt_local.wrap = true
							vim.opt_local.linebreak = true
							vim.opt_local.number = false
							vim.opt_local.relativenumber = false
							vim.opt_local.signcolumn = "no"
						end
					end
					for _, buf in ipairs({ q.bufnr, q.description.bufnr }) do
						vim.keymap.set("n", "<leader>bb", swap, { buffer = buf, desc = "Swap code/description" })
						-- buffer-local, so <leader>l still opens Lazy everywhere else
						vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<cr>", { buffer = buf, desc = "Leet test" })
						vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", { buffer = buf, desc = "Leet submit" })
						-- which-key caches buffer keymaps; without this it still sees <leader>l as just Lazy
						pcall(function() require("which-key.buf").clear({ buf = buf }) end)
					end
				end,
			},
		},
		injector = {
			-- keep typing so List/Optional hints don't trip the LSP
			python3 = { imports = function() return { "from typing import *" } end },
			python = { imports = function() return { "from typing import *" } end },
		},
	},
}
