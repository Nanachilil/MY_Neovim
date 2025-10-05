-- 环境
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------------
-- lazy.nvim插件管理表内字段管理规范（return以及其他插件引入方式）：
-- 1. https://lazy.folke.io/spec （交互式的“Spec”页面）
-- 2. https://github.com/folke/lazy.nvim/blob/main/doc/lazy.nvim.txt（源码）
-- 3. https://github.com/folke/lazy.nvim （Readme）
------------------------------------------------------------------

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import/override with your plugins
		{ import = "plugins.ui" },
		{ import = "plugins.lsp" },
		{ import = "plugins.extra" },
		{ import = "plugins.editor" },
	},
	git = {
		-- 这里改为 SSH 格式，避免 HTTPS 问题
		--url_format = "git@github.com:%s.git",
		url_format = "https://github.com/%s.git"

	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight" } }, -- "tokyonight"  habamax
	checker = {
		enabled = false, -- check for plugin updates periodically
		notify = false, -- notify on update
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "none",
		backdrop = 70,
		title_pos = "center",
	},
})
