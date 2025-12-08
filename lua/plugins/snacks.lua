return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Explorer：默认显示隐藏文件和 Git 忽略文件，省去每次手动切换
      explorer = {
        hidden = true,
        ignored = true,
      },
      -- Picker（如 find files / live grep）：也默认包含隐藏与忽略文件
      picker = {
        hidden = true,
        ignored = true,
      },
    },
  },
}
