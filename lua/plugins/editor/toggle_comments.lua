return {
  "numToStr/Comment.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    require("Comment").setup({
		toggler = {
        line = '<D-/>',      -- Normal 模式：⌘+/ 注释/取消注释当前行
        -- block = '<D-/>',     -- Normal 模式：⌘+/ 也能切换块注释
		},
		opleader = {
			line = '<D-/>',      -- Visual 模式：⌘+/ 注释/取消注释选中行
			-- block = '<D-/>',     -- Visual 模式：⌘+/ 注释块
		}
	})
  end
}
