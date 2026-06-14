#!/bin/bash
# ============================================================
# new-skill.sh - 快速创建一个新的 Skill 模板
# 用法：./scripts/new-skill.sh <skill-name>
# 示例：./scripts/new-skill.sh my-awesome-skill
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_success() { echo -e "${GREEN}[OK]${NC}    $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

SKILL_NAME="$1"
SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
TODAY=$(date +%Y-%m-%d)
AUTHOR=$(git config user.name 2>/dev/null || echo "lingjing")

if [ -z "$SKILL_NAME" ]; then
  log_error "请提供 Skill 名称"
  echo "用法: ./scripts/new-skill.sh <skill-name>"
  exit 1
fi

SKILL_DIR="$SKILLS_DIR/$SKILL_NAME"

if [ -d "$SKILL_DIR" ]; then
  log_error "Skill 已存在: $SKILL_NAME"
  exit 1
fi

mkdir -p "$SKILL_DIR"

cat > "$SKILL_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
description: "请在这里填写 Skill 的描述，清晰说明触发场景和功能。"
metadata:
  version: "1.0.0"
  author: "$AUTHOR"
  created: "$TODAY"
  tags:
    - custom
---

# $(echo "$SKILL_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}')

## 功能说明

TODO: 描述这个 Skill 的具体功能。

## 触发场景

当用户提到以下内容时触发此 Skill：
- 场景 1
- 场景 2

## 执行步骤

1. 步骤一
2. 步骤二
3. 步骤三

## 注意事项

- 注意事项 1
EOF

log_success "已创建 Skill: $SKILL_NAME"
log_info "路径: $SKILL_DIR/SKILL.md"
echo ""
echo "下一步："
echo "  1. 编辑 $SKILL_DIR/SKILL.md"
echo "  2. 运行 ./scripts/upload.sh $SKILL_NAME --global 上传到本地"
echo "  3. 运行 git add . && git commit && git push 同步到 GitHub"
