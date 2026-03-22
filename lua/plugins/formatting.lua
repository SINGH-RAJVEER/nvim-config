return {
  -- Autoformat
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = function()
      local format_delay = 3000
      local formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        json = { 'biome' },
        jsonc = { 'biome' },
        json5 = { 'biome' },
        css = { 'biome' },
        graphql = { 'biome' },
        rust = { 'rustfmt' },
        java = { 'google-java-format' },
      }

      return {
        notify_on_error = false,
        format_on_save = function()
          return nil
        end,
        formatters_by_ft = formatters_by_ft,
        formatters = {
          ['google-java-format'] = {
            prepend_args = { '--aosp' },
          },
        },
        format_delay = format_delay,
      }
    end,
    config = function(_, opts)
      local conform = require 'conform'
      local group = vim.api.nvim_create_augroup('format-on-idle', { clear = true })
      local timers = {}
      local formatting = {}

      conform.setup(opts)

      local function stop_timer(buf)
        local timer = timers[buf]
        if not timer then
          return
        end

        timer:stop()
        timer:close()
        timers[buf] = nil
      end

      local function can_format(buf)
        if not vim.api.nvim_buf_is_valid(buf) then
          return false
        end

        local bo = vim.bo[buf]
        return opts.formatters_by_ft[bo.filetype] ~= nil and bo.buftype == '' and bo.modifiable and not bo.readonly and bo.modified
      end

      local function format_buffer(buf)
        stop_timer(buf)

        if formatting[buf] or not can_format(buf) then
          return
        end

        formatting[buf] = true

        local ok, err = pcall(conform.format, {
          bufnr = buf,
          async = true,
          lsp_format = 'fallback',
        })

        vim.defer_fn(function()
          formatting[buf] = nil
        end, 1000)

        if not ok then
          formatting[buf] = nil
          vim.schedule(function()
            vim.notify('Format failed: ' .. err, vim.log.levels.WARN)
          end)
        end
      end

      vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        group = group,
        desc = 'Format supported buffers after an idle delay',
        callback = function(args)
          if not can_format(args.buf) then
            return
          end

          stop_timer(args.buf)

          local timer = vim.uv.new_timer()
          timers[args.buf] = timer
          timer:start(
            opts.format_delay,
            0,
            vim.schedule_wrap(function()
              format_buffer(args.buf)
            end)
          )
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufWipeout' }, {
        group = group,
        desc = 'Clean up format timers',
        callback = function(args)
          stop_timer(args.buf)
          formatting[args.buf] = nil
        end,
      })
    end,
  },
}
