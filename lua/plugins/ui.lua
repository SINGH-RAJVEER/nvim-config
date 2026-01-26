return {
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'hard',
      }
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- Noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset theme here, or create your own theme using colors from your colorscheme
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` view
      "rcarriga/nvim-notify",
    }
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        highlight = {
          'RainbowRed',
          'RainbowYellow',
          'RainbowBlue',
          'RainbowOrange',
          'RainbowGreen',
          'RainbowViolet',
          'RainbowCyan',
        },
      },
    },
    config = function(_, opts)
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the connection
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#fb4934' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#fabd2f' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#83a598' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#fe8019' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#b8bb26' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#d3869b' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#8ec07c' })
      end)
      require('ibl').setup(opts)
    end,
  },
}
