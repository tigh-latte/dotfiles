require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },
}
