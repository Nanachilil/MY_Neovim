return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = true,
		-- event = "BufRead *.md",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			-- 设置 Safari 的路径
			-- 路径中有空格，lua语言需要使用双引号
			vim.g.mkdp_browser = "safari"
			-- vim.g.mkdp_browser_path = '"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"'
			vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", {
				desc = "Markdown Preview Toggle", -- 可选：添加描述
				silent = true, -- 静默执行
				noremap = true, -- 非递归映射
			})
		end,
	},
}
