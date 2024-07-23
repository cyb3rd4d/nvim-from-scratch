local wk = require("which-key")

wk.add({
  { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Go to the left window" },
  { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to the right window" },
  { "<C-j>", "<cmd>TmuxNavigateUp<cr>",    desc = "Go to the top window" },
  { "<C-k>", "<cmd>TmuxNavigateDown<cr>",  desc = "Go to the bottom window" },
  { "<C-x>", "<cmd>bdelete<cr>",           desc = "Close the current buffer" },
})

wk.add({
  {
    mode = "i",
    { "<C-h>", "<Left>",  desc = "Move the cursor on the left" },
    { "<C-l>", "<Right>", desc = "Move the cursor on the right" },
    { "<C-k>", "<Up>",    desc = "Move the cursor above" },
    { "<C-j>", "<Down>",  desc = "Move the cursor below" },
  },
})

local telescope_builtin = require("telescope.builtin")
local dap = require("dap")

wk.add({
  -- Find things
  { "<leader>f",     group = "Find" },
  -- File pickers
  { "<leader>ff",    telescope_builtin.find_files,                desc = "Find file" },
  { "<leader>fa",    telescope_builtin.live_grep,                 desc = "Live grep" },
  { "<leader>fw",    telescope_builtin.grep_string,               desc = "Search the word under the cursor" },
  { "<leader>fcb",   telescope_builtin.current_buffer_fuzzy_find, desc = "Search in the current buffer" },

  -- LSP pickers
  { "<leader>fld",   telescope_builtin.lsp_definitions,           desc = "Find LSP definitions" },

  -- Vim pickers
  { "<leader>fb",    telescope_builtin.buffers,                   desc = "Find buffer" },
  { "<leader>fh",    telescope_builtin.help_tags,                 desc = "Find help tags" },
  { "<leader>fm",    telescope_builtin.marks,                     desc = "Find marks" },
  { "<leader>fq",    telescope_builtin.quickfix,                  desc = "Find quickfix" },
  { "<leader>fll",   telescope_builtin.loclist,                   desc = "Find location" },
  { "<leader>fjl",   telescope_builtin.jumplist,                  desc = "Find jump" },
  { "<leader>fk",    telescope_builtin.keymaps,                   desc = "Find keymap" },

  -- Git pickers
  { "<leader>fgc",   telescope_builtin.git_commits,               desc = "Find commits" },
  { "<leader>fgbc",  telescope_builtin.git_bcommits,              desc = "Find commits for current buffer" },
  { "<leader>fgbr",  telescope_builtin.git_branches,              desc = "Find git branch" },
  { "<leader>fgs",   telescope_builtin.git_status,                desc = "Find git status" },
  { "<leader>fga",   telescope_builtin.git_stash,                 desc = "Find git stash" },

  -- Treesitter
  { "<leader>ftree", telescope_builtin.treesitter,                desc = "Find Treesitter object" },
  -- Debugger
  { "<leader>db",    dap.toggle_breakpoint,                       desc = "Toogle debug breakpoint" },
})

local dap_ui_widgets = require("dap.ui.widgets")
local dapui = require("dapui")
local dap_go = require("dap-go")

-- Debugger
wk.add({
  { "<F5>",  dap.continue,  desc = "Start debugging" },
  { "<F6>",  dap.terminate, desc = "Stop debugging" },
  { "<F7>",  dapui.close,   desc = "Stop debugging" },
  { "<F9>",  dap.step_back, desc = "Step back" },
  { "<F10>", dap.step_over, desc = "Step over" },
  { "<F11>", dap.step_into, desc = "Step into" },
  { "<F12>", dap.step_out,  desc = "Step out" },
  {
    mode = { "n", "i" },
    { "<leader>d",   group = "Debugger" },
    { "<leader>dt",  dap_go.debug_test,      desc = "Debug Go test" },
    { "<leader>dlt", dap_go.debug_last_test, desc = "Debug last Go test" },
    { "<leader>dh",  dap_ui_widgets.hover,   desc = "Evaluate in a floating window" },
    { "<leader>dp",  dap_ui_widgets.preview, desc = "Evaluate in a buffer" },
    {
      "<leader>df",
      function()
        dap_ui_widgets.centered_float(dap_ui_widgets.frames)
      end,
      desc = "View the current frames in a centered floating window",
    },
    {
      "<leader>ds",
      function()
        dap_ui_widgets.centered_float(dap_ui_widgets.scopes)
      end,
      desc = "View the current scopes in a centered floating window",
    },
  },
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    local lsp = vim.lsp

    wk.add({
      {
        buffer = opts.buffer,
        { "gD",         lsp.buf.declaration,                   desc = "Go to declaration" },
        { "gd",         lsp.buf.definition,                    desc = "Go to definition" },
        { "K",          lsp.buf.hover,                         desc = "Show documentation" },
        { "gi",         telescope_builtin.lsp_implementations, desc = "Find implementations" },
        { "<leader>k",  lsp.buf.signature_help,                desc = "Show signature" },
        { "<leader>wa", lsp.buf.add_workspace_folder,          desc = "Add folder to workspace" },
        { "<leader>wr", lsp.buf.remove_workspace_folder,       desc = "Remove folder to workspace" },
        {
          "<leader>wl",
          function()
            print(vim.inspect(lsp.buf.list_workspace_folders()))
          end,
          desc = "List folders in workspace",
        },
        { "<leader>D",  lsp.buf.type_definition, desc = "Type definition" },
        { "<leader>rn", lsp.buf.rename,          desc = "Rename symbol" },
        {
          "gr",
          telescope_builtin.lsp_references,
          desc = "List all references of the symbol under the cursor",
        },
        {
          "<leader>cf",
          function()
            lsp.buf.format({ async = false })
          end,
          desc = "Format code",
        },
      },
    })

    wk.add({
      { "<leader>ca", lsp.buf.code_action, desc = "Code actions", mode = { "n", "v" }, buffer = opts.buffer },
    })
  end,
})

-- Git
wk.add({
  { "<leader>g",  group = "Git" },
  { "<leader>gs", "<cmd>LazyGit<cr>", desc = "Toggle Lazygit" },
  { "<leader>gg", "<cmd>G<cr>",       desc = "Toggle Fugitive" },
})

-- File tree
wk.add({
  { "<C-n>", "<cmd>Neotree toggle reveal_force_cwd<cr>", desc = "Open Neotree" },
})

-- Terminal
wk.add({
  { "<A-v>", "<cmd>ToggleTerm direction=vertical size=120<cr>",  desc = "Toggle vertical terminal" },
  { "<A-h>", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Toggle horizontal terminal" },
  { "<A-f>", "<cmd>ToggleTerm direction=float<cr>",              desc = "Toggle floating terminal" },
})

wk.add({
  {
    mode = "t",
    { "<A-v>", "<C-\\><C-n><cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle vertical terminal" },
    { "<A-h>", "<C-\\><C-n><cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
    { "<A-f>", "<C-\\><C-n><cmd>ToggleTerm direction=float<cr>",      desc = "Toggle floating terminal" },
    {
      "<C-h>",
      "<C-\\><C-n><C-w>h",
      desc = "While in terminal mode, move to the left window",
    },
    {
      "<C-l>",
      "<C-\\><C-n><C-w>l",
      desc = "While in terminal mode, move to the right window",
    },
    {
      "<C-j>",
      "<C-\\><C-n><C-w>j",
      desc = "While in terminal mode, move to the top window",
    },
    {
      "<C-k>",
      "<C-\\><C-n><C-w>k",
      desc = "While in terminal mode, move to the bottom window",
    },
  },
})

local trouble = require("trouble")

wk.add({
  {
    "<leader>xx",
    function()
      trouble.toggle("diagnostics")
    end,
    desc = "Toggle Trouble",
  },
  {
    "<leader>xq",
    function()
      trouble.toggle("quickfix")
    end,
    desc = "Toggle Trouble quickfix",
  },
  {
    "<leader>xl",
    function()
      trouble.toggle("loclist")
    end,
    desc = "Toggle Trouble location list",
  },
  {
    "gR",
    function()
      trouble.toggle("lsp_references")
    end,
    desc = "Toggle Trouble LSP references",
  },
})

wk.add({
  { "-", "<cmd>Oil<cr>", desc = "Open Oil in the parent directory" },
})
