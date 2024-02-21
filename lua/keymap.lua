local wk = require("which-key")

wk.register({
	["<C-h>"] = { "<C-w>h", "Go to the left window" },
	["<C-l>"] = { "<C-w>l", "Go to the right window" },
	["<C-j>"] = { "<C-w>j", "Go to the top window" },
	["<C-k>"] = { "<C-w>k", "Go to the bottom window" },
	["<C-x>"] = { "<cmd>bdelete<cr>", "Close the current buffer" },
}, {
	mode = "n",
})

wk.register({
	["<C-h>"] = { "<Left>", "Move the cursor on the left" },
	["<C-l>"] = { "<Right>", "Move the cursor on the right" },
	["<C-k>"] = { "<Up>", "Move the cursor above" },
	["<C-j>"] = { "<Down>", "Move the cursor below" },
}, {
	mode = "i",
})

local telescope_builtin = require("telescope.builtin")
local dap = require("dap")

wk.register({
	-- Find things
	f = {
		name = "Find",
		-- File pickers
		f = { telescope_builtin.find_files, "Find file" },
		a = { telescope_builtin.live_grep, "Live grep" },
		w = { telescope_builtin.grep_string, "Search the word under the cursor" },
		cb = { telescope_builtin.current_buffer_fuzzy_find, "Search in the current buffer" },

		-- LSP pickers
		ld = { telescope_builtin.lsp_definitions, "Find LSP definitions" },

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
		gs = { telescope_builtin.git_status, "Find git status" },
		ga = { telescope_builtin.git_stash, "Find git stash" },

		-- Treesitter
		tree = { telescope_builtin.treesitter, "Find Treesitter object" },
	},
	-- Debugger
	db = { dap.toggle_breakpoint, "Toogle debug breakpoint" },
	dl = { dap.run_last, "Run last debug session" },
}, { prefix = "<leader>" })

local dap_ui_widgets = require("dap.ui.widgets")

-- Debugger
wk.register({
	["<F5>"] = { dap.continue, "Start debugging" },
	["<F6>"] = { dap.terminate, "Stop debugging" },
	["<F9>"] = { dap.step_back, "Step back" },
	["<F10>"] = { dap.step_over, "Step over" },
	["<F11>"] = { dap.step_into, "Step into" },
	["<F12>"] = { dap.step_out, "Step out" },
	["<leader>dh"] = { dap_ui_widgets.hover, "Evaluate in a floating window" },
	["<leader>dp"] = { dap_ui_widgets.preview, "Evaluate in a buffer" },
	["<leader>df"] = {
		function()
			dap_ui_widgets.centered_float(dap_ui_widgets.frames)
		end,
		"View the current frames in a centered floating window",
	},
	["<leader>ds"] = {
		function()
			dap_ui_widgets.centered_float(dap_ui_widgets.scopes)
		end,
		"View the current scopes in a centered floating window",
	},
}, {
	mode = { "n", "v" },
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

		wk.register({
			gD = { lsp.buf.declaration, "Go to declaration" },
			gd = { lsp.buf.definition, "Go to definition" },
			K = { lsp.buf.hover, "Show documentation" },
			gi = { telescope_builtin.lsp_implementations, "Find implementations" },
			["<leader>k"] = { lsp.buf.signature_help, "Show signature" },
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
			gr = { telescope_builtin.lsp_references, "List all references of the symbol under the cursor" },
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

-- File tree
wk.register({
	["<C-n>"] = { "<cmd>Neotree toggle reveal_force_cwd<cr>", "Open Neotree" },
})

-- Terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

wk.register({
	["<A-v>"] = { "<cmd>ToggleTerm direction=vertical size=80<cr>", "Toggle vertical terminal" },
	["<A-h>"] = { "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle horizontal terminal" },
	["<A-f>"] = { "<cmd>ToggleTerm direction=float<cr>", "Toggle floating terminal" },
	["<leader>gs"] = {
		function()
			lazygit:toggle(100, "float")
		end,
		"Toggle Lazygit",
	},
}, {
	mode = "n",
})

wk.register({
	["<A-v>"] = { "<C-\\><C-n><cmd>ToggleTerm direction=vertical<cr>", "Toggle vertical terminal" },
	["<A-h>"] = { "<C-\\><C-n><cmd>ToggleTerm direction=horizontal<cr>", "Toggle horizontal terminal" },
	["<A-f>"] = { "<C-\\><C-n><cmd>ToggleTerm direction=float<cr>", "Toggle floating terminal" },
	["<C-h>"] = { "<C-\\><C-n><C-w>h", "While in terminal mode, move to the left window" },
	["<C-l>"] = { "<C-\\><C-n><C-w>l", "While in terminal mode, move to the right window" },
	["<C-j>"] = { "<C-\\><C-n><C-w>j", "While in terminal mode, move to the top window" },
	["<C-k>"] = { "<C-\\><C-n><C-w>k", "While in terminal mode, move to the bottom window" },
}, {
	mode = "t",
})

local trouble = require("trouble")

wk.register({
	["<leader>xx"] = {
		function()
			trouble.toggle()
		end,
		"Toggle Trouble",
	},
	["<leader>xw"] = {
		function()
			trouble.toggle("workspace_diagnostics")
		end,
		"Toggle Trouble workspace diagnostics",
	},
	["<leader>xd"] = {
		function()
			trouble.toggle("document_diagnostics")
		end,
		"Toggle Trouble document diagnostics",
	},
	["<leader>xq"] = {
		function()
			trouble.toggle("quickfix")
		end,
		"Toggle Trouble quickfix",
	},
	["<leader>xl"] = {
		function()
			trouble.toggle("loclist")
		end,
		"Toggle Trouble location list",
	},
	["gR"] = {
		function()
			trouble.toggle("lsp_references")
		end,
		"Toggle Trouble LSP references",
	},
}, {
	mode = "n",
})
