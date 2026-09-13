return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- use a release tag to download pre-built binaries
  version = '1.*',

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = 'default' },
    appearance = {
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing and sizing
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },
    signature = { enabled = true }
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
