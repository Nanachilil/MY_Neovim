-- options中的自动化命令组
vim.api.nvim_create_augroup("MyAutocmd_in_option", { clear = false })

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 界面相关
vim.opt.laststatus = 2 -- 总是显示状态栏
vim.o.signcolumn = "yes" -- 始终显示符号列
vim.opt.showmode = true -- 显示当前模式（如 INSERT、NORMAL）
vim.opt.ruler = true -- 显示光标位置（行号、列号）
vim.opt.scrolloff = 5 -- 光标距离顶部/底部的最小行数
-- vim.opt.guifont = "FiraCode Nerd Font:h12"
vim.wo.number = true -- 启用行号
vim.wo.relativenumber = true -- 启用相对行号

-- 高亮设置
vim.opt.syntax = "on" -- 启用语法高亮
vim.opt.cursorline = true -- 高亮显示当前光标所在的行
vim.opt.cursorcolumn = true -- 高亮显示当前光标所在的列
vim.opt.cursorline = true -- 启用光标所在行高亮
vim.opt.cursorcolumn = true -- 启用光标所在列高亮
vim.opt.termguicolors = true --启用真彩色

-- 设置制表符和缩进
vim.opt.autoindent = true -- 自动缩进
vim.opt.smartindent = true -- 智能缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt.cindent = true -- C 语言风格的缩进
  end,
})
vim.o.tabstop = 4 -- Tab键的宽度为 ? 个空格
vim.opt.softtabstop = 4 -- 编辑时 Tab 键的宽度为 ? 个空格
vim.o.shiftwidth = 4 -- 自动缩进的宽度为 ? 空格
vim.o.expandtab = true -- Tab键转换为空格

--编码相关
vim.opt.encoding = "utf-8" -- 默认编码为 UTF-8
vim.opt.fileencoding = "utf-8" -- 文件保存时的编码为 UTF-8

-- 搜索相关
vim.opt.showcmd = true -- 在底部显示当前命令
vim.opt.wildmenu = true -- 启用命令行补全菜单
vim.opt.incsearch = true -- 启用增量搜索
vim.opt.hlsearch = true -- 启用搜索高亮
vim.opt.ignorecase = true -- 搜索时忽略大小写
vim.opt.smartcase = true -- 如果搜索模式包含大写字母，则区分大小写
vim.opt.showmatch = true -- 高亮显示匹配的括号

-- 功能设置
vim.opt.autoread = true -- 当文件在外部被修改时，自动重新读取文件内容
vim.opt.history = 50 -- 命令历史记录的最大条数为500

-- 其他配置
vim.opt.linebreak = true -- 在单词边界换行
vim.opt.wrap = true -- 自动换行
vim.opt.mouse = "" --禁用鼠标支持
vim.opt.compatible = false -- 禁用 Vi 兼容模式
vim.opt.backspace = "indent,eol,start" -- 允许退格键删除缩进、换行符和插入模式前的字符
vim.opt.endofline = false -- 不自动添加换行符
vim.opt.timeoutlen = 150 -- 快捷键超时时间（毫秒）
vim.opt.list = true -- 显示不可见字符（如 Tab、空格）
vim.opt.clipboard = "unnamedplus" -- 设置默认寄存器使用系统剪贴板
vim.opt.listchars = {
	tab = "¦ ", -- 用 │ 表示 Tab
	trail = "·", -- 用 · 表示行尾空格
	extends = "›", -- 用 › 表示超出屏幕的文本
	precedes = "‹", -- 用 ‹ 表示超出屏幕的文本
	nbsp = "␣", -- 用 ␣ 表示非断行空格
}

-- Treesitter 折叠配置
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false -- 默认不折叠
vim.o.foldlevel = 99 -- 默认展开所有

--[[
-- 这个方法暂时失败,打算使用按键映射的方法主动：打开关闭拼写检查
-- 使用autocmd在打开text文件时，关闭拼写检查
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufAdd", "BufEnter" }, {
	group = "MyAutocmd_in_option",
	pattern = "text",
	callback = function()
		vim.opt.spell = false -- 禁用拼写检查
	end,
})
--]]

-- 延迟加载防止被覆盖的其他设置
vim.defer_fn(function()
	-- normal Mode
	-- vim.opt.spell = false -- 禁用拼写检查
end, 6000)
