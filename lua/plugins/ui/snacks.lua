return {
	"folke/snacks.nvim",
	-- 当按下下面这些键时才加载插件，缩短启动时间
	keys = {
		{
			"<leader>t",
			function()
				require("snacks").terminal(nil, { mode = "float" })
			end,
			desc = "Terminal ↔ Float",
		},
	},
	config = function()
		require("snacks").setup({
			-- 只启用 terminal 模块（其它模块也可以按需开启）
			modules = { "terminal" },
			terminal = {
				-- 分窗模式的窗口参数
				win = {
					position = "bottom", -- bottom/top/left/right
					size = 15, -- 行数或列数
				},
				-- 浮动模式的窗口参数
				float = {
					border = "rounded", -- none|single|double|rounded|shadow
					width = 80, -- 宽度（字符数）
					height = 20, -- 高度（行数）
				},
				-- 其它可选参数（如 shell、env 等）可在这里覆盖
			},
		})
		-- 在 floating 或 split 终端里都生效：
		vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
		vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })
	end,
}
