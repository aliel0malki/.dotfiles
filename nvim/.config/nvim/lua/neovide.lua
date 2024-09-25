if vim.g.neovide then
  -- Set the scaling factor for Neovide
  vim.g.neovide_scale_factor = 1.6

  -- Function to dynamically change the scaling factor
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Key mappings for scaling up and down using Ctrl + = and Ctrl + -
  vim.keymap.set('n', '<C-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1 / 1.25)
  end)

  -- Key mapping for saving with Ctrl + s
  vim.keymap.set('n', '<C-s>', ':w<CR>')

  -- Key mappings for clipboard copy-paste operations
  vim.keymap.set('v', '<C-c>', '"+y') -- Copy in visual mode
  vim.keymap.set('n', '<C-v>', '"+P') -- Paste in normal mode
  vim.keymap.set('v', '<C-v>', '"+P') -- Paste in visual mode
  vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste in command mode
  vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste in insert mode

  -- Allow clipboard copy-paste in Neovim across different modes
  vim.api.nvim_set_keymap(
    '',
    '<C-v>',
    '+p<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    '!',
    '<C-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    't',
    '<C-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    'v',
    '<C-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
end
