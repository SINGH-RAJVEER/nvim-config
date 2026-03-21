return {
  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.cursorword').setup()
      require('mini.icons').setup {
        style = 'glyph',
        lsp = {
          Array = { glyph = '' },
          Boolean = { glyph = '' },
          Class = { glyph = '' },
          Color = { glyph = '' },
          Constant = { glyph = '' },
          Constructor = { glyph = '' },
          Enum = { glyph = '' },
          EnumMember = { glyph = '' },
          Event = { glyph = '' },
          Field = { glyph = '' },
          File = { glyph = '' },
          Folder = { glyph = '' },
          Function = { glyph = '' },
          Interface = { glyph = '' },
          Keyword = { glyph = '' },
          Method = { glyph = '' },
          Module = { glyph = '' },
          Namespace = { glyph = '' },
          Null = { glyph = '' },
          Number = { glyph = '' },
          Object = { glyph = '' },
          Operator = { glyph = '' },
          Package = { glyph = '' },
          Property = { glyph = '' },
          Reference = { glyph = '' },
          Snippet = { glyph = '' },
          String = { glyph = '' },
          Struct = { glyph = '' },
          Text = { glyph = '' },
          TypeParameter = { glyph = '' },
          Unit = { glyph = '' },
          Value = { glyph = '' },
          Variable = { glyph = '' },
        },
      }
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
}
