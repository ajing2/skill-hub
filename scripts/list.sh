#!/bin/bash
# ============================================================
# list.sh - 列出所有 skills 及其状态
# 用法：./scripts/list.sh
# ============================================================

SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.catpaw/skills"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
NC='\033[0m'

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Skill Hub - Skills 列表${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

printf "%-30s %-10s %-20s %s\n" "Skill 名称" "版本" "作者" "已安装"
printf "%-30s %-10s %-20s %s\n" "----------" "----" "----" "------"

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_dir")
  skill_md="$skill_dir/SKILL.md"

  if [ ! -f "$skill_md" ]; then
    continue
  fi

  # 提取 version 和 author
  version=$(grep -m1 'version:' "$skill_md" | sed 's/.*version: *"\?\([^"]*\)"\?.*/\1/' | tr -d ' ')
  author=$(grep -m1 'author:' "$skill_md" | sed 's/.*author: *"\?\([^"]*\)"\?.*/\1/' | tr -d ' ')
  version="${version:-N/A}"
  author="${author:-N/A}"

  # 检查是否已安装到全局
  if [ -d "$GLOBAL_SKILLS_DIR/$skill_name" ]; then
    installed="${GREEN}✓ 全局${NC}"
  else
    installed="${YELLOW}✗ 未安装${NC}"
  fi

  printf "%-30s %-10s %-20s " "$skill_name" "$version" "$author"
  echo -e "$installed"
done

echo ""
echo -e "${GRAY}提示：运行 ./scripts/upload.sh --global 可一键安装所有 skills${NC}"
echo ""
