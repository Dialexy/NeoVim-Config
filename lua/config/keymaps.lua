local map = vim.keymap.set

map("n", "dw", 'vb"_d', { desc = "Delete word backwards" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Splits
map("n", "ss", "<cmd>split<cr>", { desc = "Split below", silent = true })
map("n", "sv", "<cmd>vsplit<cr>", { desc = "Split right", silent = true })
map("n", "sh", "<C-w>h", { desc = "Go to left window" })
map("n", "sj", "<C-w>j", { desc = "Go to lower window" })
map("n", "sk", "<C-w>k", { desc = "Go to upper window" })
map("n", "sl", "<C-w>l", { desc = "Go to right window" })

map("n", "<leader>ai", function()
	Snacks.terminal.toggle("claude --continue 2>/dev/null || claude")
end, { desc = "Toggle Claude Code" })
