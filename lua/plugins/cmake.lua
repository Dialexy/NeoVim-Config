return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    ft = { "c", "cpp", "cmake" },
    opts = {
      cmake_command = "cmake",
      cmake_build_directory = "build/${variant:buildType}",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_show_console = "always",
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 },
      },
    },
    config = function(_, opts)
      require("cmake-tools").setup(opts)
      
      -- Set up keymaps
      local keymap = vim.keymap.set
      keymap("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
      keymap("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
      keymap("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
      keymap("n", "<leader>cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
      keymap("n", "<leader>cy", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
      keymap("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Target" })
      keymap("n", "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select Launch Target" })
      keymap("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = {},
      },
    },
  },
}
