#!/bin/bash
# ============================================================
# list.sh — 按分类列出所有 Skills 及安装状态
# 用法：./scripts/list.sh
# ============================================================

SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.catpaw/skills"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
BOLD='\033[1m'
NC='\033[0m'

# 分类中文名映射
category_cn() {
  case "$1" in
    office)  echo "办公协作" ;;
    data)    echo "数据处理" ;;
    browser) echo "浏览器自动化" ;;
    dev)     echo "开发辅助" ;;
    writing) echo "内容创作" ;;
    *)       echo "$1" ;;
  esac
}

# 分类图标映射
category_icon() {
  case "$1" in
    office)  echo "📋" ;;
    data)    echo "📊" ;;
    browser) echo "🌐" ;;
    dev)     echo "💻" ;;
    writing) echo "✍️ " ;;
    *)       echo "📦" ;;
  esac
}

echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║              Skill Hub — Skills 总览                ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

total_skills=0
total_installed=0

for cat_dir in "$SKILLS_DIR"/*/; do
  [ -d "$cat_dir" ] || continue
  category=$(basename "$cat_dir")

  # 跳过 _template 等保留目录
  [[ "$category" == _* ]] && continue

  icon=$(category_icon "$category")
  cn=$(category_cn "$category")

  # 统计该分类下的 skill 数量
  skill_count=0
  for skill_dir in "$cat_dir"*/; do
    [ -f "$skill_dir/SKILL.md" ] && ((skill_count++)) || true
  done

  echo -e "${CYAN}${icon} ${BOLD}${category}${NC}${CYAN} — ${cn}${NC}  ${GRAY}(${skill_count} 个 Skill)${NC}"
  echo -e "${GRAY}  ─────────────────────────────────────────────────────${NC}"

  if [ "$skill_count" -eq 0 ]; then
    echo -e "  ${GRAY}（暂无 Skill，运行 ./scripts/new-skill.sh ${category} <name> 创建）${NC}"
    echo ""
    continue
  fi

  printf "  ${GRAY}%-28s %-10s %-16s %s${NC}\n" "Skill 名称" "版本" "作者" "安装状态"

  for skill_dir in "$cat_dir"*/; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    skill_md="$skill_dir/SKILL.md"
    [ -f "$skill_md" ] || continue

    version=$(grep -m1 'version:' "$skill_md" 2>/dev/null | sed 's/.*version: *"\?\([^"]*\)"\?.*/\1/' | tr -d ' ')
    author=$(grep -m1 'author:' "$skill_md" 2>/dev/null | sed 's/.*author: *"\?\([^"]*\)"\?.*/\1/' | tr -d ' ')
    version="${version:-N/A}"
    author="${author:-N/A}"

    if [ -d "$GLOBAL_SKILLS_DIR/$skill_name" ]; then
      status="${GREEN}✓ 已安装（全局）${NC}"
      ((total_installed++))
    else
      status="${YELLOW}✗ 未安装${NC}"
    fi

    printf "  %-28s %-10s %-16s " "$skill_name" "$version" "$author"
    echo -e "$status"
    ((total_skills++))
  done
  echo ""
done

# 汇总
echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
echo -e "  共 ${BOLD}${total_skills}${NC} 个 Skill，已安装 ${GREEN}${BOLD}${total_installed}${NC} 个，未安装 ${YELLOW}$((total_skills - total_installed))${NC} 个"
echo ""
echo -e "${GRAY}  常用命令：${NC}"
echo -e "${GRAY}  ./scripts/new-skill.sh <category> <name>   创建新 Skill${NC}"
echo -e "${GRAY}  ./scripts/upload.sh --global               安装所有 Skill${NC}"
echo -e "${GRAY}  ./scripts/upload.sh <category> --global    安装某分类${NC}"
echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
echo ""
