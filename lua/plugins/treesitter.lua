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
          init_selection = "<leader>s", -- set to `false` to disable one of the mappings
          scope_incremental = "<leader>k",
          node_incremental = "<leader>l",
          node_decremental = "<leader>h",
        },
      },
    })
  end,
}
