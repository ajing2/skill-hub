#!/bin/bash
# ============================================================
# upload.sh - 将 skill 上传/同步到 CatDesk 本地 skills 目录
# 用法：
#   ./scripts/upload.sh                    # 上传所有 skills
#   ./scripts/upload.sh example-skill      # 上传指定 skill
#   ./scripts/upload.sh --global           # 上传到全局目录 (~/.catpaw/skills/)
#   ./scripts/upload.sh example-skill --global
# ============================================================

set -e

SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.catpaw/skills"
PROJECT_SKILLS_DIR="$(cd "$(dirname "$0")/../.." && pwd)/.catpaw/skills"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_success() { echo -e "${GREEN}[OK]${NC}    $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# 解析参数
SKILL_NAME=""
USE_GLOBAL=false

for arg in "$@"; do
  case $arg in
    --global) USE_GLOBAL=true ;;
    --*) log_warn "未知参数: $arg，已忽略" ;;
    *) SKILL_NAME="$arg" ;;
  esac
done

# 确定目标目录
if [ "$USE_GLOBAL" = true ]; then
  TARGET_DIR="$GLOBAL_SKILLS_DIR"
  log_info "目标目录：全局 ($TARGET_DIR)"
else
  TARGET_DIR="$PROJECT_SKILLS_DIR"
  log_info "目标目录：项目级 ($TARGET_DIR)"
fi

mkdir -p "$TARGET_DIR"

# 上传单个 skill
upload_skill() {
  local skill_name="$1"
  local src="$SKILLS_DIR/$skill_name"
  local dst="$TARGET_DIR/$skill_name"

  if [ ! -d "$src" ]; then
    log_error "Skill 不存在: $skill_name"
    return 1
  fi

  if [ ! -f "$src/SKILL.md" ]; then
    log_warn "跳过 $skill_name（缺少 SKILL.md）"
    return 0
  fi

  mkdir -p "$dst"
  cp -r "$src/"* "$dst/"
  log_success "已上传: $skill_name → $dst"
}

# 主逻辑
if [ -n "$SKILL_NAME" ]; then
  # 上传指定 skill
  upload_skill "$SKILL_NAME"
else
  # 上传所有 skills
  log_info "开始上传所有 skills..."
  count=0
  for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    if [ "$skill_name" = "example-skill" ]; then
      log_warn "跳过示例模板: $skill_name"
      continue
    fi
    upload_skill "$skill_name" && ((count++)) || true
  done
  log_success "完成！共上传 $count 个 skill"
fi
