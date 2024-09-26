return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        file_ignore_patterns = { "node_modules", ".git", "dist" },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<leader>ff",
      function() require('telescope.builtin').find_files({ prompt_title = 'Find Files' }) end)
    vim.keymap.set("n", "<leader>fg",
      function() require('telescope.builtin').live_grep({ prompt_title = 'Live Grep' }) end)
    vim.keymap.set("n", "<leader>fb", function() require('telescope.builtin').buffers({ prompt_title = 'Buffers' }) end)
    vim.keymap.set("n", "<leader>fh",
      function() require('telescope.builtin').help_tags({ prompt_title = 'Help Tags' }) end)
  end,
}
