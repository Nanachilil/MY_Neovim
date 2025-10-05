-- Nana_语法高亮组
-- markdown语法高亮

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.md",
-- 	callback = function()
-- 		vim.cmd("syntax clear")
-- 	end,
-- })

vim.api.nvim_set_hl(0, "Nana_markdownh1", {
	fg = "#FF5733", -- 橙色文字
	bg = "#2E3440", -- 深灰背景
	italic = false, -- 斜体
	bold = true, -- 粗体
	force = true,
})
