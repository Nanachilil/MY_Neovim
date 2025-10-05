return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    opts = {
      file_types = { "markdown" },
      heading = {
        enabled = true,
        sign = true,    -- 只显示 sign
        icons = {},     -- 不要额外图标
        backgrounds = {},
        foregrounds = {
			"RenderMarkdownH1Sign",
			"RenderMarkdownH2Sign",
			"RenderMarkdownH3Sign",
			"RenderMarkdownH4Sign",
			"RenderMarkdownH5Sign",
			"RenderMarkdownH6Sign",
		},
        border = false,
      },
    },
    config = function(_, opts)
      local hl = vim.api.nvim_set_hl
      hl(0, "RenderMarkdownH1Sign", { fg = "#FF6B6B", bold = true }) -- 红
      hl(0, "RenderMarkdownH2Sign", { fg = "#FFA500", bold = true }) -- 橙
      hl(0, "RenderMarkdownH3Sign", { fg = "#FFD700", bold = true }) -- 黄
      hl(0, "RenderMarkdownH4Sign", { fg = "#32CD32", bold = true }) -- 绿
      hl(0, "RenderMarkdownH5Sign", { fg = "#1E90FF", bold = true }) -- 蓝
      hl(0, "RenderMarkdownH6Sign", { fg = "#9370DB", bold = true }) -- 紫
	  require("render-markdown").setup(opts)
    end,
  },
}