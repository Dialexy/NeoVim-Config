-- Optimized diagnostic configuration
-- Keeps it working without the aggressive re-triggering

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure diagnostics config is properly set in opts
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = true,
      })
      return opts
    end,
  },
}
