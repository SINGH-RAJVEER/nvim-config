return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'c', 'css', 'diff', 'html', 'java', 'javascript', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'regex', 'rust', 'tsx', 'typescript', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
