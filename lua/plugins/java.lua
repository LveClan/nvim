return {
  -- 加载官方的配置
  { import = "lazyvim.plugins.extras.lang.java" },

  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          maven = {
            settings = vim.fn.expand("~/.m2/settings.xml"),
          },
        },
      },
    },
  },
}
