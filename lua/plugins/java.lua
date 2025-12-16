vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

return {
  -- 加载官方的配置
  { import = "lazyvim.plugins.extras.lang.java" },

  { import = "lazyvim.plugins.extras.dap.core" },

  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts = opts or {}

      -- 指定 jdtls 运行时使用的 Java 路径（必须是 JDK 21+）
      local jdtls_java_path = "/usr/lib/jvm/temurin-21-jdk-amd64/bin/java"

      local function resolve_jdtls_cmd()
        local uv = vim.uv or vim.loop
        local mason_cmd = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
        if uv.fs_stat(mason_cmd) then
          return mason_cmd
        end
        local cmd = vim.fn.exepath("jdtls")
        if cmd ~= "" then
          return cmd
        end
        return "jdtls"
      end

      -- 修改启动命令：避免 cmd[1] 为空，同时添加 --java-executable 参数
      if type(opts.cmd) ~= "table" then
        opts.cmd = opts.cmd and { opts.cmd } or {}
      end

      if opts.cmd[1] == nil or opts.cmd[1] == "" then
        opts.cmd[1] = resolve_jdtls_cmd()
      end

      for i = #opts.cmd, 1, -1 do
        if type(opts.cmd[i]) == "string" and vim.startswith(opts.cmd[i], "--java-executable=") then
          table.remove(opts.cmd, i)
        end
      end

      table.insert(opts.cmd, 2, "--java-executable=" .. jdtls_java_path)

      -- 配置 init_options
      opts.init_options = vim.tbl_deep_extend("force", opts.init_options or {}, {
        bundles = {
          -- java-debug-adapter
          vim.fn.glob(
            vim.fn.stdpath("data")
              .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
            true,
            true
          )[1],
          -- java-test
          vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true, true)[1],
        },
      })

      -- 配置 settings
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            -- 配置多个 JDK 运行时，让项目可以使用不同的 JDK 版本
            runtimes = {
              {
                name = "JavaSE-1.8",
                path = "/usr/lib/jvm/temurin-8-jdk-amd64",
              },
              {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/temurin-21-jdk-amd64",
                default = true, -- 设置为默认运行时
              },
            },
          },
          maven = {
            settings = vim.fn.expand("~/.m2/settings.xml"),
          },
        },
      })

      return opts
    end,
  },
}
