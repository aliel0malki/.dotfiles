return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.opt.laststatus = 2 -- Or 3 for global statusline
    vim.opt.statusline = " %t %m %= %l:%c %3{codeium#GetStatusString()} "

    require("rose-pine").setup({
      highlight_groups = {
        StatusLine = { fg = "love", bg = "foam", blend = 1 },
        StatusLineNC = { fg = "subtle", bg = "surface" },
      },
    })

    vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
}
