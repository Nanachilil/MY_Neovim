return {
	-- 1. copilot.lua：拉取 Copilot 建议
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter", -- 进入插入模式后加载
		cmd = { "Copilot", "CopilotPanel", "CopilotAuth" },
		opts = {
			suggestion = { enabled = true, auto_trigger = true },
			panel = { enabled = false }, -- 只要 inline 建议，无侧边面板
			server_opts_overrides = {
			},
		},
		config = function(_, opts)
			local function is_online()
				-- Windows 平台用 ping -n 1，Linux/macOS 用 ping -c 1
				local handle = io.popen("ping -c 1 github.com")
				local result = handle:read("*a") or ""
				handle:close()
				return result:find("ttl=") ~= nil
			end
			if is_online() then
				require("copilot").setup(opts)
				local suggestion = require("copilot.suggestion")
				vim.keymap.set("i", "<C-]>", function() suggestion.dismiss() end, { desc = "Dismiss Copilot suggestion" })
				vim.keymap.set("i", "<C-l>", function() suggestion.accept() end, { desc = "Accept Copilot suggestion" })
				-- vim.keymap.set("i", "<M-]>", function() suggestion.next() end, { desc = "Next Copilot suggestion" })
				-- vim.keymap.set("i", "<M-[>", function() suggestion.prev() end, { desc = "Previous Copilot suggestion" })
			else
				vim.notify("Copilot is not available offline", vim.log.levels.WARN)
			end
		end,
	},

	-- 2. copilot-cmp：把 Copilot 建议当作 nvim-cmp 的一个 source
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "nvim-cmp", "copilot.lua" },
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- 3. nvim-cmp：只保留 Copilot 作为唯一补全源
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP 补全源
			"L3MON4D3/LuaSnip",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"zbirenbaum/copilot-cmp", -- Copilot 补全源
			"saadparwaiz1/cmp_luasnip", -- Snippet 补全源（如果需要）
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.snippet = {
				-- 				expand = function(_) end, -- 不需要 snippet 插件支持
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- 如果使用 luasnip
				end,
			}
			opts.sources = {
				{ name = "copilot" }, -- copilot source
				{ name = "nvim_lsp" }, -- LSP source}
				{ name = "luasnip" }, -- Snippet source
			}
			opts.mapping = {
				["<C-k>"] = require("cmp").mapping.confirm({ select = true }),
				["<C-["] = require("cmp").mapping.abort(),
				["<Tab>"] = require("cmp").mapping.select_next_item(),
				["<S-Tab>"] = require("cmp").mapping.select_prev_item(),
			}
			opts.sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.score,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			}
			return opts
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "williamboman/mason-lspconfig.nvim" },
		},
		event = "BufReadPre",
		lazy = true,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- C/C++ - clangd
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
				}, -- 可选：添加启动参数
			})

			-- Python - pyright
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- Lua - lua_ls
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- 识别 vim 全局变量
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Neovim 运行时库
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- javascript/TypeScript -
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "typescript" },
				-- 				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
			})

			-- html - html
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
				-- 				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
			})

			-- css - cssls
			lspconfig.cssls.setup({
				capabilities = capabilities,
				filetypes = { "css" },
				-- 				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
			})

			-- markdown - marksman
			lspconfig.marksman.setup({
				capabilities = capabilities,
				filetypes = { "markdown" },
				-- 				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
			})


			-- 可选：LSP 按键映射
			-- 			vim.api.nvim_create_autocmd("LspAttach", {
			-- 				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			-- 				callback = function(ev)
			-- 					local opts = { buffer = ev.buf }
			-- 					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- 跳转到声明
			-- 					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- 跳转到定义
			-- 					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- 悬浮显示文档注释
			-- 					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- 跳转到实现
			-- 					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts) -- 重命名项目级变量
			-- 					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts) -- 提示光标处的修改建议
			-- 					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- 查找引用
			-- 				end,
			-- 			})
		end,
	},
}
