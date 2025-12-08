return {
  {
    "stevearc/overseer.nvim",
    opts = function(_, opts)
      opts.templates = opts.templates or {}

      local function default_cwd()
        return vim.uv.cwd() or vim.fn.getcwd()
      end

      table.insert(opts.templates, {
        name = "Java: Spring Boot (Maven)",
        builder = function(params)
          local args = { "spring-boot:run" }
          if params.profile and params.profile ~= "" then
            table.insert(args, "-Dspring-boot.run.profiles=" .. params.profile)
          end
          if params.port and params.port > 0 then
            table.insert(args, "-Dspring-boot.run.arguments=--server.port=" .. params.port)
          end
          if params.jvm_args and params.jvm_args ~= "" then
            table.insert(args, "-Dspring-boot.run.jvmArguments=" .. params.jvm_args)
          end

          return {
            cmd = { params.mvn_bin },
            args = args,
            cwd = params.cwd,
            env = { SPRING_PROFILES_ACTIVE = params.profile },
            components = { "default" },
          }
        end,
        params = {
          cwd = { type = "string", default = default_cwd(), desc = "服务根目录" },
          mvn_bin = { type = "string", default = "mvn", desc = "Maven 可执行文件" },
          profile = { type = "string", default = "dev", desc = "SPRING_PROFILES_ACTIVE" },
          port = { type = "number", default = nil, desc = "覆盖 server.port" },
          jvm_args = { type = "string", default = "", desc = "追加 JVM 参数" },
        },
        priority = 60,
      })

      table.insert(opts.templates, {
        name = "Java: Spring Boot (Gradle)",
        builder = function(params)
          local cmd = params.use_gradlew and "./gradlew" or "gradle"
          local args = { "bootRun" }

          local run_args = {}
          if params.profile and params.profile ~= "" then
            table.insert(run_args, "--spring.profiles.active=" .. params.profile)
          end
          if params.port and params.port > 0 then
            table.insert(run_args, "--server.port=" .. params.port)
          end
          if params.app_args and params.app_args ~= "" then
            table.insert(run_args, params.app_args)
          end
          if #run_args > 0 then
            table.insert(args, "--args=" .. table.concat(run_args, " "))
          end
          if params.jvm_args and params.jvm_args ~= "" then
            table.insert(args, string.format("--jvm-args=%s", params.jvm_args))
          end

          return {
            cmd = { cmd },
            args = args,
            cwd = params.cwd,
            env = { SPRING_PROFILES_ACTIVE = params.profile },
            components = { "default" },
          }
        end,
        params = {
          cwd = { type = "string", default = default_cwd(), desc = "服务根目录" },
          use_gradlew = { type = "boolean", default = true, desc = "优先使用项目自带 ./gradlew" },
          profile = { type = "string", default = "dev", desc = "SPRING_PROFILES_ACTIVE" },
          port = { type = "number", default = nil, desc = "覆盖 server.port" },
          app_args = { type = "string", default = "", desc = "追加应用参数" },
          jvm_args = { type = "string", default = "", desc = "JVM 参数" },
        },
        priority = 60,
      })
    end,
  },
}
