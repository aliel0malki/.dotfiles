return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    vim.opt.laststatus = 2 -- Or 3 for global statusline
    vim.opt.statusline = " %t %m %= %l:%c "
    require("rose-pine").setup({
      highlight_groups = {
        StatusLine = { fg = "love", bg = "love", blend = 10 },
        StatusLineNC = { fg = "subtle", bg = "surface" },
      },
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    })
    vim.cmd("colorscheme rose-pine-main")
  end
}
