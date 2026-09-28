# NeoVim Configuration

A [LazyVim](https://www.lazyvim.org/)-based Neovim config. LazyVim supplies the defaults; this repo only holds overrides.

## Requirements

- Neovim >= 0.11.2
- Git, a C compiler, `tree-sitter` CLI, `rg`, `fd`
- A Nerd Font
- Node.js (web language servers), a JDK (Java), `rust-analyzer` (Rust)

## Installation

```bash
mv ~/.config/nvim ~/.config/nvim.backup   # if you have an existing config
git clone https://github.com/Dialexy/NeoVim-Config.git ~/.config/nvim
nvim
```

Plugins, treesitter parsers and Mason tools install on first launch.

## Structure

```
.
├── init.lua              # Entry point
├── lazyvim.json          # Enabled LazyVim extras (manage with :LazyExtras)
├── lazy-lock.json        # Plugin version lock file
└── lua/
    ├── config/
    │   ├── autocmds.lua          # Autosave, conceal overrides
    │   ├── keymaps.lua           # Personal keymaps
    │   ├── lazy.lua              # lazy.nvim bootstrap
    │   ├── options.lua           # Overrides of LazyVim's options
    │   └── remote_clipboard.lua  # OSC 52 clipboard over SSH/tmux
    ├── plugins/
    │   ├── coding.lua        # blink.cmp, mini.bracketed
    │   ├── colorscheme.lua   # Oxocarbon (transparent), Catppuccin
    │   ├── editor.lua        # Telescope + file browser, highlight-colors, close-buffers
    │   ├── gitsigns.lua
    │   ├── leetcode.lua      # :Leet
    │   ├── lsp.lua           # Extra servers, pyright venv detection, ruff formatting, rust-analyzer
    │   ├── performance.lua
    │   ├── treesitter.lua    # Extra parsers
    │   └── ui.lua            # noice, snacks, bufferline, incline, lualine
    └── util/
        └── debug.lua         # dd() debug helper
```

## Languages

Enabled via LazyVim extras: C/C++ (clangd), CMake, Java (jdtls), Python (pyright + ruff formatting), Rust (rustaceanvim), TypeScript, JSON, TOML, Tailwind, Markdown, plus ESLint and Prettier.

## Key Mappings

Leader is `Space`. Everything from [LazyVim's keymaps](https://www.lazyvim.org/keymaps) applies, plus:

| Key | Action |
|-----|--------|
| `<C-a>` | Select all |
| `dw` | Delete word backwards |
| `ss` / `sv` | Split below / right |
| `sh` `sj` `sk` `sl` | Move between windows |
| `sf` | File browser in the current buffer's directory |
| `;f` / `;r` | Find files / live grep (includes hidden files) |
| `;;` | Resume last picker |
| `;e` / `;s` / `;c` / `;t` | Diagnostics / treesitter symbols / incoming calls / help |
| `\\` | Buffers |
| `<Tab>` / `<S-Tab>` | Next / previous tab |
| `<leader>th` / `<leader>tu` | Close hidden / nameless buffers |
| `<leader>ft` | Floating terminal |
| `<leader>ai` | Toggle Claude Code (double `<Esc>` leaves terminal mode) |

## Notes

- Format-on-save is off; format with `<leader>cf` or toggle with `<leader>uf`.
- Inlay hints are off; toggle with `<leader>uh`.
- Modified buffers autosave on leaving insert mode, after normal-mode edits, and on buffer switch/focus loss.
- Mouse is disabled.
- Switch colorscheme with `<leader>uC`.

## Credits

Originally based on [craftzdog's dotfiles](https://github.com/craftzdog) and built on [LazyVim](https://github.com/LazyVim/LazyVim).
