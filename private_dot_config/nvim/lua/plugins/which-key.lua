return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require('which-key')
    
    -- Document existing key chains using the new v3 spec
    wk.add({
      -- Leader key groups
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunks' },
      { '<leader>l', group = 'lsp' },
      { '<leader>s', group = 'split/search' },
      { '<leader>t', group = 'toggle' },
      { '<leader>x', group = 'diagnostics/trouble' },
      { '<leader>c', group = 'code' },
      { '<leader>r', group = 'rename/references' },

      -- Goto mappings
      { 'g', group = 'goto' },
      { 'gd', desc = 'Go to definition' },
      { 'gr', desc = 'Go to references' },
      { 'gR', desc = 'LSP References (Trouble)' },

      -- Navigation
      { '[', group = 'prev' },
      { '[d', desc = 'Previous diagnostic' },
      { '[c', desc = 'Previous hunk' },
      { ']', group = 'next' },
      { ']d', desc = 'Next diagnostic' },
      { ']c', desc = 'Next hunk' },

      -- LSP mappings
      { '<leader>rn', desc = 'Rename symbol' },
      { '<leader>ca', desc = 'Code actions' },
      { 'K', desc = 'Hover documentation' },

      -- Window management
      { '<leader>sv', desc = 'Split vertically' },
      { '<leader>sh', desc = 'Split horizontally' },
      { '<leader>sq', desc = 'Close current split' },
      { '<leader>so', desc = 'Close other splits' },

      -- Git mappings
      { '<leader>gs', desc = 'Git status' },
      { '<leader>ga', desc = 'Git add .' },
      { '<leader>gp', desc = 'Git push' },
      { '<leader>gP', desc = 'Git pull --rebase' },
      { '<leader>gb', desc = 'Toggle git blame' },
      { '<leader>gB', desc = 'Git blame' },
      { '<leader>gl', desc = 'Git log (current file)' },
      { '<leader>gL', desc = 'Git log' },
      { '<leader>gss', desc = 'Git status (FzfLua)' },
      { '<leader>gll', desc = 'Git commits' },
      { '<leader>glb', desc = 'Git commits (buffer)' },

      -- Hunk operations
      { '<leader>hs', desc = 'Stage hunk' },
      { '<leader>hr', desc = 'Reset hunk' },
      { '<leader>hS', desc = 'Stage buffer' },
      { '<leader>hu', desc = 'Undo stage hunk' },
      { '<leader>hR', desc = 'Reset buffer' },
      { '<leader>hp', desc = 'Preview hunk' },
      { '<leader>hb', desc = 'Blame line' },
      { '<leader>hd', desc = 'Diff this' },
      { '<leader>hD', desc = 'Diff this (cached)' },

      -- Toggle operations
      { '<leader>tb', desc = 'Toggle blame line' },
      { '<leader>td', desc = 'Toggle deleted' },

      -- FzfLua mappings
      { '<leader>ff', desc = 'Find files' },
      { '<leader>fb', desc = 'Find buffers' },
      { '<leader>fh', desc = 'Find help' },
      { '<leader>fr', desc = 'Find recent files' },
      { '<leader>fg', desc = 'Live grep' },
      { '<leader>fG', desc = 'Grep string' },
      { '<leader>fw', desc = 'Grep word' },
      { '<leader>fW', desc = 'Grep WORD' },
      { '<leader>fd', desc = 'Find diagnostics' },

      -- File path copying
      { '<leader>fp', desc = 'Copy full path to clipboard' },
      { '<leader>fn', desc = 'Copy filename to clipboard' },
      { '<leader>fy', desc = 'Copy relative path to clipboard' },

      -- LSP mappings
      { '<leader>lr', desc = 'LSP references' },
      { '<leader>ls', desc = 'LSP document symbols' },
      { '<leader>lS', desc = 'LSP workspace symbols' },
      { '<leader>li', desc = 'LSP implementations' },
      { '<leader>ld', desc = 'LSP definitions' },
      { '<leader>lD', desc = 'LSP declarations' },
      { '<leader>lt', desc = 'LSP type definitions' },
      { '<leader>la', desc = 'LSP code actions' },

      -- Trouble mappings
      { '<leader>xx', desc = 'Toggle Trouble' },
      { '<leader>xw', desc = 'Workspace Diagnostics' },
      { '<leader>xd', desc = 'Document Diagnostics' },
      { '<leader>xq', desc = 'Quickfix' },
      { '<leader>xl', desc = 'Location List' },

      -- NvimTree
      { '<C-n>', desc = 'Toggle NvimTree' },

      -- Window resizing
      { '<C-Up>', desc = 'Increase height' },
      { '<C-Down>', desc = 'Decrease height' },
      { '<C-Left>', desc = 'Decrease width' },
      { '<C-Right>', desc = 'Increase width' },

      -- Visual mode mappings
      { '<leader>hs', desc = 'Stage hunk', mode = 'v' },
      { '<leader>hr', desc = 'Reset hunk', mode = 'v' },

      -- Terminal mode descriptions
      { '<Esc>', desc = 'Exit terminal mode', mode = 't' },

      -- Buffer management
      { '<leader>b', group = 'buffer' },
      { '<leader>bn', desc = 'Next buffer' },
      { '<leader>bp', desc = 'Previous buffer' },
      { '<leader>bf', desc = 'First buffer' },
      { '<leader>bl', desc = 'Last buffer' },
      { '<leader>bb', desc = 'List buffers' },
      { '<leader>b#', desc = 'Alternate buffer' },
      { '<leader>bd', desc = 'Delete buffer' },
      { '<leader>bD', desc = 'Force delete buffer' },
      { '<leader>bw', desc = 'Wipeout buffer' },
      { '<leader>bW', desc = 'Force wipeout buffer' },
      { '<leader>bo', desc = 'Close other buffers' },
      { '<leader>ba', desc = 'Close all but current' },
      { '<leader>bs', desc = 'Save buffer' },
      { '<leader>bS', desc = 'Save all buffers' },
      { '<leader>br', desc = 'Reload buffer' },

      -- Special keys
      { '<Esc>', desc = 'Clear search highlight' },
      { '<leader>?', desc = 'Buffer Local Keymaps' },
    })
  end,
}