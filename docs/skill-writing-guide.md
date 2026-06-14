# Skill 编写指南

> 本文档介绍如何为 CatDesk 编写高质量的 Skill。

---

## 什么是 Skill？

Skill 是一段 Markdown 格式的指令文件（`SKILL.md`），告诉 AI 在特定场景下应该如何行动。当用户的请求匹配到 Skill 的描述时，AI 会自动读取并遵循 Skill 中的指令。

---

## SKILL.md 结构

```markdown
---
name: skill-name           # Skill 唯一标识（英文，用连字符）
description: "..."         # 触发描述（最重要！）
metadata:
  version: "1.0.0"
  author: "your-name"
  created: "2026-06-14"
  tags:
    - tag1
---

# Skill 正文内容
```

---

## 编写高质量 description 的技巧

`description` 是 AI 判断是否触发该 Skill 的唯一依据，非常关键。

**好的 description 应该：**

1. **明确列出触发关键词**，例如：
   > 当用户提到"发大象消息"、"@某人"、"发邮件"时使用

2. **描述使用场景**，而不只是功能名称：
   > 当用户需要与网站交互、填写表单、点击按钮、截图时使用

3. **包含中英文关键词**（如果用户可能用两种语言提问）：
   > Use when user asks to "查询会议室" or "book a meeting room"

**不好的 description：**
- 太模糊：`"处理各种任务"`
- 太技术化：`"调用 REST API 接口"`

---

## Skill 正文编写规范

### 1. 明确的执行步骤

```markdown
## 执行步骤

1. 首先做 A
2. 然后做 B
3. 最后做 C，注意 XXX
```

### 2. 提供示例

```markdown
## 示例

**用户说**：帮我发一封邮件给张三

**执行逻辑**：
- 搜索联系人"张三"
- 获取邮件地址
- 调用发送接口
```

### 3. 明确的注意事项

```markdown
## 注意事项

- 如果找不到联系人，应提示用户确认
- 发送前必须让用户确认内容
```

### 4. 错误处理

```markdown
## 错误处理

- 如果步骤 2 失败，尝试备用方案 B
- 如果无法完成，告知用户原因并提供替代建议
```

---

## Skill 存放位置

| 位置 | 路径 | 适用范围 |
|------|------|---------|
| 全局 | `~/.catpaw/skills/<skill-name>/` | 所有项目 |
| 项目级 | `{workspace}/.catpaw/skills/<skill-name>/` | 当前项目 |

> 项目级 Skill 优先级高于全局 Skill。

---

## 上传命令

```bash
# 上传到全局（推荐）
./scripts/upload.sh my-skill --global

# 上传到项目级
./scripts/upload.sh my-skill
```

---

## 常见问题

**Q: Skill 写好了但 AI 没有触发？**
A: 检查 `description` 是否包含用户实际使用的关键词，可以尝试更口语化的描述。

**Q: 多个 Skill 都匹配了怎么办？**
A: AI 会选择最相关的一个，或者同时参考多个。建议每个 Skill 的 description 尽量不重叠。

**Q: Skill 可以调用其他 Skill 吗？**
A: 可以，在 Skill 正文中说明"先读取 XXX Skill 并遵循其指令"即可。
