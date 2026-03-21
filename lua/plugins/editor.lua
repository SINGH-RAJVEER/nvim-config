return {
  -- Incremental rename
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
    end,
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        indent = {
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          indent_size = 2,
          padding = 1,
        },
        default_component_configs = {
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '󰜌',
            folder_empty_open = '󰜌',
          },
          git_status = {
            symbols = {
              added = '✚',
              modified = '',
              deleted = '✖',
              renamed = '➜',
              untracked = '★',
              ignored = '◌',
              staged = '✓',
              conflict = '',
            },
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      }
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  },
}
