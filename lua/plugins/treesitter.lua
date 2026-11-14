return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "c", "cpp", "cmake", "make",
      "ocaml", "ocaml_interface",
      "lua", "vim", "vimdoc", "query",
      "bash", "json", "yaml", "toml",
      "markdown", "markdown_inline",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
