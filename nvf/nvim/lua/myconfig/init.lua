local o = vim.opt
o.wrap = true
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  refactor = {
    highlight_current_scope = { enable = true },
  },
}

