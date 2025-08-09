return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      -- Optional: configure fzf-lua settings
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          default = 'bat', -- Use bat for syntax highlighting
        },
      },
    })
    
    -- Essential keybindings
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
    
    -- LSP integration
    vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "LSP references" })
    vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols" })
    vim.keymap.set("n", "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
    vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "LSP definitions" })
    
    -- Git integration
    vim.keymap.set("n", "<leader>gcs", "<cmd>FzfLua git_commits<cr>", { desc = "Git commits" })
    vim.keymap.set("n", "<leader>gss", "<cmd>FzfLua git_status<cr>", { desc = "Git status" })
  end,
}
