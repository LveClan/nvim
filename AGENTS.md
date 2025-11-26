# Repository Guidelines

## 项目结构与模块组织
- `init.lua`：入口，加载 `lua/config/lazy.lua` 完成 lazy.nvim 与插件规格初始化。
- `lua/config/`：个人配置入口，按职责拆分：`options.lua`（基础选项）、`keymaps.lua`（快捷键）、`autocmds.lua`（自动命令）、`lazy.lua`（插件管理与性能策略）。
- `lua/plugins/`：按需新增插件规格文件，一文件一主题，命名用功能短语（如 `lsp.lua`、`ui.lua`）。
- `lazyvim.json`：LazyVim 安装与启用的 extras 记录；`lazy-lock.json`：插件锁定版本，确保可重复安装。
- `.neoconf.json`：neoconf 与 neodev 配置，确保 `lua_ls` 能识别运行时库。
- `stylua.toml`：统一 Lua 代码风格（2 空格缩进、120 列）。

## 构建、测试与本地开发命令
- `:Lazy sync`：安装/更新插件并清理未用插件。
- `:Lazy check`：检查插件更新与状态，默认静默提示。
- `:Mason`：打开 Mason UI 管理 LSP/格式化/诊断工具。
- `:TSUpdate`：安装或更新 Tree-sitter 解析器。
- `:checkhealth`：检查运行时依赖（Python、Node、剪贴板等）。
- `stylua .`：在仓库根目录格式化 Lua 文件（需要已安装 stylua）。

## 代码风格与命名约定
- Lua 统一使用 2 空格缩进、最长行 120 列；保持 KISS/YAGNI，避免多余配置。
- 插件规格文件放在 `lua/plugins/`，文件名使用功能域词；局部变量与模块名采用小写加下划线。
- 避免在示例文件中留存未使用的 spec；提交前可运行 `stylua .` 保持一致。

## 测试与验证
- 本仓库无自动化测试，变更后至少执行 `:checkhealth` 与 `:Lazy sync` 确认无错误。
- 新增插件时确认启动无异常、关键快捷键可用；如修改 Tree-sitter/LSP，运行 `:TSUpdate` 或检查 Mason 安装状态。

## 提交与 Pull Request 指南
- 仓库无现有提交规范，建议采用 Conventional Commits（如 `feat: add vue tooling`、`chore: format lua`），主题用祈使句、简短描述。
- PR 建议包含：变更概要、影响范围（启动性能/快捷键/语言支持）、验证步骤（Neovim 版本、执行过的命令），如涉及 UI 变更可附截图或录屏。
- 请勿提交个人系统或秘密信息；确认 `lazy-lock.json` 是否需要随变更更新再提交。***
