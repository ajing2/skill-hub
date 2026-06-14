#!/bin/bash
# ============================================================
# upload.sh — 将 skill 上传/同步到 CatDesk 本地 skills 目录
#
# 目录结构说明：
#   skills/
#   ├── office/        办公协作类（大象、邮件、会议室等）
#   ├── data/          数据处理类（Excel、图表、清洗等）
#   ├── browser/       浏览器自动化类（抓取、截图、表单等）
#   ├── dev/           开发辅助类（代码审查、Git、测试等）
#   ├── writing/       内容创作类（周报、文档、翻译等）
#   └── _template/     模板目录（不会被上传）
#
# 用法：
#   ./scripts/upload.sh                          # 上传所有分类下的所有 skill
#   ./scripts/upload.sh office                   # 上传整个 office 分类
#   ./scripts/upload.sh office/my-skill          # 上传指定分类下的指定 skill
#   ./scripts/upload.sh --global                 # 上传到全局目录 (~/.catpaw/skills/)
#   ./scripts/upload.sh office --global          # 上传 office 分类到全局
#   ./scripts/upload.sh office/my-skill --global # 上传指定 skill 到全局
#   ./scripts/upload.sh --dry-run                # 预览将要上传的内容，不实际执行
# ============================================================

set -e

SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.catpaw/skills"
PROJECT_SKILLS_DIR="$(cd "$(dirname "$0")/../.." && pwd)/.catpaw/skills"

# 不会被上传的目录（以 _ 开头）
SKIP_CATEGORIES="_template"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}   $1"; }
log_success() { echo -e "${GREEN}[OK]${NC}     $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}   $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC}  $1"; }
log_skip()    { echo -e "${GRAY}[SKIP]${NC}   $1"; }
log_dry()     { echo -e "${CYAN}[DRY]${NC}    $1"; }

# 解析参数
TARGET_ARG=""   # 可以是 "office" 或 "office/my-skill"
USE_GLOBAL=false
DRY_RUN=false

for arg in "$@"; do
  case $arg in
    --global)  USE_GLOBAL=true ;;
    --dry-run) DRY_RUN=true ;;
    --*)       log_warn "未知参数: $arg，已忽略" ;;
    *)         TARGET_ARG="$arg" ;;
  esac
done

# 确定目标目录
if [ "$USE_GLOBAL" = true ]; then
  TARGET_BASE="$GLOBAL_SKILLS_DIR"
  TARGET_LABEL="全局 (~/.catpaw/skills/)"
else
  TARGET_BASE="$PROJECT_SKILLS_DIR"
  TARGET_LABEL="项目级 (.catpaw/skills/)"
fi

[ "$DRY_RUN" = true ] && log_info "【预览模式】不会实际写入文件" || mkdir -p "$TARGET_BASE"

echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Skill Hub 上传工具${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
log_info "目标目录：$TARGET_LABEL"
[ -n "$TARGET_ARG" ] && log_info "上传范围：$TARGET_ARG" || log_info "上传范围：全部分类"
echo ""

# 判断某个分类是否应跳过
should_skip_category() {
  local cat="$1"
  for skip in $SKIP_CATEGORIES; do
    [ "$cat" = "$skip" ] && return 0
  done
  return 1
}

# 上传单个 skill
# 参数：$1=分类名, $2=skill名
upload_skill() {
  local category="$1"
  local skill_name="$2"
  local src="$SKILLS_DIR/$category/$skill_name"
  local dst="$TARGET_BASE/$skill_name"

  if [ ! -d "$src" ]; then
    log_error "Skill 不存在: $category/$skill_name"
    return 1
  fi

  if [ ! -f "$src/SKILL.md" ]; then
    log_skip "$category/$skill_name（缺少 SKILL.md）"
    return 0
  fi

  if [ "$DRY_RUN" = true ]; then
    log_dry "$category/$skill_name  →  $dst"
  else
    mkdir -p "$dst"
    cp -r "$src/"* "$dst/"
    log_success "$category/$skill_name  →  $dst"
  fi
  return 0
}

# 上传某个分类下的所有 skill
upload_category() {
  local category="$1"
  local cat_dir="$SKILLS_DIR/$category"

  if [ ! -d "$cat_dir" ]; then
    log_error "分类不存在: $category"
    log_info "可用分类: $(ls "$SKILLS_DIR" | grep -v '^_' | tr '\n' ' ')"
    return 1
  fi

  if should_skip_category "$category"; then
    log_skip "分类 $category（保留目录，不上传）"
    return 0
  fi

  echo -e "${CYAN}  ▸ [$category]${NC}"
  local count=0
  for skill_dir in "$cat_dir"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    upload_skill "$category" "$skill_name" && ((count++)) || true
  done

  if [ "$count" -eq 0 ]; then
    log_warn "  分类 $category 下暂无 Skill"
  fi
  echo ""
}

# ── 主逻辑 ──────────────────────────────────────────────────

total=0

if [ -n "$TARGET_ARG" ]; then
  # 判断是 "category" 还是 "category/skill-name"
  if echo "$TARGET_ARG" | grep -q '/'; then
    # 指定了具体 skill：office/my-skill
    category="${TARGET_ARG%%/*}"
    skill_name="${TARGET_ARG##*/}"
    upload_skill "$category" "$skill_name"
    total=1
  else
    # 指定了分类：office
    upload_category "$TARGET_ARG"
  fi
else
  # 上传所有分类
  for cat_dir in "$SKILLS_DIR"/*/; do
    [ -d "$cat_dir" ] || continue
    category=$(basename "$cat_dir")
    upload_category "$category"
  done
fi

echo -e "${BLUE}════════════════════════════════════════════════${NC}"
if [ "$DRY_RUN" = true ]; then
  echo -e "${CYAN}  预览完成，未实际写入。去掉 --dry-run 参数后重新运行即可上传。${NC}"
else
  echo -e "${GREEN}  上传完成！${NC}"
fi
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""
