---
name: chinese-recipe-pipeline
description: "Full-pipeline Chinese recipe content generator for the chines-foods Astro blog. Given a dish name from the top-30 list, it: (1) researches the dish on Chinese recipe sites, (2) writes original SEO-optimized articles in 5 languages (ZH/EN/DE/JA/FR), (3) generates all AI food photography with recipe-image-generator, (4) embeds images into every language version, (5) saves Astro-compatible .md files to src/content/blog/. Guarantees <15% similarity to any source, 100% AI-generated images, and Google-indexable output. Use when: generating a recipe article for chines-foods, batch-producing the top-30 Chinese recipes, writing multilingual food content with original images. Triggers: generate recipe, write dish article, produce top-30 recipe, batch recipe pipeline, create recipe content for blog."
---

# Chinese Recipe Pipeline

> 一个菜谱一个菜谱地生产：研究 → 原创写作 → AI 配图 → 多语言输出 → 保存到 Astro 博客

本 skill 整合了 `chinese-recipe-writer` 和 `recipe-image-generator` 的全部能力，专为 `chines-foods` Astro 博客批量生产 30 道中餐食谱文章而设计。

---

## 核心原则（必须遵守）

1. **绝不复制**：从参考网站只提取事实（食材、时间、技法），绝不复制任何句子或段落
2. **图片全部 AI 生成**：所有图片必须通过 `GenerateImage` 工具生成，禁止使用任何网络图片
3. **相似度 < 15%**：每篇文章与任何单一来源的相似度必须低于 15%
4. **5 种语言**：每道菜必须输出 ZH / EN / DE / JA / FR 共 5 个 .md 文件
5. **Google 可收录**：每篇文章必须包含完整的 frontmatter、JSON-LD 结构化数据、hreflang 标记

---

## 输入

```
dish_name:    菜名（中文 + 英文），例如 "麻婆豆腐 Mapo Tofu"
dish_slug:    URL slug，例如 "mapo-tofu"
dish_info:    来自 top30-chinese-recipes.md 的菜系、食材、烹饪方式等基础信息
output_dir:   /Users/lingjing/catdesk/chines-foods/src/content/blog/
image_dir:    /Users/lingjing/catdesk/chines-foods/public/images/recipes/[dish-slug]/
```

---

## 完整流程（每道菜执行一次）

### PHASE 1 — 研究（Research）

**目标**：从参考网站收集事实，绝不复制文字。

**参考网站优先级**（来自 china-recipe-sites-research.md）：

| 优先级 | 网站 | URL |
|--------|------|-----|
| 1 | 美食天下 | https://www.meishichina.com |
| 2 | 美食杰 | https://www.meishij.net |
| 3 | 下厨房 | https://www.xiachufang.com |
| 4 | 豆果美食 | https://www.douguo.com |
| 5 | 香哈菜谱 | https://www.xiangha.com |

**研究步骤**：

```
1. 用浏览器访问每个网站，搜索菜名
2. 阅读找到的所有菜谱文章（至少 3 篇不同来源）
3. 提取并记录以下事实（只记录事实，不复制文字）：
   - 食材清单（含用量）
   - 烹饪步骤（动作 + 时间 + 温度）
   - 关键技法（火候、刀工、腌制等）
   - 文化背景（起源、历史、地区特色）
   - 常见变体（素食版、减辣版等）
   - 常见失败原因和解决方法
4. 整理成内部研究摘要（不发布）
```

**研究摘要格式**（内部使用，不写入最终文章）：

```markdown
## 研究摘要 [dish_name]
来源1: [URL] — 关键事实: [...]
来源2: [URL] — 关键事实: [...]
来源3: [URL] — 关键事实: [...]

核心技法: [...]
关键食材: [...]
文化故事: [...]
常见问题: [...]
```

---

### PHASE 2 — 图片生成（Image Generation）

**目标**：为每道菜生成 5 张原创 AI 食物摄影图片，保存到 `public/images/recipes/[dish-slug]/`。

**必须生成的图片**：

| 文件名 | 类型 | 用途 | 尺寸比例 |
|--------|------|------|---------|
| `[slug]-hero.webp` | 主图 / Hero Shot | 文章顶部 + OG 图 | 16:9 |
| `[slug]-ingredients.webp` | 食材平铺 | 食材列表前 | 1:1 |
| `[slug]-step-1.webp` | 步骤图1 | 关键步骤（炒底料/腌制等） | 4:3 |
| `[slug]-step-2.webp` | 步骤图2 | 关键步骤（加汤/翻炒等） | 4:3 |
| `[slug]-serving.webp` | 摆盘图 | 上桌建议部分 | 4:3 |

**图片生成 Prompt 模板**：

```
# Hero Shot
Professional food photography of [dish_name_en], [2-sentence visual description of the finished dish].
Shot from 45-degree angle. Served on [culturally appropriate plate] on dark wood surface.
Warm natural lighting from the left. Shallow depth of field, bokeh background.
Garnished with [appropriate garnish]. Steam rising gently.
Rich, appetizing colors. High-end food magazine quality, 4K resolution.
No text, no watermarks, no people.

# Ingredients Flat Lay
Overhead flat lay food photography of all ingredients for [dish_name_en].
Arranged in small ceramic bowls and wooden spoons on a clean marble surface.
Ingredients include: [list 5-8 most visually distinctive ingredients].
Soft natural lighting, clean minimalist composition. Editorial food styling quality.
No text, no watermarks.

# Step Photo (cooking action)
Close-up food photography of [specific action: e.g. "stir-frying diced chicken in a hot wok with dried chilies"].
Slight motion blur on the spatula. Visible steam and sizzle.
Warm kitchen lighting, shot from slightly above.
Shallow depth of field focused on the action. Professional cooking documentation style.
No text, no watermarks.

# Serving Shot
Professional food photography of [dish_name_en] plated for serving.
Overhead shot. Accompanied by [appropriate side dishes/condiments].
Warm, inviting atmosphere. Rustic wooden table setting.
Chopsticks placed beside the plate. Soft natural light.
No text, no watermarks.
```

**图片质量检查**（生成后必须验证）：

- [ ] 食物看起来美味可口，颜色自然
- [ ] 无文字、无水印、无 logo
- [ ] 无明显 AI 瑕疵（多余手指、变形餐具等）
- [ ] 餐具文化适配（中式碗碟、筷子等）
- [ ] 风格统一（同一道菜的所有图片色调一致）

如质量不达标，调整 prompt 重新生成。

---

### PHASE 3 — 内容写作（Content Writing）

**目标**：基于研究摘要，用自己的语言写出原创文章。

#### 3.1 中文版（ZH）— 主版本

**文件名**：`[slug]-zh.md`  
**字数目标**：2,000–4,000 字  
**语气**：亲切自然，适合微信/小红书风格

**文章结构**：

```markdown
---
[frontmatter — 见 PHASE 4]
---

![主图 alt 文字](/images/recipes/[slug]/[slug]-hero.webp)

## 一句话勾引（Hook）
[1-2句感官描述或令人惊讶的事实]

## 这道菜的故事（Story）
[文化背景、历史起源、地区特色，约 300-500 字，加入个人化叙述视角]

## 基本信息
| 准备时间 | 烹饪时间 | 份量 | 难度 | 辣度 |
|---------|---------|------|------|------|
| X 分钟 | X 分钟 | X 人份 | 简单/中等/困难 | ★☆☆ |

## 食材

![食材平铺图](/images/recipes/[slug]/[slug]-ingredients.webp)

**主料**
- [食材] [用量]（[替代品建议]）

**调料**
- [调料] [用量]

**工具**
- [必要工具]

## 步骤

### 第一步：[步骤名称]
[详细描述：一个核心动作 + 具体时间/温度 + 感官判断标准 + 为什么这样做]

![步骤图1](/images/recipes/[slug]/[slug]-step-1.webp)

### 第二步：[步骤名称]
[...]

![步骤图2](/images/recipes/[slug]/[slug]-step-2.webp)

[继续所有步骤...]

## 大厨秘诀（Pro Tips）
[3-5 条进阶技巧，包含中文烹饪术语 + 拼音]

## 上桌建议

![摆盘图](/images/recipes/[slug]/[slug]-serving.webp)

[搭配建议 + 内链到其他相关菜谱]

## 保存与复热
[2-3 句实用建议]

## 常见问题 FAQ
**Q: [真实问题1]？**
A: [详细回答]

**Q: [真实问题2]？**
A: [...]

[4-6 个 FAQ]

## 食谱卡片
[JSON-LD 结构化数据 — 见 PHASE 4]

## 推荐厨具
[2-3 个自然融入的产品推荐，标注 #ad]
```

#### 3.2 英文版（EN）— 主力 SEO 版本

**文件名**：`[slug]-en.md`  
**字数目标**：1,500–2,500 words  
**语气**：Friendly, authoritative, culturally educational  
**特别要求**：
- 使用美式计量（tbsp, cup, oz, °F）
- 解释中文烹饪术语（加拼音）
- 为不熟悉中餐的读者解释文化背景
- Amazon US 联盟链接（标注 #ad）

**文章结构**（与中文版对应，英文表达）：

```markdown
---
[frontmatter]
---

![Hero image alt text in English](/images/recipes/[slug]/[slug]-hero.webp)

## [Sensory hook — 1-2 sentences]

## The Story Behind [Dish Name]
[Cultural background, history, why it matters globally — ~300 words]

## At a Glance
| Prep Time | Cook Time | Servings | Difficulty | Spice Level |
|-----------|-----------|----------|------------|-------------|

## Ingredients

![Ingredients flat lay](/images/recipes/[slug]/[slug]-ingredients.webp)

**Main Ingredients**
- [ingredient] [US measurement] ([substitute suggestion])

**Sauce & Seasonings**
- [...]

**Equipment**
- [...]

## Instructions

### Step 1: [Action Name]
[One core action + specific time/temp + sensory cue + why]

![Step 1 photo](/images/recipes/[slug]/[slug]-step-1.webp)

[Continue all steps...]

## Pro Tips
[3-5 advanced techniques with Chinese cooking terms + pinyin]

## Serving Suggestions

![Serving photo](/images/recipes/[slug]/[slug]-serving.webp)

[Pairings + internal links to 2-3 related recipes]

## Storage & Reheating
[2-3 practical sentences]

## Frequently Asked Questions
**Can I make this vegetarian?**
[Answer...]

[4-6 FAQs targeting "People Also Ask"]

## Recipe Card
[JSON-LD structured data]

## Recommended Products
[2-3 Amazon US affiliate links, marked #ad]
```

#### 3.3 德文版（DE）

**文件名**：`[slug]-de.md`  
**字数目标**：1,200–2,000 Wörter  
**特别要求**：
- 公制计量（g, ml, °C）
- Amazon.de 联盟链接
- 提及在哪里购买亚洲食材（Asian-Laden, Asia-Supermarkt）
- 精确详细的步骤描述（德国读者偏好）

#### 3.4 日文版（JA）

**文件名**：`[slug]-ja.md`  
**字数目标**：3,000–5,000 字  
**特别要求**：
- 公制计量（グラム, ml, 大さじ, 小さじ）
- Amazon.co.jp 联盟链接
- 与日本版本的差异对比（例如：日本麻婆豆腐 vs 四川正宗版）
- 使用适当的敬体（です・ます调）

#### 3.5 法文版（FR）

**文件名**：`[slug]-fr.md`  
**字数目标**：1,200–2,000 mots  
**特别要求**：
- 公制计量（grammes, ml, °C）
- Amazon.fr 联盟链接
- 与法式烹饪技法的对比（例如：中式勾芡 vs 法式 liaison）

---

### PHASE 4 — Frontmatter & 结构化数据

#### Frontmatter 模板（Astro content.config.ts 兼容）

```yaml
---
title: "[菜名] — [副标题，含关键词]"
description: "[150字以内，含目标关键词，吸引点击]"
pubDate: [YYYY-MM-DD]
updatedDate: [YYYY-MM-DD]
heroImage: "/images/recipes/[slug]/[slug]-hero.webp"
category: "[川菜/粤菜/湘菜/鲁菜/苏菜/浙菜/闽菜/徽菜/家常菜/其他]"
cookTime: "[X 分钟]"
prepTime: "[X 分钟]"
servings: "[X 人份]"
difficulty: "[简单/中等/困难]"
tags: ["[tag1]", "[tag2]", "[tag3]"]
lang: "[zh/en/de/ja/fr]"
translations:
  zh: "[slug]-zh"
  en: "[slug]-en"
  de: "[slug]-de"
  ja: "[slug]-ja"
  fr: "[slug]-fr"
---
```

#### JSON-LD Recipe 结构化数据（每篇文章末尾嵌入）

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Recipe",
  "name": "[dish name in article language]",
  "description": "[article description]",
  "image": [
    "https://chines-foods.com/images/recipes/[slug]/[slug]-hero.webp",
    "https://chines-foods.com/images/recipes/[slug]/[slug]-ingredients.webp"
  ],
  "author": {
    "@type": "Organization",
    "name": "Chinese Foods"
  },
  "datePublished": "[YYYY-MM-DD]",
  "dateModified": "[YYYY-MM-DD]",
  "prepTime": "PT[X]M",
  "cookTime": "PT[X]M",
  "totalTime": "PT[X]M",
  "recipeYield": "[X servings]",
  "recipeCategory": "[category]",
  "recipeCuisine": "Chinese",
  "keywords": "[keyword1, keyword2, keyword3]",
  "recipeIngredient": [
    "[ingredient 1 with amount]",
    "[ingredient 2 with amount]"
  ],
  "recipeInstructions": [
    {
      "@type": "HowToStep",
      "name": "[step name]",
      "text": "[step description]",
      "image": "https://chines-foods.com/images/recipes/[slug]/[slug]-step-1.webp"
    }
  ],
  "nutrition": {
    "@type": "NutritionInformation",
    "calories": "[X calories]"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "127"
  }
}
</script>
```

#### hreflang 标记（在每篇文章的 frontmatter 中通过 translations 字段自动生成）

```html
<link rel="alternate" hreflang="zh" href="https://chines-foods.com/zh/[slug]-zh/" />
<link rel="alternate" hreflang="en" href="https://chines-foods.com/[slug]-en/" />
<link rel="alternate" hreflang="de" href="https://chines-foods.com/de/[slug]-de/" />
<link rel="alternate" hreflang="ja" href="https://chines-foods.com/ja/[slug]-ja/" />
<link rel="alternate" hreflang="fr" href="https://chines-foods.com/fr/[slug]-fr/" />
<link rel="alternate" hreflang="x-default" href="https://chines-foods.com/[slug]-en/" />
```

---

### PHASE 5 — SEO 关键词策略

每道菜在每种语言中需要确定：

| 字段 | 要求 |
|------|------|
| 主关键词 | 搜索量最高的精确菜名（如 "mapo tofu recipe"） |
| 次关键词1 | 带修饰词（如 "authentic mapo tofu"、"easy mapo tofu"） |
| 次关键词2 | 长尾词（如 "mapo tofu without meat vegetarian"） |
| Title Tag | EN/DE/FR ≤60字符，ZH ≤30字，JA ≤30全角字 |
| Meta Description | EN/DE/FR ≤160字符，ZH/JA ≤80字 |

**SEO 写作规则**：
- 主关键词出现在：标题、第一段、至少一个 H2、meta description、图片 alt
- 不堆砌关键词，自然融入
- 每篇文章内链到 2-3 篇相关菜谱文章
- FAQ 部分针对 Google "People Also Ask" 框

---

### PHASE 6 — 去重与版权检查

**写作时的去重规则**：

1. 研究阶段只记录事实，不记录原文表达
2. 每个步骤用自己的语言重新描述，加入感官细节（声音、颜色、气味）
3. 加入独特视角：文化故事、失败经验、专业技巧
4. 中文烹饪术语 + 拼音是独特价值，参考网站通常没有
5. 多语言版本之间也要有差异化表达，不能是机械翻译

**自检清单**：

- [ ] 没有连续 5 个以上相同的词组来自任何参考来源
- [ ] 文章结构与参考来源不同（不同的章节顺序）
- [ ] 加入了参考来源没有的独特内容（文化背景、失败原因、变体建议）
- [ ] 所有图片均为 AI 生成，无任何网络图片
- [ ] 联盟链接已标注 #ad 或 "Affiliate link"

---

### PHASE 7 — 文件保存

**输出目录结构**：

```
chines-foods/
├── src/content/blog/
│   ├── [slug]-zh.md          ← 中文版
│   ├── [slug]-en.md          ← 英文版
│   ├── [slug]-de.md          ← 德文版
│   ├── [slug]-ja.md          ← 日文版
│   └── [slug]-fr.md          ← 法文版
└── public/images/recipes/
    └── [slug]/
        ├── [slug]-hero.webp
        ├── [slug]-ingredients.webp
        ├── [slug]-step-1.webp
        ├── [slug]-step-2.webp
        └── [slug]-serving.webp
```

**保存前检查**：

- [ ] 所有 5 个 .md 文件的 frontmatter 字段完整
- [ ] 所有图片路径在文章中正确引用
- [ ] 所有 5 张图片文件已保存到 public/images/recipes/[slug]/
- [ ] JSON-LD 结构化数据语法正确（可用 Google Rich Results Test 验证）
- [ ] translations 字段中 5 种语言互相引用正确

---

## 批量处理 30 道菜的执行顺序

按 Google 搜索热度从高到低处理，每次处理一道菜，完成后再处理下一道：

```
批次1（★★★★★ 最高热度，优先处理）：
 1. kung-pao-chicken      宫保鸡丁
 2. peking-duck           北京烤鸭
 3. mapo-tofu             麻婆豆腐
 4. xiao-long-bao         小笼包
 5. dumplings-jiaozi      饺子
 6. fried-rice            炒饭
 7. chow-mein             炒面
 8. sweet-and-sour-pork   糖醋里脊
 9. hot-pot               火锅
10. dim-sum               点心

批次2（★★★★☆ 高热度）：
11. red-braised-pork-belly  红烧肉
12. spring-rolls            春卷
13. dan-dan-noodles         担担面
14. buddha-jumps-wall       佛跳墙
15. congee                  粥
16. egg-fried-rice          蛋炒饭
17. wonton-soup             馄饨
18. twice-cooked-pork       回锅肉
19. jianbing                煎饼果子
20. tang-yuan               汤圆

批次3（★★★☆☆ 中等热度）：
21. fish-fragrant-pork      鱼香肉丝
22. husband-wife-beef       夫妻肺片
23. char-siu                叉烧
24. dongpo-pork             东坡肉
25. white-cut-chicken       白切鸡
26. yangzhou-fried-rice     扬州炒饭
27. lanzhou-beef-noodles    兰州拉面
28. tea-eggs                茶叶蛋
29. biang-biang-noodles     裤带面
30. di-san-xian             地三鲜
```

---

## 单道菜执行 Checklist

处理每道菜时，按顺序完成以下步骤：

```
[ ] PHASE 1: 研究
    [ ] 访问至少 3 个参考网站，搜索该菜名
    [ ] 阅读所有找到的菜谱文章
    [ ] 整理内部研究摘要（事实，不复制文字）

[ ] PHASE 2: 图片生成
    [ ] 创建图片目录 public/images/recipes/[slug]/
    [ ] 生成 hero shot（16:9）
    [ ] 生成 ingredients flat lay（1:1）
    [ ] 生成 step-1 cooking action（4:3）
    [ ] 生成 step-2 cooking action（4:3）
    [ ] 生成 serving shot（4:3）
    [ ] 验证所有图片质量

[ ] PHASE 3: 写作
    [ ] 写中文版（ZH）2000-4000字
    [ ] 写英文版（EN）1500-2500 words
    [ ] 写德文版（DE）1200-2000 Wörter
    [ ] 写日文版（JA）3000-5000字
    [ ] 写法文版（FR）1200-2000 mots
    [ ] 每篇文章嵌入对应语言的图片 alt 标签

[ ] PHASE 4: Frontmatter & 结构化数据
    [ ] 每篇文章 frontmatter 字段完整
    [ ] 每篇文章末尾嵌入 JSON-LD
    [ ] translations 字段互相引用正确

[ ] PHASE 5: SEO
    [ ] 每种语言确定主关键词 + 2个次关键词
    [ ] Title Tag 长度符合要求
    [ ] Meta Description 长度符合要求
    [ ] 主关键词出现在标题、第一段、H2、alt

[ ] PHASE 6: 去重检查
    [ ] 无连续5词组来自参考来源
    [ ] 文章结构与参考来源不同
    [ ] 加入了独特内容
    [ ] 所有图片为 AI 生成

[ ] PHASE 7: 保存
    [ ] 5个 .md 文件保存到 src/content/blog/
    [ ] 5张图片保存到 public/images/recipes/[slug]/
    [ ] 文件命名规范正确
```

---

## 参考资源路径

```
菜谱列表:    /Users/lingjing/catdesk/chines-foods/src/data/top30-chinese-recipes.md
参考网站:    /Users/lingjing/catdesk/chines-foods/src/data/china-recipe-sites-research.md
文章输出:    /Users/lingjing/catdesk/chines-foods/src/content/blog/
图片输出:    /Users/lingjing/catdesk/chines-foods/public/images/recipes/
已有示例:    /Users/lingjing/catdesk/chines-foods/src/content/blog/mapo-tofu.md（参考格式）
Schema定义: /Users/lingjing/catdesk/chines-foods/src/content.config.ts
```

---

## 时间估算（每道菜）

| 阶段 | 时间 |
|------|------|
| PHASE 1 研究 | ~30 分钟 |
| PHASE 2 图片生成（5张） | ~20 分钟 |
| PHASE 3 写作（5种语言） | ~90 分钟 |
| PHASE 4 Frontmatter + JSON-LD | ~15 分钟 |
| PHASE 5 SEO 优化 | ~15 分钟 |
| PHASE 6 去重检查 | ~10 分钟 |
| PHASE 7 保存验证 | ~10 分钟 |
| **合计** | **~3 小时/道菜** |

30 道菜总计约 90 小时内容生产工作量。

---

## 注意事项

- **不要跳过研究阶段**：即使你知道这道菜，也要访问参考网站，确保食材用量准确
- **图片必须先生成**：写文章时需要引用图片路径，所以图片要在写作前完成
- **中文版是主版本**：先写中文，再写英文，其他语言基于英文翻译+本地化
- **每道菜独立完成**：不要同时处理多道菜，确保每道菜的质量
- **保持风格一致**：30 道菜的文章风格、结构、图片风格要保持一致，形成品牌感
