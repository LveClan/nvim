return {
  -- 加载官方的配置
  { import = "lazyvim.plugins.extras.lang.java" },

  { import = "lazyvim.plugins.extras.dap.core" },

  {
    "mfussenegger/nvim-jdtls",
    opts = {
      init_options = {
        bundles = {
          -- java-debug-adapter（保持不变）
          vim.fn.glob(
            vim.fn.stdpath("data")
              .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
            true,
            true
          )[1],
          -- java-test（关键！改成新路径）
          vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true, true)[1],
        },
      },
      settings = {
        java = {
          maven = {
            -- 设置maven路径
            settings = vim.fn.expand("~/.m2/settings.xml"),
          },
        },
      },
    },
  },
}
