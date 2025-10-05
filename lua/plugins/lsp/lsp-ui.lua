return {
	{
		"nvimdev/lspsaga.nvim",
		enabled = true,
		event = "LspAttach", -- 自动在 LSP 启动时加载
		config = function()
			require("lspsaga").setup({
				lightbulb = { enable = false }, -- 关闭浮动提示灯泡（个人喜好）
			})

			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			-- 跳转与查找
			keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
			keymap("n", "gr", "<cmd>Lspsaga finder def+ref+imp<CR>", opts) -- 当前符号的定义、引用、实现等跳转入口

			-- 悬停文档与 Code Action
			keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
			keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- 展示光标处的代码提示

			-- 重命名符号（全项目）
			keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

			-- 显示 diagnostics 信息
			keymap("n", "<leader>`", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

			-- 支持跳转后返回
			keymap("n", "<C-i", "<cmd>Lspsaga incoming_calls<CR>", opts)
			keymap("n", "<C-o>", "<cmd>Lspsaga outgoing_calls<CR>", opts)

			-- 打开浮动终端
			-- 			keymap("n", "<C-T>", "<cmd>Lspsaga term_toggle<CR>", opts)

			-- 打开outline
			-- toggle_or_jump = 'o' toggle or jump
			-- quit = 'q' quit outline window
			-- jump = 'e' jump to pos even on a expand/collapse node
			keymap("n", "<C-t>", "<cmd>Lspsaga outline<CR>", opts)
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- 建议依赖，提升语法高亮和结构分析
		},
	},
}
