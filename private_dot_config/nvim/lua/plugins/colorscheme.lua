return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#a6e3a1" })

    end,
  },
}
