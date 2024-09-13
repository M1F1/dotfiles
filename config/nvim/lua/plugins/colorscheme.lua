return {
  "0xstepit/flow.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("flow").setup({
      dark_theme = true,
      transparent = false,
      high_contrast = false,
      fluo_color = "orange",
      mode = "desaturate",
      aggressive_spell = false,
    })
    vim.cmd("colorscheme flow")
  end,
}
