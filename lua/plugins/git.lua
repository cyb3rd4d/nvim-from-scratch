return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",      -- required
      "sindrets/diffview.nvim",     -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup()
      vim.keymap.set("n", "<leader>s", function()
        neogit.open({ kind = "split" })
      end, {})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  }
}
