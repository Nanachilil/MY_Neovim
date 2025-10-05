return {
	{
		"lervag/vimtex",
		ft = { "tex" },
		init = function()
			-- 			vim.g.vimtex_view_method = "sumatrapdf"
			-- 			vim.g.vimtex_compiler_method = "latexmk"

			-- 使用 general 模式，手动指定 Chrome 打开 PDF
			vim.g.vimtex_view_method = "general"
			-- 设置 Chrome 可执行文件路径（请根据你的实际路径确认）
			vim.g.vimtex_view_general_viewer = "C:Program FilesGoogleChromeApplicationchrome.exe"
			-- 打开方式，可选：--new-window 或 --new-tab
			vim.g.vimtex_view_general_options = "--new-window"

			-- 启用 latexmk 编译，并使用独立文件夹作为输出目录
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_quickfix_mode = 0
		end,
		config = function()
			local texname = vim.fn.expand("%:t:r") -- 获取当前文件名（不含扩展名）
			local outdir = texname -- 输出文件夹名称与 tex 文件同名
			vim.g.vimtex_compiler_latexmk = {
				-- 				build_dir = function()
				-- 					return vim.fn.expand("%:t:r")
				-- 				end,
				callback = 1,
				continuous = 1,
				executable = "latexmk",

				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
					"-xelatex",
					"-outdir=" .. outdir, -- 输出目录
				},
			}
			-- 插件加载成功后的提示
			-- 			vim.notify("VimTeX 插件已加载 ✅", vim.log.levels.INFO, { title = "vimtex" })
		end,
	},
	{
		"micangl/cmp-vimtex",
		ft = { "tex" },
		dependencies = { "hrsh7th/nvim-cmp", "lervag/vimtex" },
		config = function()
			local cmp = require("cmp")
			cmp.setup.filetype("tex", {
				sources = cmp.config.sources({
					{ name = "vimtex" },
					{ name = "buffer" },
					-- 					{ name = "copilot" },
				}),
			})
			-- ✅ 加入禁用 Copilot 的自动命令（仅作用于 tex 文件）
			-- -- 这样可以避免在编辑 LaTeX 文件时 Copilot 自动补全干扰
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "tex",
				callback = function()
					vim.cmd("Copilot disable")
				end,
			})
		end,
	},
}
