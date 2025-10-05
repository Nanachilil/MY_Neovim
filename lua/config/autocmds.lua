-- 进入Normal, Visual模式时切换输入法
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*:[nNvV]*",
	callback = function()
		vim.fn.system("im-select.exe 1033")
	end,
})

--
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.semanticTokensProvider then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
