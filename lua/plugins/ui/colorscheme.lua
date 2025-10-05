return {
	{
		"ribru17/bamboo.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({
				-- optional configuration here
			})
			require("bamboo").load()
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false, -- 主题必须尽早加载
		priority = 1000, -- 保证优先级最高
		opts = {
			style = "moon", -- night, storm, day, moon
			transparent = false, -- 是否透明背景
			terminal_colors = true, -- 同步终端配色
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
			sidebars = "dark", -- 边栏背景 (help、qf 等窗口)
			floats = "dark", -- 浮动窗口背景
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		lazy = false, -- 提前加载主题
		priority = 1000, -- 确保主题最优先
		opts = {
			style = "darker", -- 可选：dark, darker, cool, deep, warm, light
			transparent = false, -- 是否透明背景
			term_colors = true, -- 同步到终端
			code_style = {
				comments = "italic",
				keywords = "bold",
				functions = "none",
				strings = "none",
				variables = "none",
			},
			lualine = {
				transparent = false, -- lualine 背景是否透明
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			require("onedark").load()
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				theme = "onedark_dark", -- 你要的 OnedarkPro Dark
				options = {
					transparency = false,
					terminal_colors = true,
				},
				-- 可选：如果想让背景更深一点再加 colors.bg
				-- colors = { bg = "#0b0d10", bg1 = "#111317" },

				------------------------------------------------------------------
				-- 这里是自定义的“高对比语法配色”方案（Treesitter + 诊断 + 常用组）
				------------------------------------------------------------------
				-- === 近似 themery 的高对比语法配色 ===
				highlights = {
					-- 基础 UI
					Normal = { fg = "#E6EAF2", bg = "#0b0d10" },
					NormalNC = { fg = "#CDD3E0", bg = "#0b0d10" },
					CursorLine = { bg = "#0f1318" },
					CursorLineNr = { fg = "#E5C07B", bold = true },
					LineNr = { fg = "#586370" },
					Visual = { bg = "#1f2430" },
					Search = { fg = "#0b0d10", bg = "#E5C07B", bold = true },
					IncSearch = { fg = "#0b0d10", bg = "#56B6C2", bold = true },
					NormalFloat = { bg = "#111317" },
					FloatBorder = { fg = "#6C7086", bg = "#111317" },
					Pmenu = { bg = "#111317" },
					PmenuSel = { bg = "#1f2430", fg = "#E6EAF2", bold = true },

					-- Treesitter 语法（核心配色）
					["@comment"] = { fg = "#AAAAAA", italic = false }, -- 注释：灰色
					["@keyword"] = { fg = "#FF3333", bold = true }, -- 关键字：鲜红
					["@keyword.function"] = { link = "@keyword" }, -- 函数关键字：同鲜红
					["@function"] = { fg = "#E6B455", bold = true }, -- 函数名：金黄
					["@function.call"] = { fg = "#FFE4E1", bold = false }, -- 函数调用：浅黄
					["@function.method"] = { link = "@function.call" }, -- 方法名：同金黄
					["@method"] = { fg = "#E5B455", bold = false }, -- 方法名：同金黄
					["@constructor"] = { fg = "#E6B455", bold = true }, -- 构造器：金黄
					["@variable"] = { fg = "#FFFFFF", bold = true }, -- 普通变量：白色
					["@parameter"] = { fg = "#FFFFFF", bold = false }, -- 参数：白色
					["@field"] = { fg = "#FFFFFF", bold = false }, -- 字段/属性：白色
					["@property"] = { link = "@field" }, -- 属性：同亮白色
					["@type"] = { fg = "#66FF66", bold = true }, -- 用户类型：金黄
					["@type.builtin"] = { fg = "#66FF66", bold = true }, -- 内置类型：亮绿色
					["@constant"] = { fg = "#FFFFFF", bold = true, italic = true, underline = true }, -- 常量：白色
					["@string"] = { fg = "#FFFFFF", bold = false }, -- 字符串：白色
					["@character"] = { link = "@string" }, -- 字符：同紫色
					["@number"] = { fg = "#FFFFFF", bold = false }, -- 数字：白色
					["@boolean"] = { fg = "#C678DD", bold = false }, -- 布尔：紫色
					["@operator"] = { fg = "#C678DD", bold = true }, -- 运算符：白色
					["@punctuation"] = { fg = "#C678DD", bold = true }, -- 标点：紫色

					-- 诊断更醒目
					DiagnosticError = { fg = "#FF6B6B", bold = true },
					DiagnosticWarn = { fg = "#E5C07B", bold = true },
					DiagnosticInfo = { fg = "#56B6C2" },
					DiagnosticHint = { fg = "#98C379" },
					DiagnosticUnderlineError = { sp = "#FF6B6B", undercurl = true },
					DiagnosticUnderlineWarn = { sp = "#E5C07B", undercurl = true },
					DiagnosticUnderlineInfo = { sp = "#56B6C2", undercurl = true },
					DiagnosticUnderlineHint = { sp = "#98C379", undercurl = true },
				},
			})

			vim.o.termguicolors = true
			vim.o.background = "dark"
			require("onedarkpro").load()
		end,
	},
}
