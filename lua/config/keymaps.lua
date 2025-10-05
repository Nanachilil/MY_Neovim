-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- function for keymaps

-- 设置 <leader> 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 映射函数
-- vim.api.nvim_set_keymap: 这种是老方法，只能绑定命令，要把函数转为命令字符串
-- vim.keymap.set: 推荐这种，可以绑定命令和函数

local function toggle_input_method()
	-- 获取当前输入法ID，假设1033是英文，2052是中文
	local current = vim.fn.system("im-select.exe"):gsub("%s+", "")
	if current == "1033" then
		vim.fn.system("im-select.exe 2052") -- 切到中文
		vim.notify("输入法切换到中文")
	else
		vim.fn.system("im-select.exe 1033") -- 切到英文
		vim.notify("输入法切换到英文")
	end
end

vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>", toggle_input_method, { desc = "切换输入法" })

-- Insert Mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Visual Mode
vim.api.nvim_set_keymap("v", "H", "0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "L", "$", { noremap = true, silent = true })

-- normal Mode
vim.api.nvim_set_keymap("n", "H", "0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
-- 窗口导航：Ctrl-h/j/k/l → 切到左/下/上/右 窗口
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- tab, buffer, window 切换
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>n", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>c", ":tabclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>o", ":tabonly<CR>", { noremap = true, silent = true })

-- 剪贴板操作
vim.keymap.set("n", "y", '"+y', { noremap = true, desc = "系统剪贴板复制" })
vim.keymap.set("v", "y", '"+y', { noremap = true })
vim.keymap.set("n", "p", '"+p', { noremap = true, desc = "系统剪贴板粘贴" })
vim.keymap.set("n", "P", '"+P', { noremap = true })
vim.keymap.set("v", "p", '"+p', { noremap = true })
vim.keymap.set("v", "P", '"+P', { noremap = true })

vim.opt.clipboard = "unnamedplus"
-- Normal 模式下，⌘C 复制，⌘V 粘贴
vim.keymap.set('n', '<D-c>', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<D-v>', '"+p')

-- 插入模式下，⌘V 粘贴
vim.keymap.set('i', '<D-v>', '<C-r>+')

-- Visual 模式（重点！鼠标选区时生效）
vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true })

-- 命令行模式下，⌘V 粘贴
vim.keymap.set('c', '<D-v>', '<C-r>+')
vim.opt.mouse = "a"




-- 延迟加载防止被覆盖
vim.defer_fn(function()
	-- normal Mode
	--	vim.api.nvim_set_keymap("n", "H", "0", { noremap = true, silent = true })
	--	vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })
end, 6000)
