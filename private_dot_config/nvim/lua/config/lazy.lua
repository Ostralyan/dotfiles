-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

print("Looking for plugins in:", vim.fn.stdpath("config") .. "/lua/plugins")


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Auto-sync plugins at most once per day (adjust `interval` to taste)
local lazy_auto_sync = {
  interval = 24 * 60 * 60,
  stamp = vim.fn.stdpath("state") .. "/lazy-auto-sync",
}

local function lazy_last_sync()
  local ok, data = pcall(vim.fn.readfile, lazy_auto_sync.stamp)
  if ok and data[1] then
    return tonumber(data[1])
  end
end

local function lazy_mark_synced()
  local dir = vim.fn.fnamemodify(lazy_auto_sync.stamp, ":h")
  if dir ~= "" then
    vim.fn.mkdir(dir, "p")
  end
  pcall(vim.fn.writefile, { tostring(os.time()) }, lazy_auto_sync.stamp)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local last_run = lazy_last_sync()
    local should_sync = not last_run or (os.time() - last_run) >= lazy_auto_sync.interval
    if not should_sync then
      return
    end
    require("lazy").sync({ show = false })
  end,
})

-- Mark sync completion and close the Lazy UI if it popped open for any reason
vim.api.nvim_create_autocmd("User", {
  pattern = "LazySync",
  callback = function()
    lazy_mark_synced()
    local view = require("lazy.view")
    if view.visible() and view.view then
      view.view:close({ wipe = false })
    end
  end,
})
