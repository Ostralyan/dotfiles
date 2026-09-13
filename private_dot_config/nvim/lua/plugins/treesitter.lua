local languages = {
  "c", "lua", "vim", "vimdoc", "query",
  "javascript", "typescript", "tsx", "python", "html", "css", "json",
  "markdown", "markdown_inline",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(languages)

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Enable treesitter highlighting and indentation",
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang or not vim.treesitter.language.add(lang) then
          return
        end

        vim.treesitter.start(args.buf, lang)

        -- Treesitter indentation is experimental and only ships queries for
        -- some languages; fall back to the built-in indent otherwise.
        if vim.treesitter.query.get(lang, "indents") then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
