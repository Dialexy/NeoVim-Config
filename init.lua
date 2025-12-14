if vim.loader then
        vim.loader.enable()
end

-- FORCE ENABLE DIAGNOSTICS IMMEDIATELY
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

_G.dd = function(...)
        require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- Force diagnostics again after lazy loads
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
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
  end,
})
