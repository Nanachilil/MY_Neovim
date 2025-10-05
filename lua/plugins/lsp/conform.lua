-- 在保存的时候自动格式化代码

return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
			},
			formatters = {
				stylua = {
					command = "stylua",
					-- 关键参数：通过 stdin 读取内容，并传递文件路径
					args = { "-", "--stdin-filepath", "$FILENAME" }, -- 新增 --stdin-filepath 和 $FILENAME
					stdin = true, -- 启用标准输入
				},
				black = {
					command = "black",
					args = { "-", "--stdin-filename", "$FILENAME", "--quiet" }, -- 新增 --stdin-filepath 和 $FILENAME
					stdin = true, -- 启用标准输入
				},
				clang_format = {
					command = "clang-format",
					args = { "--stdin-filename", "$FILENAME", "-" }, -- 新增 --stdin-filepath 和 $FILENAME
					stdin = true, -- 启用标准输入
				},
				prettier = {
					command = "prettier",
					args = {
						"--stdin-filepath",
						"$FILENAME", -- 自动替换为当前文件路径
					},
					stdin = true, -- 启用标准输入
					timeout = 3000, -- 10s超时上限
				},
				notify_on_error = true,
			},
		},
		config = function(_, opts)
			-- 确保 mason/bin 在PATH（通常已自动，保险起见）
			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
				vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
			end

			require("conform").setup(opts)

			-- 保存之前自动格式化
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.lua", "*.c", "*.cpp", "*.py", "*.js", "*.md", "*.html", "*.css" },
				callback = function(args)
					require("conform").format({ bufnr = args.buf, async = false })
				end,
			})
		end,
	},
}
