return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.api.nvim_exec([[
    set statusline+=%3{codeium#GetStatusString()}
    ]], false)

    vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
}
