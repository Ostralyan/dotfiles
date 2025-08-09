return {
  'NMAC427/guess-indent.nvim',
  config = function()
    require('guess-indent').setup({
      auto_cmd = true,  -- Set to true to automatically run :GuessIndent when a buffer is opened
      override_editorconfig = false,  -- Set to true to override settings from .editorconfig
      filetype_exclude = {  -- Filetypes to ignore
        "netrw",
        "tutor",
      },
      buftype_exclude = {  -- Buffer types to ignore
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
    })
  end,
}