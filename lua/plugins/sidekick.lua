return {
  { import = "lazyvim.plugins.extras.ai.sidekick" },

  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false }, -- 关掉 Copilot NES
    },
    keys = {
      -- 禁用 NES 的所有默认键映射
      { "<Tab>", false, mode = { "i", "n" }, has = "nes" },
      -- 切换 claude-code
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude-code", focus = true })
        end,
        desc = "Toggle Claude Code",
      },
      -- 切换 codex
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "codex", focus = true })
        end,
        desc = "Toggle Codex",
      },
    },
  },
}
