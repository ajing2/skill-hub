# 🛠️ Skill Hub

> CatDesk Skill 编写与管理仓库

用于统一管理、编写和分发 [CatDesk](https://catdesk.meituan.com) 的自定义 Skill。

---

## 📁 目录结构

```
skill-hub/
├── skills/                    # 所有 Skill 存放目录
│   ├── example-skill/         # 示例模板（勿删）
│   │   └── SKILL.md
│   └── your-skill-name/       # 你的 Skill
│       └── SKILL.md
├── scripts/
│   ├── new-skill.sh           # 快速创建新 Skill
│   ├── upload.sh              # 上传 Skill 到本地 CatDesk
│   └── list.sh                # 列出所有 Skills 及安装状态
└── docs/
    └── skill-writing-guide.md # Skill 编写指南
```

---

## 🚀 快速开始

### 1. 创建新 Skill

```bash
./scripts/new-skill.sh my-skill-name
```

### 2. 编写 Skill

编辑 `skills/my-skill-name/SKILL.md`，参考 [编写指南](docs/skill-writing-guide.md)。

### 3. 上传到本地 CatDesk

```bash
# 上传到全局（所有项目可用）
./scripts/upload.sh my-skill-name --global

# 上传所有 skills
./scripts/upload.sh --global
```

### 4. 查看 Skills 列表

```bash
./scripts/list.sh
```

### 5. 同步到 GitHub

```bash
git add .
git commit -m "feat: add my-skill-name"
git push
```

---

## 📝 Skill 文件格式

每个 Skill 必须包含 `SKILL.md`，格式如下：

```markdown
---
name: skill-name
description: "触发描述，AI 根据此判断何时使用该 Skill"
metadata:
  version: "1.0.0"
  author: "your-name"
  created: "2026-06-14"
  tags:
    - tag1
---

# Skill 标题

## 功能说明
...

## 执行步骤
...
```

---

## 📦 Skills 列表

| Skill 名称 | 描述 | 版本 |
|-----------|------|------|
| example-skill | 示例模板 | 1.0.0 |

---

## 🔧 脚本说明

| 脚本 | 用途 |
|------|------|
| `scripts/new-skill.sh <name>` | 创建新 Skill 模板 |
| `scripts/upload.sh [name] [--global]` | 上传 Skill 到本地 CatDesk |
| `scripts/list.sh` | 列出所有 Skills 及安装状态 |
