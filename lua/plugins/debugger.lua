return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			config = true,
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters.go = function(callback, config)
				local default_config = {
					type = "server",
					host = "127.0.0.1",
					port = "${port}",
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:${port}" },
					},
					options = {
						initialize_timeout_sec = 20,
					},
				}

				if config.mode ~= "remote" then
					callback(default_config)
					return
				end

				local listener_addr = config.host .. ":" .. config.port
				default_config.port = config.port
				default_config.executable.args = { "dap", "-l", listener_addr }

				vim.notify("Dynamic remote Go adapter with listener address: " .. listener_addr, vim.log.levels.DEBUG)

				callback(default_config)
			end

			local vscode = require("dap.ext.vscode")
			vscode.load_launchjs()
		end,
	},
}
