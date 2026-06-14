#!/bin/bash
# ============================================================
# new-skill.sh — 快速创建一个新的 Skill
#
# 分类说明：
#   office   办公协作类（大象、邮件、会议室、日程等）
#   data     数据处理类（Excel、图表、数据清洗等）
#   browser  浏览器自动化类（抓取、截图、表单等）
#   dev      开发辅助类（代码审查、Git、测试、文档等）
#   writing  内容创作类（周报、文档润色、翻译等）
#
# 用法：
#   ./scripts/new-skill.sh <category> <skill-name>
#
# 示例：
#   ./scripts/new-skill.sh office send-elephant-msg
#   ./scripts/new-skill.sh dev    code-review
#   ./scripts/new-skill.sh data   excel-analyzer
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}   $1"; }
log_success() { echo -e "${GREEN}[OK]${NC}     $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC}  $1"; }

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPTS_DIR/../skills" && pwd)"
TODAY=$(date +%Y-%m-%d)
AUTHOR=$(git -C "$SCRIPTS_DIR" config user.name 2>/dev/null || echo "lingjing")

# 有效分类列表
VALID_CATEGORIES="office data browser dev writing"

# ── 参数校验 ────────────────────────────────────────────────

CATEGORY="$1"
SKILL_NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$SKILL_NAME" ]; then
  echo ""
  echo -e "${RED}用法：${NC} ./scripts/new-skill.sh <category> <skill-name>"
  echo ""
  echo -e "${CYAN}可用分类：${NC}"
  echo "  office   — 办公协作类（大象消息、邮件、会议室、日程）"
  echo "  data     — 数据处理类（Excel、图表、数据清洗）"
  echo "  browser  — 浏览器自动化类（抓取、截图、表单）"
  echo "  dev      — 开发辅助类（代码审查、Git、测试）"
  echo "  writing  — 内容创作类（周报、文档润色、翻译）"
  echo ""
  echo -e "${CYAN}示例：${NC}"
  echo "  ./scripts/new-skill.sh office  send-elephant-msg"
  echo "  ./scripts/new-skill.sh dev     code-review"
  echo "  ./scripts/new-skill.sh data    excel-analyzer"
  echo ""
  exit 1
fi

# 校验分类是否合法
valid=false
for cat in $VALID_CATEGORIES; do
  [ "$CATEGORY" = "$cat" ] && valid=true && break
done

if [ "$valid" = false ]; then
  log_error "无效分类: '$CATEGORY'"
  echo -e "  可用分类: ${CYAN}$VALID_CATEGORIES${NC}"
  exit 1
fi

SKILL_DIR="$SKILLS_DIR/$CATEGORY/$SKILL_NAME"

if [ -d "$SKILL_DIR" ]; then
  log_error "Skill 已存在: $CATEGORY/$SKILL_NAME"
  exit 1
fi

# ── 生成 SKILL.md ────────────────────────────────────────────

mkdir -p "$SKILL_DIR"

# 根据分类生成对应的描述模板
case "$CATEGORY" in
  office)
    CATEGORY_CN="办公协作"
    TRIGGER_HINT="当用户提到发消息、发邮件、订会议室、查日程等办公操作时使用"
    ;;
  data)
    CATEGORY_CN="数据处理"
    TRIGGER_HINT="当用户需要处理 Excel/CSV、生成图表、分析数据、清洗数据时使用"
    ;;
  browser)
    CATEGORY_CN="浏览器自动化"
    TRIGGER_HINT="当用户需要操作网页、抓取数据、填写表单、截图时使用"
    ;;
  dev)
    CATEGORY_CN="开发辅助"
    TRIGGER_HINT="当用户需要代码审查、生成测试、写 commit message、生成文档时使用"
    ;;
  writing)
    CATEGORY_CN="内容创作"
    TRIGGER_HINT="当用户需要写周报、润色文档、生成 PPT 大纲、翻译内容时使用"
    ;;
esac

# 将 skill-name 转为标题格式（my-skill → My Skill）
SKILL_TITLE=$(echo "$SKILL_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}')

cat > "$SKILL_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
description: "TODO: 填写触发描述。$TRIGGER_HINT。"
metadata:
  version: "1.0.0"
  author: "$AUTHOR"
  created: "$TODAY"
  category: "$CATEGORY"
  category_cn: "$CATEGORY_CN"
  tags:
    - $CATEGORY
---

# $SKILL_TITLE

## 功能说明

TODO: 描述这个 Skill 的具体功能和使用场景。

## 触发场景

当用户说以下内容时，应使用此 Skill：

- 场景示例 1
- 场景示例 2

## 前置条件

- 条件 1（如：需要登录 XX 系统）
- 无特殊前置条件

## 执行步骤

1. 第一步：做什么
2. 第二步：做什么
3. 第三步：做什么，注意 XXX

## 输出说明

执行完成后，应向用户返回：

- 返回内容 1
- 返回内容 2

## 错误处理

- 如果步骤 X 失败：尝试 YYY，或提示用户 ZZZ
- 如果找不到目标：告知用户并提供替代方案

## 注意事项

- 注意事项 1
- 注意事项 2
EOF

# ── 完成提示 ────────────────────────────────────────────────

echo ""
echo -e "${GREEN}✓ Skill 创建成功！${NC}"
echo ""
echo -e "  ${CYAN}分类${NC}：$CATEGORY_CN ($CATEGORY)"
echo -e "  ${CYAN}路径${NC}：$SKILL_DIR/SKILL.md"
echo ""
echo -e "${YELLOW}下一步：${NC}"
echo "  1. 编辑 SKILL.md，完善 description 和执行步骤"
echo "     $SKILL_DIR/SKILL.md"
echo ""
echo "  2. 上传到本地 CatDesk 生效："
echo "     ./scripts/upload.sh $CATEGORY/$SKILL_NAME --global"
echo ""
echo "  3. 推送到 GitHub 备份："
echo "     git add . && git commit -m \"feat($CATEGORY): add $SKILL_NAME\" && git push"
echo ""
