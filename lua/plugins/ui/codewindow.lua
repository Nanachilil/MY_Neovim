return {
	{
		"gorbit99/codewindow.nvim",
		enabled = true,
		config = function()
			local codewindow = require("codewindow")
			codewindow.setup({
				auto_enable = false, -- 自动启用
				exclude_filetypes = { "help", "NvimTree" }, -- 排除某些文件类型
				nimimap_width = 10, -- 缩略图宽度
				use_lsp = true, -- 使用 LSP 数据
				use_treesitter = true, -- 使用 treesitter 数据
			})
			-- 设置快捷键
			codewindow.apply_default_keybinds()
		end,
	},
}
