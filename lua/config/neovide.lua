-- 如果不是 Neovide，直接 return
if not vim.g.neovide then
  return
end

-----------------------------------------------------------
-- Neovide 专属配置
-----------------------------------------------------------

-- 字体设置（带 Nerd Font）
-- vim.o.guifont = "JetBrainsMono Nerd Font:h14"
vim.g.neovide_input_ime = true

-- 窗口透明度（0 ~ 1.0）
vim.g.neovide_opacity = 0.9  -- 0~1 之间，1 = 不透明，0 = 全透明

-- 1. 设置 guicursor，
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i:ver25,r-cr-o:hor20"

-- 2. 定义 Cursor 高亮组为橙色
vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#FFA500" })  -- 橙色
vim.api.nvim_set_hl(0, "lCursor", { fg = "#000000", bg = "#FFA500" }) -- 橙色
vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#FFA500" }) -- 橙色
-- 设置 Visual 模式下的选区背景颜色
vim.api.nvim_set_hl(0, "Visual", { bg = "#788496", fg = "NONE" })

-- 光标尾巴特效
vim.g.neovide_cursor_vfx_mode = "pixiedust"
-- 其他可选： "torpedo", "pixiedust", "sonicboom", "ripple"

-- 粒子效果参数
vim.g.neovide_cursor_vfx_opacity = 100.0
vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
vim.g.neovide_cursor_vfx_particle_density = 5.0
vim.g.neovide_cursor_vfx_particle_speed = 5.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5

-- 平滑滚动
vim.g.neovide_scroll_animation_length = 0.3



-- 设置缩放比例，默认是 1.0
vim.g.neovide_scale_factor = 1.0  -- 放大 20%

-- 全屏/窗口缩放（快捷键）
vim.keymap.set("n", "<F11>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Toggle Neovide Fullscreen" })

vim.keymap.set("n", "<C-=>", function()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) * 1.1
end, { desc = "Zoom In GUI" })

vim.keymap.set("n", "<C-->", function()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) / 1.1
end, { desc = "Zoom Out GUI" })

-----------------------------------------------------------
-- 提示信息
-----------------------------------------------------------
vim.notify("Neovide GUI loaded with fancy effects ✨", vim.log.levels.INFO)