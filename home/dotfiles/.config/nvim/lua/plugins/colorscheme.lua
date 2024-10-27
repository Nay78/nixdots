return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.sapphire },
        }
      end,
    })
  end,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
