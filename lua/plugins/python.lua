return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          on_new_config = function(config, root_dir)
            local venv_paths = {
              root_dir .. "/.venv/bin/python",
              root_dir .. "/venv/bin/python",
              root_dir .. "/env/bin/python",
              root_dir .. "/../.venv/bin/python",
              root_dir .. "/../../.venv/bin/python",
            }
            for _, venv_path in ipairs(venv_paths) do
              if vim.fn.executable(venv_path) == 1 then
                config.settings.python.pythonPath = venv_path
                return
              end
            end
            config.settings.python.pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python")
          end,
          settings = {
            python = {
              pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python"),
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        -- ruff-lsp is deprecated; this uses ruff >= 0.4.0's built-in LSP server.
        -- Mason package name: "ruff" (not "ruff-lsp").
        ruff = {
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.diagnosticProvider = false
          end,
          init_options = {
            settings = {
              lint = { enable = false },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
    init = function()
      -- Disable LazyVim's auto-format-on-save for Python buffers.
      -- <leader>cf still works because LazyVim calls format({ force = true }).
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.b.autoformat = false
        end,
      })
    end,
  },
}
