# 🛠️ Skill Hub

> CatDesk 自定义 Skill 编写与管理仓库

用于统一管理、编写和分发 CatDesk 的自定义 Skill，按功能分类组织，支持一键上传到本地 CatDesk。

---

## 📁 目录结构

```
skill-hub/
├── skills/                        # 所有 Skill 按功能分类存放
│   ├── office/                    # 📋 办公协作类
│   │   ├── README.md              #    分类说明
│   │   └── <skill-name>/
│   │       └── SKILL.md
│   ├── data/                      # 📊 数据处理类
│   │   ├── README.md
│   │   └── <skill-name>/SKILL.md
│   ├── browser/                   # 🌐 浏览器自动化类
│   │   ├── README.md
│   │   └── <skill-name>/SKILL.md
│   ├── dev/                       # 💻 开发辅助类
│   │   ├── README.md
│   │   └── <skill-name>/SKILL.md
│   ├── writing/                   # ✍️  内容创作类
│   │   ├── README.md
│   │   └── <skill-name>/SKILL.md
│   └── _template/                 # 📐 模板目录（不会被上传）
│       └── example-skill/SKILL.md
├── scripts/
│   ├── new-skill.sh               # 快速创建新 Skill
│   ├── upload.sh                  # 上传 Skill 到本地 CatDesk
│   └── list.sh                    # 按分类列出所有 Skills
└── docs/
    └── skill-writing-guide.md     # Skill 编写指南
```

---

## 🗂️ 分类说明

| 分类 | 图标 | 说明 | 典型场景 |
|------|------|------|---------|
| `office` | 📋 | 办公协作 | 发大象消息、发邮件、订会议室、查日程 |
| `data` | 📊 | 数据处理 | Excel 分析、图表生成、数据清洗 |
| `browser` | 🌐 | 浏览器自动化 | 网页抓取、表单填写、截图 |
| `dev` | 💻 | 开发辅助 | 代码审查、生成测试、写 commit、生成文档 |
| `writing` | ✍️  | 内容创作 | 写周报、文档润色、PPT 大纲、翻译 |
| `_template` | 📐 | 模板（不上传） | 新建 Skill 时的参考模板 |

---

## 🚀 快速开始

### 1. 创建新 Skill

```bash
# 格式：./scripts/new-skill.sh <分类> <skill名称>
./scripts/new-skill.sh office  send-elephant-msg
./scripts/new-skill.sh dev     code-review
./scripts/new-skill.sh data    excel-analyzer
./scripts/new-skill.sh writing weekly-report
```

### 2. 编写 Skill

编辑生成的 `skills/<category>/<skill-name>/SKILL.md`，参考 [编写指南](docs/skill-writing-guide.md)。

### 3. 上传到本地 CatDesk

```bash
# 上传指定 skill（推荐）
./scripts/upload.sh office/send-elephant-msg --global

# 上传整个分类
./scripts/upload.sh office --global

# 上传所有 skills
./scripts/upload.sh --global

# 预览将要上传的内容（不实际执行）
./scripts/upload.sh --dry-run
```

### 4. 查看 Skills 列表

```bash
./scripts/list.sh
```

### 5. 同步到 GitHub

```bash
git add .
git commit -m "feat(office): add send-elephant-msg"
git push
```

---

## 📝 Commit 规范

提交时建议在 message 中注明分类：

```
feat(office):   新增办公类 Skill
feat(dev):      新增开发类 Skill
fix(data):      修复数据类 Skill 的问题
docs:           更新文档
refactor:       重构脚本
```

---

## 🔧 脚本说明

### `new-skill.sh` — 创建新 Skill

```bash
./scripts/new-skill.sh <category> <skill-name>
```

会在对应分类目录下生成包含完整字段的 `SKILL.md` 模板，并给出后续操作提示。

### `upload.sh` — 上传 Skill

```bash
./scripts/upload.sh [target] [--global] [--dry-run]
```

| 参数 | 说明 |
|------|------|
| 不传 target | 上传所有分类下的所有 Skill |
| `office` | 上传整个 office 分类 |
| `office/my-skill` | 上传指定 Skill |
| `--global` | 上传到全局目录 `~/.catpaw/skills/`（所有项目可用） |
| 不加 `--global` | 上传到项目级目录 `.catpaw/skills/` |
| `--dry-run` | 预览模式，不实际写入 |

> **注意**：`_template` 等以 `_` 开头的目录不会被上传。

### `list.sh` — 查看 Skills

```bash
./scripts/list.sh
```

按分类展示所有 Skill 的名称、版本、作者和安装状态。

---

## 📦 Skills 列表

### 📋 office — 办公协作

| Skill | 描述 | 版本 |
|-------|------|------|
| _(待添加)_ | | |

### 📊 data — 数据处理

| Skill | 描述 | 版本 |
|-------|------|------|
| _(待添加)_ | | |

### 🌐 browser — 浏览器自动化

| Skill | 描述 | 版本 |
|-------|------|------|
| _(待添加)_ | | |

### 💻 dev — 开发辅助

| Skill | 描述 | 版本 |
|-------|------|------|
| _(待添加)_ | | |

### ✍️ writing — 内容创作

| Skill | 描述 | 版本 |
|-------|------|------|
| _(待添加)_ | | |
