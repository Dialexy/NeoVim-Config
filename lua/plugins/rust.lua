return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.rust_analyzer = {
        handlers = {
          ["window/showMessage"] = function() end,
          ["$/progress"] = function() end,
        },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = false,
            diagnostics = {
              enable = true,
              disabled = {},
              experimental = {
                enable = true,
              },
            },
            inlayHints = {
              enable = false,
            },
          },
        },
      }
      return opts
    end,
  },
}
