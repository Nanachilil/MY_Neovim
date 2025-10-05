return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		lazy = true,
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		lazy = true,
-- 		config = function()
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "clangd", "pyright", "lua_ls" },
-- 			})
-- 		end,
	},
}
