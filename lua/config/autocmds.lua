-- LazyVim defaults conceallevel to 2; show raw markup in these formats
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_no_conceal", { clear = true }),
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Autosave modified file buffers when leaving insert mode, after normal-mode
-- edits, and when switching buffers or losing focus
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave", "FocusLost" }, {
	group = vim.api.nvim_create_augroup("user_autosave", { clear = true }),
	nested = true, -- let BufWritePost handlers (linters etc.) run
	callback = function(ev)
		local bo = vim.bo[ev.buf]
		if
			bo.modified
			and bo.modifiable
			and not bo.readonly
			and bo.buftype == ""
			and vim.api.nvim_buf_get_name(ev.buf) ~= ""
		then
			vim.api.nvim_buf_call(ev.buf, function()
				vim.cmd("silent! update")
			end)
		end
	end,
})
