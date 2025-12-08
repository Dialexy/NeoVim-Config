-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        command = "set nopaste",
})

-- Disable the concealing in some file formats
vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "jsonc", "markdown" },
        callback = function()
                vim.opt.conceallevel = 0
        end,
})

-- Ensure diagnostics are configured after LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then
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
                                float = {
                                        border = "rounded",
                                        source = "always",
                                },
                        })
                end
        end,
})
