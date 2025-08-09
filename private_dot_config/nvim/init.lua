require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Default indentation settings - always use spaces, never tabs
-- These will be overridden by guess-indent.nvim when it detects different settings
vim.opt.expandtab = true        -- Convert tabs to spaces
vim.opt.tabstop = 2             -- Number of spaces tabs count for (default)
vim.opt.shiftwidth = 2          -- Size of an indent (default)
vim.opt.softtabstop = 2         -- Number of spaces tabs count for in insert mode (default)
vim.opt.smartindent = true      -- Insert indents automatically
vim.opt.autoindent = true       -- Copy indent from current line when starting new line
vim.opt.breakindent = true      -- Enable break indent
vim.opt.shiftround = true       -- Round indent to multiple of shiftwidth

-- Set the color of all line numbers

-- Set the color of the current line number
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'red', bold = true })

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'red' }) -- Replace #AABBCC with your desired color
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "pink" })


-- Auto-reload files when changed outside of nvim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  desc = "Check for external file changes"
})

vim.opt.updatetime = 1000

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- KeyMaps
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


-- Window management
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>sq', '<C-w>q', { desc = 'Close current split' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = 'Close other splits' })

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase width' })

-- Buffer navigation
keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
keymap('n', '<leader>bf', ':bfirst<CR>', { noremap = true, silent = true, desc = 'First buffer' })
keymap('n', '<leader>bl', ':blast<CR>', { noremap = true, silent = true, desc = 'Last buffer' })

-- Buffer switching
keymap('n', '<leader>bb', ':buffers<CR>:buffer<Space>', { noremap = true, desc = 'List buffers' })
keymap('n', '<leader>b#', ':buffer #<CR>', { noremap = true, silent = true, desc = 'Alternate buffer' })

-- Buffer closing
keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Delete buffer' })
keymap('n', '<leader>bD', ':bdelete!<CR>', { noremap = true, silent = true, desc = 'Force delete buffer' })
keymap('n', '<leader>bw', ':bwipeout<CR>', { noremap = true, silent = true, desc = 'Wipeout buffer' })
keymap('n', '<leader>bW', ':bwipeout!<CR>', { noremap = true, silent = true, desc = 'Force wipeout buffer' })

-- Close all buffers except current
keymap('n', '<leader>bo', ':only<CR>', { noremap = true, silent = true, desc = 'Close other buffers' })
keymap('n', '<leader>ba', ':%bdelete|edit #|normal `"<CR>', { noremap = true, silent = true, desc = 'Close all but current' })

-- Buffer utilities
keymap('n', '<leader>bs', ':write<CR>', { noremap = true, silent = true, desc = 'Save buffer' })
keymap('n', '<leader>bS', ':wall<CR>', { noremap = true, silent = true, desc = 'Save all buffers' })
keymap('n', '<leader>br', ':edit!<CR>', { noremap = true, silent = true, desc = 'Reload buffer' })

-- File path copying
keymap('n', '<leader>fp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('*', path)
  print('Full path copied: ' .. path)
end, { noremap = true, silent = true, desc = 'Copy full path to clipboard' })

keymap('n', '<leader>fn', function()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('*', filename)
  print('Filename copied: ' .. filename)
end, { noremap = true, silent = true, desc = 'Copy filename to clipboard' })

keymap('n', '<leader>fy', function()
  local relpath = vim.fn.expand('%')
  vim.fn.setreg('*', relpath)
  print('Relative path copied: ' .. relpath)
end, { noremap = true, silent = true, desc = 'Copy relative path to clipboard' })


