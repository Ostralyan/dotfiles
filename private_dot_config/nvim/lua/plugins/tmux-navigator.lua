return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  config = function()
    -- Disable default mappings
    vim.g.tmux_navigator_no_mappings = 1
    
    -- Custom mappings using Meta (Alt) key
    vim.keymap.set('n', '<M-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate to tmux/vim pane left' })
    vim.keymap.set('n', '<M-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate to tmux/vim pane down' })
    vim.keymap.set('n', '<M-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate to tmux/vim pane up' })
    vim.keymap.set('n', '<M-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate to tmux/vim pane right' })
    
    -- Also map in insert, visual, and terminal modes for seamless navigation
    vim.keymap.set('i', '<M-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate to tmux/vim pane left' })
    vim.keymap.set('i', '<M-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate to tmux/vim pane down' })
    vim.keymap.set('i', '<M-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate to tmux/vim pane up' })
    vim.keymap.set('i', '<M-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate to tmux/vim pane right' })
    
    vim.keymap.set('v', '<M-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate to tmux/vim pane left' })
    vim.keymap.set('v', '<M-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate to tmux/vim pane down' })
    vim.keymap.set('v', '<M-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate to tmux/vim pane up' })
    vim.keymap.set('v', '<M-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate to tmux/vim pane right' })
    
    vim.keymap.set('t', '<M-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate to tmux/vim pane left' })
    vim.keymap.set('t', '<M-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate to tmux/vim pane down' })
    vim.keymap.set('t', '<M-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate to tmux/vim pane up' })
    vim.keymap.set('t', '<M-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate to tmux/vim pane right' })
  end,
}