vim.api.nvim_create_autocmd('VimEnter', {
  callback = function(data)
    local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
    if no_name then
      vim.cmd('Neotree toggle')
    end
  end,
})

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require('config.autosave').setup({
  enabled = true,
  delay = 1000,
})
