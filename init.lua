require("base")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print("Installing lazy.nvim....")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  dev = {
    path = "~/Workspace/perso/nvim-plugins",
  },
})

require("keymap")

local filetype_mapping = require("filetypes")

for filetype, patterns in pairs(filetype_mapping) do
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = patterns,
    callback = function()
      vim.opt.filetype = filetype
    end,
  })
end
