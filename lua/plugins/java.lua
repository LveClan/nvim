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
  { import = "lazyvim.plugins.extras.editor.overseer" },

  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- 指定 jdtls 运行时使用的 Java 路径（必须是 JDK 17+，默认指向 JDK 21）
      local java_exec = vim.env.JDTLS_JAVA
        or "/usr/lib/jvm/temurin-21-jdk-amd64/bin/java"

      opts.cmd = opts.cmd or { vim.fn.exepath("jdtls") }
      if java_exec and not vim.tbl_contains(opts.cmd, "--java-executable=" .. java_exec) then
        table.insert(opts.cmd, "--java-executable=" .. java_exec)
      end

      -- 继承官方配置的基础上补充多 JDK 运行时
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            runtimes = {
              { name = "JavaSE-1.8", path = "/usr/lib/jvm/temurin-8-jdk-amd64" },
              { name = "JavaSE-21", path = "/usr/lib/jvm/temurin-21-jdk-amd64", default = true },
            },
          },
          maven = {
            settings = vim.fn.expand("~/.m2/settings.xml"),
          },
        },
      })

      -- 读取 .vscode/launch.(json|js) 以共享 VS Code 的调试配置
      local prev_on_attach = opts.on_attach
      opts.on_attach = function(args)
        if prev_on_attach then
          prev_on_attach(args)
        end

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "jdtls" then
          return
        end

        local root_dir = client.config.root_dir
        if not root_dir or root_dir == "" then
          return
        end

        local vscode = require("dap.ext.vscode")
        local mappings = { java = { "java" } }
        for _, path in ipairs({
          vim.fs.joinpath(root_dir, ".vscode", "launch.json"),
          vim.fs.joinpath(root_dir, ".vscode", "launch.js"),
        }) do
          if vim.uv.fs_stat(path) then
            local ok, err = pcall(vscode.load_launchjs, path, mappings)
            if not ok then
              vim.notify(string.format("[jdtls] 读取 %s 失败: %s", path, err), vim.log.levels.WARN)
            end
            break
          end
        end
      end

      return opts
    end,
  },
}
