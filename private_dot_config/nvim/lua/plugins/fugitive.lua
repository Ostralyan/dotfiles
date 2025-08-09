return {
  'tpope/vim-fugitive',
  dependencies = {
    "tpope/vim-rhubarb",
  },
  lazy = false,
  keys = {
    { '<leader>gs', ':Git<CR>', desc = 'Git status' },
    { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
    { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Git diff' },
    { '<leader>gc', ':Git commit<CR>', desc = 'Git commit' },
    { '<leader>gp', ':Git push<CR>', desc = 'Git push' },
    { '<leader>gl', ':Git log<CR>', desc = 'Git log' },
    { '<leader>gf', ':Git fetch<CR>', desc = 'Git fetch' },
  },
}
