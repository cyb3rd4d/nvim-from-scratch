return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "html",
        "go",
        "php",
        "sql",
        "xml",
        "json",
        "graphql",
        "http",
        "dockerfile",
        "groovy",
        "rust",
      },
      ignore_install = {},
      modules = {},
      auto_install = false,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>t", -- set to `false` to disable one of the mappings
          node_incremental = "<leader>k",
          scope_incremental = "<leader>j",
          node_decremental = "<leader>o",
        },
      },
    })
  end,
}
