return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          on_new_config = function(config, root_dir)
            -- Auto-detect virtual environment
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

            -- Fallback to system python
            config.settings.python.pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python")
          end,
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
            python = {
              pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python"),
            },
          },
        },
      },
    },
  },
}
