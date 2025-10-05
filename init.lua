-- bootstrap lazy.nvim, LazyVim and your plugins

--[[
-- 打印 runtimepath
local runtime_paths = vim.split(vim.o.runtimepath, ",")
for _, path in ipairs(runtime_paths) do
print(path)
end
]]
local start_time = vim.loop.hrtime()

-- 调试：捕捉 @keyword 高亮设置
--[[ local old_set_hl = vim.api.nvim_set_hl
vim.api.nvim_set_hl = function(ns, name, val)
	if name == "@keyword" then
		print("SET @keyword", vim.inspect(val))
		print(debug.traceback())
	end
	return old_set_hl(ns, name, val)
end
]]

-- 用户自定义配置
require("config.options")
require("config.keymaps")
require("config.highlights")
require("config.autocmds")
require(".lazy")

-- Neovide 专属配置
require("config.neovide")


-- 打印启动耗时
vim.schedule(function()
	local delta = (vim.loop.hrtime() - start_time) / 1e6 -- 单位为毫秒
	vim.notify(string.format("Neovim loaded in %.2f ms", delta), vim.log.levels.INFO)
end)
