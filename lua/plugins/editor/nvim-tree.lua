return {
	"nvim-tree/nvim-tree.lua",
	version = "v1.13.0",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = true,
	lazy = true,
	-- 延迟加载，在启动时自动打开（可根据需求改为其他事件，如 "BufReadPost"）
	event = "VimEnter",
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "<C-x>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<Esc>", api.fs.clear_clipboard, opts("Clear Clipboard"))
		end

		-- 基本配置
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			disable_netrw = true, -- 禁用内置 netrw
			hijack_netrw = true, -- 接管 netrw 的目录打开功能
			open_on_tab = false, -- 不在新标签页中自动打开
			hijack_cursor = true, -- 聚焦时让光标跟随文件树
			update_cwd = true, -- 切换目录时同步 CWD
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filters = {
				dotfiles = false,
				custom = { "^\\.git$" },
			},
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
		})

		-- 快捷键：<leader>e 切换 NvimTree
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })

		-- <leader>f 定位当前文件
		vim.keymap.set(
			"n",
			"<leader>f",
			"<cmd>NvimTreeFindFile<CR>",
			{ desc = "Locate file in NvimTree", silent = true }
		)

		vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
	end,
}
