return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- 	enable = false,
	lazy = false,
	config = function()
		-- 自动安装语法模块
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"c",
				"cpp",
				"lua",
				"markdown",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
								-- disable = { "markdown" }, -- 👈 显式禁用 markdown 的高亮支持
			},
			indent = {
				enable = true,
			},
		})

		--[[
		-- 自定义语法高亮颜色
		local hl = vim.api.nvim_set_hl

		-- 注释（绿色偏灰，斜体）
		hl(0, "@comment", { fg = "#6a8a8c", italic = true })

		-- 函数名（橙色，加粗）
		hl(0, "@function", { fg = "#d08770", bold = true })

		-- 关键字（蓝色，加粗）
		hl(0, "@keyword", { fg = "#81a1c1", bold = true })

		-- 类型（青色，斜体）
		hl(0, "@type", { fg = "#8fbcbb", italic = true })

		-- 字符串（绿色）
		hl(0, "@string", { fg = "#a3be8c" })

		-- 数字（紫色）
		hl(0, "@number", { fg = "#b48ead" })

		-- 运算符（黄色）
		hl(0, "@operator", { fg = "#e5c07b" })

		-- 参数（深橘色）
		hl(0, "@parameter", { fg = "#d19a66" })

		-- 条件 / 循环控制
		hl(0, "@conditional", { fg = "#bf616a", bold = true })
		hl(0, "@repeat", { fg = "#bf616a", bold = true })

		-- 可选：全局变量、字段
		hl(0, "@field", { fg = "#d8dee9" })
		hl(0, "@variable", { fg = "#d8dee9" })
		]]
	end,
}
