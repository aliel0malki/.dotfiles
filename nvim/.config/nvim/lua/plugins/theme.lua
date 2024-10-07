function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_italic = true,
        disable_background = false
      })

      vim.cmd("colorscheme rose-pine")
      ColorMyPencils()
    end,
  },
}
