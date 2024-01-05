local wk = require("which-key")

wk.register({
  ["<C-h>"] = { "<C-w>h", "Go to the left window" },
  ["<C-l>"] = { "<C-w>l", "Go to the right window" },
  ["<C-j>"] = { "<C-w>j", "Go to the top window" },
  ["<C-k>"] = { "<C-w>k", "Go to the bottom window" },
})

wk.register({
  ["<C-h>"] = { "<Left>", "Go to the left window" },
  ["<C-l>"] = { "<Right>", "Go to the right window" },
  ["<C-j>"] = { "<Up>", "Go to the top window" },
  ["<C-k>"] = { "<Down>", "Go to the bottom window" },
}, {
  mode = "i",
})

local telescope_builtin = require("telescope.builtin")

wk.register({
  -- Useful short keymaps
  ["/"] = { telescope_builtin.live_grep, "Live grep" },
  [":"] = { telescope_builtin.commands, "Find commands" },

  -- Neogit
  gs = {
    function()
      require("neogit").open({ kind = "split" })
    end,
    "Open Neogit",
  },

  -- Find things
  f = {
    name = "Find",
    -- File pickers
    f = { telescope_builtin.find_files, "Find file" },
    w = { telescope_builtin.grep_string, "Search the word under the cursor" },
    cb = { telescope_builtin.current_buffer_fuzzy_find, "Search in the current buffer" },

    -- LSP pickers
    lr = { telescope_builtin.lsp_references, "Find LSP references" },
    li = { telescope_builtin.lsp_implementations, "Find LSP implementations" },
    ld = { telescope_builtin.lsp_definitions, "Find LSP definitions" },
    ltd = { telescope_builtin.lsp_type_definitions, "Find LSP type definitions" },

    -- Vim pickers
    b = { telescope_builtin.buffers, "Find buffer" },
    h = { telescope_builtin.help_tags, "Find help tags" },
    m = { telescope_builtin.marks, "Find marks" },
    q = { telescope_builtin.quickfix, "Find quickfix" },
    ll = { telescope_builtin.loclist, "Find location" },
    jl = { telescope_builtin.jumplist, "Find jump" },
    k = { telescope_builtin.keymaps, "Find keymap" },

    -- Git pickers
    gc = { telescope_builtin.git_commits, "Find commits" },
    gbc = { telescope_builtin.git_bcommits, "Find commits for current buffer" },
    gbr = { telescope_builtin.git_branches, "Find git branch" },
    gst = { telescope_builtin.git_status, "Find git status" },
    gsta = { telescope_builtin.git_stash, "Find git stash" },

    -- Treesitter
    tree = { telescope_builtin.treesitter, "Find Treesitter object" },
  },
}, { prefix = "<leader>" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    local lsp = vim.lsp

    wk.register({
      gD = { lsp.buf.declaration, "Go to declaration" },
      gd = { lsp.buf.definition, "Go to definition" },
      K = { lsp.buf.hover, "Show documentation" },
      gi = { lsp.buf.implementation, "Go to implementation" },
      ["<C-k>"] = { lsp.buf.signature_help, "Show signature" },
      ["<leader>wa"] = { lsp.buf.add_workspace_folder, "Add folder to workspace" },
      ["<leader>wr"] = { lsp.buf.remove_workspace_folder, "Remove folder to workspace" },
      ["<leader>wl"] = {
        function()
          print(vim.inspect(lsp.buf.list_workspace_folders()))
        end,
        "List folders in workspace",
      },
      ["<leader>D"] = { lsp.buf.type_definition, "Type definition" },
      ["<leader>rn"] = { lsp.buf.rename, "Rename symbol" },
      gr = { lsp.buf.references, "List all references of the symbol under the cursor" },
      ["<leader>cf"] = {
        function()
          lsp.buf.format({ async = false })
        end,
        "Format code",
      },
    }, { opts })

    wk.register({
      ["<leader>ca"] = { lsp.buf.code_action, "Code actions" },
    }, {
      mode = { "n", "v" },
      buffer = opts.buffer,
    })
  end,
})

wk.register({
  ["<C-n>"] = { "<cmd>Neotree toggle reveal_force_cwd<cr>", "Open Neotree" },
})
