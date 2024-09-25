return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({ 'telescope' })

    vim.keymap.set("n", "<leader>f", function() require('fzf-lua').files({ resume = true }) end, {})
    vim.keymap.set("n", "<leader>fg", require('fzf-lua').live_grep, {})
    vim.keymap.set("n", "<leader><leader>", require('fzf-lua').buffers, {})
  end
}
