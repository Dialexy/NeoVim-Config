-- Only overrides of LazyVim's defaults live here:
-- https://www.lazyvim.org/configuration/general#options
require("config.remote_clipboard").setup()

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_prettier_needs_config = true
-- Format manually with <leader>cf, or toggle format-on-save with <leader>uf
vim.g.autoformat = false

local opt = vim.opt
opt.title = true
opt.mouse = ""
opt.cmdheight = 0
opt.scrolloff = 10
opt.shiftwidth = 4
opt.tabstop = 4
opt.inccommand = "split"
opt.splitkeep = "cursor"
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
-- Continue comment leaders (e.g. `*` in block comments) on <Enter>
opt.formatoptions:append({ "r" })

vim.filetype.add({
	extension = { mdx = "mdx" },
	filename = { Podfile = "ruby" },
})
