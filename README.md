# NeoVim Configuration

NeoVim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin management
- **Colorscheme**: Catppuccin Mocha (Defualt) [can be changed by setting lazy loading priority[
- **LSP Support**: Full Language Server Protocol integration with auto-completion
- **File Navigation**: Neo-tree and Telescope file management
- **Git Integration**: Built-in git commands and visual indicators
- **Syntax Highlighting**: Treesittersyntax highlighting

## Requirements

- NeoVim >= 0.9.0
- Git
- A Nerd Font (for icons)
- ripgrep (for Telescope)
- Node.js (for some LSP servers)

## Installation

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/Dialexy/NeoVim-Config.git ~/.config/nvim
   ```

3. **Launch NeoVim**:
   ```bash
   nvim
   ```
   Plugins will automatically install on first launch.

## Structure

```
.
├── init.lua
├── lazy-lock.json
├── lazyvim.json
├── lua
│   ├── config
│   │  ├── autocmds.lua
│   │  ├── keymaps.lua
│   │  ├── lazy.lua
│   │  └── options.lua
│   ├── craftzdog
│   │   ├── hsl.lua
│   │   └── lsp.lua
│   ├── plugins
│   │   ├── cmake.lua
│   │   ├── coding.lua
│   │   ├── colorscheme.lua
│   │   ├── diagnostics.lua
│   │   ├── editor.lua
│   │   ├── gitsigns.lua
│   │   ├── harpoon.lua
│   │   ├── leetcode.lua
│   │   ├── lsp.lua
│   │   ├── neo-tree.lua
│   │   ├── performance.lua
│   │   ├── python.lua
│   │   ├── rust.lua
│   │   ├── treesitter.lua
│   │   └── ui.lua
│   └── util
│       └── debug.lua
└── README.md
```

## Key Plugins

### Core
- **lazy.nvim** - Plugin manager
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/Linter installer
- **nvim-treesitter** - Syntax highlighting

### UI
- **catppuccin/nvim** - Colorscheme
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Buffer tabs
- **noice.nvim** - Command line UI
- **nvim-notify** - Notifications
- **incline.nvim** - Floating statuslines
- **zen-mode.nvim** - Distraction-free mode

### Editor
- **telescope.nvim** - Fuzzy finder
- **neo-tree.nvim** - File explorer
- **flash.nvim** - Quick navigation
- **nvim-highlight-colors** - Color highlighting
- **git.nvim** - Git integration
- **close-buffers.nvim** - Buffer management

### Coding
- **blink.cmp** - Auto-completion
- **inc-rename.nvim** - LSP rename
- **mini.bracketed** - Bracket navigation
- **dial.nvim** - Enhanced increment/decrement

### LSP & Diagnostics
- **LazyVim-LSP-intergration** - Inline diagnostics
- **render-markdown.nvim** - Markdown rendering

## Key Mappings

Leader key: `Space`

### General
- `x` - Delete without affecting registers
- `<Leader>p` / `<Leader>P` - Paste from yank register
- `<Leader>d` / `<Leader>D` - Delete without affecting registers
- `<Leader>c` / `<Leader>C` - Change without affecting registers
- `+` / `-` - Increment/decrement numbers
- `<C-a>` - Select all
- `dw` - Delete word backwards

### Window Navigation
- Split navigation and resizing keymaps configured

## Configuration Highlights

### Options (lua/config/options.lua)
- **Leader key**: Space
- **Indentation**: 4 spaces 
- **Line numbers**: Enabled
- **Mouse**: Disabled
- **Shell**: zsh
- **Auto-formatting**: Disabled by default (use `<leader>cf` to format manually)

### Colorscheme
- **Active**: Tokyonight
- **Transparent background**: Enabled (for catppuccin)
- **Italic comments**: Enabled

## Customization

### Changing Colorscheme
Edit `lua/plugins/colorscheme.lua` and change the `vim.cmd.colorscheme()` call.

### Modifying Key Mappings
Edit `lua/config/keymaps.lua` to add or modify keybindings.

### Adjusting Options
Edit `lua/config/options.lua` to change vim options like indentation, line numbers, etc.

### Adding Plugins
Create a new file in `lua/plugins/` or add to an existing one following the lazy.nvim format:

```lua
return {
  "username/plugin-name",
  config = function()
    -- Plugin setup
  end,
}
```

## LSP Configuration

LSP servers are managed through Mason. Install servers via `:Mason` command.

Configured language servers and tools are automatically set up through the LSP configuration in `lua/plugins/lsp.lua`.

## Troubleshooting

### Plugins not installing
Run `:Lazy sync` to manually sync plugins.

### LSP not working
1. Check if the language server is installed: `:Mason`
2. Check LSP status: `:LspInfo`

### Performance issues
- Run `:Lazy profile` to identify slow plugins
- Consider disabling unused plugins

## Credits

This configuration is inspired by:
- [craftzdog's dotfiles](https://github.com/craftzdog)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- Various community configurations

## License

Feel free to use and modify this configuration for your own needs.
