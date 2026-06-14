---
name: chinese-recipe-writer
description: Write, translate, and polish multilingual Chinese recipe articles (中餐食谱) with rich historical stories, cultural background, and SEO optimization. Use this skill whenever the user wants to create a new Chinese recipe article, translate an existing recipe into multiple languages (zh/en/de/ja/fr), add cultural/historical content to recipes, polish or improve recipe articles, optimize recipe SEO, or produce content for a Chinese food blog. Also trigger when the user mentions 食谱写作, recipe writing, multilingual food content, Chinese food culture, or asks to write about any Chinese dish.
---

# Chinese Recipe Multilingual Article Writer

This skill produces high-quality, SEO-optimized, multilingual Chinese recipe articles that stand out from competitors through rich historical storytelling and cultural depth. Every article must help foreign readers understand Chinese culinary culture, not just follow cooking steps.

## Core Philosophy

The key differentiator of our recipe content is **cultural depth**. Every recipe tells a story — the history behind the dish, the cultural significance, the regional traditions, and the human connections. This is what makes readers stay longer (improving dwell time for SEO) and what makes our content impossible to replicate by generic recipe sites.

**Three non-negotiable principles:**

1. Every recipe MUST include historical stories and cultural background (历史典故和文化背景) — this is the most important requirement
2. When translating for foreign audiences, explain Chinese cultural concepts in ways they can relate to (not just literal translation)
3. Content must be SEO-optimized, deduplicated against existing content, and structured for Google discoverability

---

## Article Structure Standard (文章结构规范)

Every recipe article MUST follow this **exact structure and heading hierarchy**. The structure is designed for maximum readability — readers should be able to scan the article and instantly find any section they need.

### Heading Hierarchy Rules (标题层级规则)

```
H1: [Article Title — in frontmatter only, never in body]
H2: Major sections (历史典故 / 食材 / 做法 / 小贴士 / 搭配建议 / 保存方法 / 常见问题 / 营养信息)
H3: Sub-sections within steps (步骤1 / 步骤2 / ...) or sub-topics
```

**Strict rules:**
- NEVER use H1 in the article body (the title in frontmatter is the H1)
- NEVER skip heading levels (no H2 → H4)
- Every H2 section MUST be separated by a horizontal rule (`---`)
- H2 headings MUST use emoji prefix for visual scanning (see template below)

### Visual Structure Template (视觉结构模板)

Below is the EXACT structure every article must follow. The emoji prefixes and horizontal rules are mandatory — they create visual rhythm and make the article scannable.

```markdown
[Hook paragraph — 1-2 compelling sentences, NO heading]

---

## 📜 [Historical Story Title]

[200-300 words of historical/cultural content]

[Optional: cultural comparison paragraph for foreign audiences]

---

## ⏱ Quick Info

[Quick reference card with prep time, cook time, servings, difficulty, spice level]

---

## 🥘 Ingredients

**[Group Name 1]**
- item 1
- item 2

**[Group Name 2]**
- item 1
- item 2

---

## 👨‍🍳 Instructions

### Step 1: [Action Name]

[1-2 sentences: what to do + sensory cues + why]

### Step 2: [Action Name]

[1-2 sentences: what to do + sensory cues + why]

[... continue for all steps]

---

## 💡 Pro Tips

**[Tip title]**: [Explanation with science/tradition behind it]

**[Tip title]**: [Explanation]

[3-5 tips total]

---

## 🍽 Serving Suggestions

[Complementary dishes, meal composition philosophy, internal links]

---

## 🧊 Storage & Reheating

[Practical storage info: fridge duration, reheating method, freezing suitability]

---

## ❓ FAQ

**Q: [Question 1]**
A: [Answer]

**Q: [Question 2]**
A: [Answer]

[4-6 questions targeting "People Also Ask"]

---

## 📊 Nutrition (per serving)

| Item | Amount |
|------|--------|
| Calories | ... |
| Protein | ... |
| Fat | ... |
| Carbs | ... |
| Sodium | ... |
```

---

## Section Details (各部分详细要求)

### Part 1: Hook (开篇钩子)

1-2 sentences that immediately grab attention. Place BEFORE the first `---` divider. No heading needed.

Techniques:
- Sensory description ("The sizzle of chicken hitting a smoking-hot wok...")
- Surprising fact ("This dish is named after a real governor who executed the Empress's favorite eunuch...")
- Compelling question ("What makes a 150-year-old recipe still the #1 comfort food in Sichuan?")

### Part 2: Historical & Cultural Story (📜 历史典故)

**This is the MOST CRITICAL section — the soul of every article.**

The H2 heading should be descriptive and intriguing, not generic. Examples:
- ✅ `## 📜 宫保鸡丁的前世今生 — 一位总督的美食传奇`
- ✅ `## 📜 The Story Behind Kung Pao Chicken — A Governor's Legacy`
- ❌ `## History` (too generic)
- ❌ `## Background` (boring)

Content requirements (200-300 words):
- WHO created/popularized this dish? (real historical figures preferred)
- WHEN and WHERE did it originate?
- HOW has it evolved over time?
- WHY is it culturally significant?
- Include at least ONE surprising anecdote that readers will want to share

**Cross-cultural adaptation (critical for non-ZH versions):**
- EN: Compare to Western culinary traditions ("Think of it as China's answer to mac and cheese — pure comfort food")
- DE: Reference precision and technique that German readers appreciate
- JA: Note connections to Japanese adaptations (日式中華) and highlight authentic differences
- FR: Draw parallels to French culinary philosophy (terroir, AOC, technique)

### Part 3: Quick Info (⏱ 速览)

Use this exact format for visual consistency:

```markdown
## ⏱ Quick Info

| | |
|---|---|
| ⏱ Prep Time | [X] minutes |
| 🔥 Cook Time | [X] minutes |
| 🍽 Servings | [X] |
| 📊 Difficulty | Easy / Medium / Hard |
| 🌶 Spice Level | Mild / Medium / Hot (adjustable) |
```

### Part 4: Ingredients (🥘 食材)

Group ingredients logically with bold group headers:
- **Main Ingredients** (主料)
- **Marinade** (腌料)
- **Sauce** (调味汁)
- **Aromatics & Others** (香料及其他)

For each key ingredient:
- Include Chinese name in parentheses for authenticity
- Provide substitution options based on target market
- Recommend specific brands where relevant

**Localization rules:**
- ZH: Metric (克, 毫升, 汤匙, 茶匙)
- EN: US measurements (tablespoon, cup, oz) with metric in parentheses
- DE: Metric (Gramm, ml, EL, TL), reference German supermarkets
- JA: Japanese measurements (グラム, ml, 大さじ, 小さじ)
- FR: Metric (grammes, ml, c. à soupe, c. à café)

### Part 5: Instructions (👨‍🍳 做法)

Each step is an H3 with this pattern: `### Step N: [Verb + Object]`

Each step body contains:
1. **One core action** (start with a verb)
2. **Sensory cues** ("until fragrant", "until golden", "until the oil shimmers")
3. **Timing** (specific seconds/minutes)
4. **Why** (brief explanation of the technique)

Example:
```markdown
### Step 3: Fry the Chilies Until Fragrant

Heat oil over medium heat until it shimmers. Add dried chili sections and fry gently for 20 seconds — you'll see them darken and the kitchen will fill with a smoky, toasty aroma. This step extracts the capsaicin into the oil (炒出红油), creating the flavor base for the entire dish. If using doubanjiang, add it now and stir until the oil turns deep red.
```

### Part 6: Pro Tips (💡 大厨小贴士)

3-5 tips, each with:
- Bold title summarizing the tip
- 1-2 sentence explanation including the science or tradition behind it

### Part 7: Serving Suggestions (🍽 搭配建议)

- Recommend 2-3 complementary dishes
- Explain traditional Chinese meal composition (荤素搭配, 色香味俱全)
- Include internal links to other recipes on the site

### Part 8: Storage & Reheating (🧊 保存与加热)

Practical info in 2-3 sentences:
- Refrigerator: how many days
- Reheating method: wok vs microwave, what to avoid
- Freezing: suitable or not, and why

### Part 9: FAQ (❓ 常见问题)

4-6 questions in Q&A format. Target "People Also Ask" positions in Google.

Each language version should have questions relevant to THAT audience:
- EN: "Where can I buy doubanjiang?", "Is this dish gluten-free?"
- DE: "Wo bekomme ich Sichuan-Pfeffer?", "Kann ich normalen Pfeffer verwenden?"
- JA: "日本の宮保鶏丁との違いは？", "花椒はどこで買える？"
- FR: "Où trouver du poivre du Sichuan à Paris?", "Peut-on remplacer le vin de Shaoxing?"
- ZH: "宫保鸡丁用鸡胸肉还是鸡腿肉？", "没有花椒可以做吗？"

### Part 10: Nutrition (📊 营养信息)

Simple table format. Per serving values. Include: Calories, Protein, Fat, Carbs, Sodium.

---

## SEO Requirements

### Word Count Targets

| Language | Target Range | Notes |
|----------|-------------|-------|
| 🇺🇸 EN | 1,500-2,500 words | Google sweet spot for recipes |
| 🇨🇳 ZH | 2,000-4,000 汉字 | Below 2,000 = thin content for Baidu |
| 🇩🇪 DE | 1,200-2,000 Wörter | German words are longer, same info density |
| 🇯🇵 JA | 3,000-5,000 文字数 | Kanji+kana mix = high density |
| 🇫🇷 FR | 1,200-2,000 mots | French is relatively compact |

**Word count red lines:**
- Below minimum → Google may judge as thin content
- Above maximum → bounce rate increases
- FAQ and Serving Suggestions are natural word count adjusters

### SEO Meta (per language)

Each article needs language-specific SEO metadata:

```
Title Tag: [Dish Name] + [Core Selling Point] (≤60 chars EN / ≤30 chars ZH)
Meta Description: ≤160 chars EN / ≤80 chars ZH
URL Slug: /blog/[dish-name]-[lang]/
```

### Deduplication Rules

1. Check existing articles before writing
2. If a recipe exists, enhance it rather than creating a duplicate
3. Each language version must be unique content (not machine-translated copies)
4. Vary sentence structures across language versions

### Google Discoverability

- Recipe JSON-LD structured data (enables rich snippets)
- hreflang tags linking all 5 language versions
- Internal links to 2-3 related recipes
- Image alt tags in target language
- One H1 only, clear H2/H3 hierarchy

---

## Multilingual Production Workflow

```
Step 1: Research — history, cultural background, regional variations
Step 2: Write Chinese master version (中文母版) with full cultural content
Step 3: Generate English version (primary revenue version — invest most effort)
Step 4: Adapt to German, Japanese, French
Step 5: Localize each version (ingredients, measurements, cultural references)
Step 6: Optimize SEO metadata per language
Step 7: Final quality check — structure, word count, links
```

### Language-Specific Tone

- **ZH:** 温暖亲切，像朋友分享私房菜。可用网络用语。
- **EN:** Warm, authoritative, storytelling tone. Explain all cultural concepts. Primary revenue version.
- **DE:** Precise and detailed. Germans appreciate exactness. More technical language.
- **JA:** Polite, note differences from 日式中華. Emphasize 本格中華.
- **FR:** Elegant, draw parallels to French culinary philosophy. Reference terroir concept.

---

## Quality Checklist

### Structure Check (结构检查):
- [ ] Hook paragraph present before first `---`
- [ ] All H2 sections have emoji prefix
- [ ] All H2 sections separated by `---` horizontal rules
- [ ] No H1 in body (only in frontmatter title)
- [ ] No skipped heading levels
- [ ] Steps use H3 with `Step N: [Action]` format
- [ ] Article is scannable — reader can find any section in 2 seconds

### Content Check (内容检查):
- [ ] Historical/cultural story is 200-300 words with real facts
- [ ] Story section has at least one surprising/shareable anecdote
- [ ] Measurements match target market conventions
- [ ] Sensory cues in every cooking step
- [ ] 3-5 pro tips with explanations
- [ ] 4-6 FAQ questions relevant to local audience
- [ ] Serving suggestions with internal links

### SEO Check (SEO 检查):
- [ ] Title tag within length limit
- [ ] Meta description within length limit
- [ ] Word count within target range
- [ ] Recipe JSON-LD present (if applicable)
- [ ] Internal links to 2-3 related recipes

### Cross-Language Check (跨语言检查):
- [ ] All 5 versions produced (ZH/EN/DE/JA/FR)
- [ ] Cultural explanations adapted per audience (not just translated)
- [ ] DE version has extra-detailed step descriptions
- [ ] JA version includes "difference from Japanese version" talking point
- [ ] FR version includes Chinese-French technique comparisons

---

## File Format

Articles are Markdown files in `src/content/blog/` with this frontmatter:

```yaml
---
title: "[Article Title]"
description: "[Meta description for SEO]"
pubDate: [YYYY-MM-DD]
heroImage: "/images/recipes/[dish-name]/hero.jpg"
category: "[菜系]"
cookTime: "[X] min"
prepTime: "[X] min"
servings: "Serves [X]"
difficulty: "[简单/中等/困难]"
tags: ["tag1", "tag2", ...]
lang: "[zh|en|de|ja|fr]"
translations:
  zh: "[dish-name]-zh"
  en: "[dish-name]-en"
  de: "[dish-name]-de"
  ja: "[dish-name]-ja"
  fr: "[dish-name]-fr"
---
```

**File naming:** `[dish-name]-[lang].md` (e.g., `kung-pao-chicken-en.md`)
