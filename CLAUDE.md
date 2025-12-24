# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是基于 [LazyVim](https://github.com/LazyVim/LazyVim) 的 Neovim 个人配置。

## 常用命令

- `:Lazy sync` - 安装/更新插件并清理未用插件
- `:Lazy check` - 检查插件更新与状态
- `:Mason` - 管理 LSP/格式化/诊断工具
- `:TSUpdate` - 安装或更新 Tree-sitter 解析器
- `:checkhealth` - 检查运行时依赖
- `stylua .` - 格式化 Lua 文件

## 项目结构

- `init.lua` - 入口文件，加载 `lua/config/lazy.lua`
- `lua/config/` - 基础配置：`options.lua`(选项)、`keymaps.lua`(快捷键)、`autocmds.lua`(自动命令)、`lazy.lua`(插件管理)
- `lua/plugins/` - 插件规格文件，一文件一主题
- `lazyvim.json` - LazyVim extras 记录
- `lazy-lock.json` - 插件锁定版本
- `.neoconf.json` - neoconf 配置

## 关键配置

- **Java 支持** (`java.lua`)：使用 jdtls，JDK 路径 `/usr/lib/jvm/temurin-21-jdk-amd64`，root_dir 强制为当前工作区
- **AI 助手** (`sidekick.lua`)：集成 Claude Code (`<leader>ac`) 和 Codex (`<leader>ao`)
- **Snacks** (`snacks.lua`)：默认显示隐藏文件和 Git 忽略文件

## 代码风格

Lua 使用 2 空格缩进、最长行 120 列（见 `stylua.toml`）。
