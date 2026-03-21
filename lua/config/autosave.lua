local M = {}

local group = vim.api.nvim_create_augroup('vscode-like-autosave', { clear = true })
local timers = {}
local writing = {}

M.config = {
  enabled = true,
  delay = 1000,
}

local function stop_timer(buf)
  local timer = timers[buf]
  if not timer then
    return
  end

  timer:stop()
  timer:close()
  timers[buf] = nil
end

local function can_autosave(buf)
  if not M.config.enabled then
    return false
  end

  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  if writing[buf] then
    return false
  end

  local bo = vim.bo[buf]
  if bo.buftype ~= '' or not bo.modifiable or bo.readonly or not bo.modified then
    return false
  end

  return vim.api.nvim_buf_get_name(buf) ~= ''
end

local function write_buffer(buf)
  stop_timer(buf)

  if not can_autosave(buf) then
    return
  end

  writing[buf] = true

  local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
    vim.cmd('silent update')
  end)

  writing[buf] = nil

  if not ok then
    vim.schedule(function()
      vim.notify('Autosave failed: ' .. err, vim.log.levels.WARN)
    end)
  end
end

local function schedule_autosave(buf)
  stop_timer(buf)

  if not can_autosave(buf) then
    return
  end

  local timer = vim.uv.new_timer()
  timers[buf] = timer

  timer:start(
    M.config.delay,
    0,
    vim.schedule_wrap(function()
      write_buffer(buf)
    end)
  )
end

function M.enable()
  M.config.enabled = true
end

function M.disable()
  M.config.enabled = false

  for buf, _ in pairs(timers) do
    stop_timer(buf)
  end
end

function M.toggle()
  if M.config.enabled then
    M.disable()
    vim.notify('Autosave disabled')
    return
  end

  M.enable()
  vim.notify('Autosave enabled')
end

function M.setup(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})

  vim.api.nvim_create_user_command('AutosaveToggle', function()
    M.toggle()
  end, { desc = 'Toggle autosave' })

  vim.api.nvim_create_user_command('AutosaveOn', function()
    M.enable()
  end, { desc = 'Enable autosave' })

  vim.api.nvim_create_user_command('AutosaveOff', function()
    M.disable()
  end, { desc = 'Disable autosave' })

  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = group,
    desc = 'Autosave after a short delay',
    callback = function(args)
      schedule_autosave(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
    group = group,
    desc = 'Autosave when leaving a buffer or window',
    callback = function(args)
      write_buffer(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufWipeout' }, {
    group = group,
    desc = 'Clean up autosave timers',
    callback = function(args)
      stop_timer(args.buf)
      writing[args.buf] = nil
    end,
  })
end

return M
