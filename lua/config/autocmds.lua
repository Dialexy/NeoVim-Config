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

-- Mouse stays off (options.lua) except in terminals, so the wheel scrolls
-- scrollback instead of kitty sending it to the shell as arrow keys
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TermOpen" }, {
	group = vim.api.nvim_create_augroup("user_terminal_mouse", { clear = true }),
	callback = function()
		vim.o.mouse = vim.bo.buftype == "terminal" and "a" or ""
	end,
})
