return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",  -- Use blink instead of nvim-cmp
  },
  config = function()
    require("mason").setup()
    
    require("mason-lspconfig").setup({
      ensure_installed = { 
        "lua_ls",           -- Neovim config
        "pyright",          -- Python
        "ts_ls",            -- TypeScript
        "html",             -- HTML
        "cssls",            -- CSS
        "gopls",            -- Go
      },
      automatic_installation = true,
    })
    -- Share blink capabilities with every server we enable.
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Python setup
    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    -- Lua setup (for Neovim config)
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    -- Go setup
    vim.lsp.config('gopls', {
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
          buildFlags = { "-mod=mod" },
          env = {
            GOFLAGS = "-mod=mod",
          },
        },
      },
    })

    -- TypeScript uses defaults from nvim-lspconfig; just enable it
    vim.lsp.enable({ "pyright", "ts_ls", "lua_ls", "gopls" })
  end,
}
