return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    build = ':UpdateRemotePlugins',
    init = function()
      -- Output display
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_output_win_max_height = 20

      -- Image rendering (set to "image.nvim" if you install image.nvim later)
      vim.g.molten_image_provider = 'none'

      -- Save outputs into the .ipynb on write
      vim.g.molten_auto_save_state = true

      -- Use a floating window for output instead of a split
      vim.g.molten_output_win_style = false
    end,
    keys = {
      { '<leader>ji', ':MoltenInit<CR>',                   silent = true, desc = 'Jupyter: init kernel' },
      { '<leader>je', ':MoltenEvaluateOperator<CR>',        silent = true, desc = 'Jupyter: evaluate operator' },
      { '<leader>jl', ':MoltenEvaluateLine<CR>',            silent = true, desc = 'Jupyter: evaluate line' },
      { '<leader>jc', ':MoltenReevaluateCell<CR>',          silent = true, desc = 'Jupyter: re-evaluate cell' },
      { '<leader>jd', ':MoltenDelete<CR>',                  silent = true, desc = 'Jupyter: delete cell' },
      { '<leader>jo', ':MoltenShowOutput<CR>',              silent = true, desc = 'Jupyter: show output' },
      { '<leader>jh', ':MoltenHideOutput<CR>',              silent = true, desc = 'Jupyter: hide output' },
      { '<leader>jr', ':MoltenRestart!<CR>',                silent = true, desc = 'Jupyter: restart kernel' },
      { '<leader>jx', ':MoltenInterrupt<CR>',               silent = true, desc = 'Jupyter: interrupt kernel' },
      { '<leader>jv', ':<C-u>MoltenEvaluateVisual<CR>gv',   silent = true, mode = 'v', desc = 'Jupyter: evaluate selection' },
    },
    config = function()
      -- Auto-init and import outputs when opening .ipynb files
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '*.ipynb',
        callback = function()
          -- Detect the kernel from the notebook metadata
          local ok, lines = pcall(vim.fn.readfile, vim.fn.expand '%')
          if not ok then return end
          local content = table.concat(lines, '\n')
          local kernel = content:match('"name"%s*:%s*"([^"]+)"')
          if kernel then
            vim.cmd('MoltenInit ' .. kernel)
          else
            vim.cmd 'MoltenInit'
          end
          -- Import existing cell outputs
          vim.cmd 'MoltenImportOutput'
        end,
      })

      -- Export outputs back to .ipynb on save
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*.ipynb',
        callback = function()
          if vim.fn.exists ':MoltenExportOutput' == 2 then
            vim.cmd 'MoltenExportOutput!'
          end
        end,
      })
    end,
  },
}
