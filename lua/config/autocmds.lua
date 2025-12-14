-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Timer-based autosave (saves every 2 seconds when buffer is modified)
local autosave_timer = vim.loop.new_timer()
autosave_timer:start(
	2000,
	2000,
	vim.schedule_wrap(function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			-- Check if buffer is loaded, modified, has a name, and is not readonly
			if
				vim.api.nvim_buf_is_loaded(buf)
				and vim.api.nvim_buf_get_option(buf, "modified")
				and vim.api.nvim_buf_get_name(buf) ~= ""
				and not vim.api.nvim_buf_get_option(buf, "readonly")
				and vim.api.nvim_buf_get_option(buf, "buftype") == ""
			then
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent! write")
				end)
			end
		end
	end)
)

-- Ensure diagnostics are enabled when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Force enable diagnostics
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end
  end,
})
