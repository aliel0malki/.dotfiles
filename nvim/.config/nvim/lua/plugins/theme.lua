return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.opt.laststatus = 2 -- Or 3 for global statusline
    vim.opt.statusline = " %t %m %= %l:%c "
    require("rose-pine").setup({
      variant = "main",
      dark_variant = "main",
      dim_inactive_windows = false,
      disable_background = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
      highlight_groups = {
        StatusLine = { fg = "love", bg = "love", blend = 10 },
        StatusLineNC = { fg = "subtle", bg = "surface" },
      },
    })

    vim.cmd("colorscheme rose-pine")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}
