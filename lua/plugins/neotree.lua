return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["s"] = "noop",
            ["S"] = "noop",
            ["<C-s>"] = "open_split",
            ["<C-v>"] = "open_vsplit",
          },
        },
      })
    end,
  },
}
