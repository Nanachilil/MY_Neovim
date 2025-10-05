return {
	-- 显式加载 plenary.nvim
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
		priority = 1000,
	},
	-- 配置 telescope.nvim
	-- 进行模糊搜索
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "plenary.nvim" },
		config = function()
			require("telescope").setup()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "查找文件（文件名）" })
			vim.keymap.set("n", "<C-g>", builtin.live_grep, { desc = "全文搜索（内容）" })
		end,
	},
}
