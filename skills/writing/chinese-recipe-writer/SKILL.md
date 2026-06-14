---
name: chinese-recipe-writer
description: "Multi-language Chinese food recipe article writer with integrated image generation. Generates SEO-optimized recipe articles in 5 languages (EN/ZH/DE/JA/FR) with original AI food photography, proper word counts, affiliate links, structured data, and cultural adaptation. Supports reference images for style-consistent photo generation and reference documents/URLs for content research. Use when: writing a Chinese recipe blog post, creating multilingual food content, generating SEO recipe articles, writing Chinese food articles for international audiences, generating recipe images from reference photos. Triggers: write recipe, write article, new recipe post, create recipe content, Chinese food article, multilingual recipe, SEO recipe, generate recipe blog post, write mapo tofu article, create dumpling recipe, food blog content, recipe with images, reference image recipe."
---

# Chinese Recipe Article Writer

Generate SEO-optimized, multilingual Chinese food recipe articles with original AI-generated food photography. Each article produces 5 language versions with proper cultural adaptation, original images, and monetization.

## Workflow Overview

```
1. Input & Research
   ├── Reference images provided? → Invoke recipe-image-generator skill
   ├── Reference documents/URLs provided? → Summarize key points (do NOT copy)
   └── Research keywords for all 5 languages

2. Content Production
   ├── Draft Chinese master version
   ├── Generate English version (primary, most polished)
   └── Translate EN → DE/JA/FR with cultural adaptation

3. Image Generation
   ├── Generate hero shot (reference-guided if available)
   ├── Generate ingredients flat lay
   └── Generate key step photos (1-3)

4. SEO & Quality
   ├── Add metadata, structured data, affiliate links
   ├── Deduplication and copyright check
   ├── SEO ranking optimization pass
   └── Final review per checklist
```

## Handling Reference Inputs

### Reference Images

When user provides reference images (photos of dishes, food styling examples, competitor screenshots):

1. **Do NOT use reference images directly** — they are copyrighted
2. **Invoke `recipe-image-generator` skill** to analyze the reference and generate original images that match the style/composition/mood
3. The generated images are original AI creations — safe to publish

Flow:
```
User provides reference image
  → recipe-image-generator analyzes: composition, lighting, styling, color
  → Generates new original images matching that aesthetic
  → Output saved to public/images/recipes/[dish-slug]/
```

### Reference Documents / URLs

When user provides reference recipes, articles, or URLs as research material:

1. **Read and summarize** the key factual points (ingredients, technique, timing)
2. **Extract only facts** — never copy expression, sentences, or structure
3. **Write a brief summary** noting: dish name, core technique, key ingredients, unique points
4. **Then write your own original article** informed by (but not copying) the reference

Reference summary format:
```
## Reference Summary (internal, not published)
Source: [URL or document name]
Dish: [name]
Key technique: [core cooking method]
Key ingredients: [list unusual/important ones]
Unique points: [what makes this version special]
Time/Difficulty: [prep/cook time, skill level]
---
Now write original article using own words, structure, and added value.
```

**Critical rule**: The published article must pass < 15% similarity to any single reference source. See [references/dedup-and-copyright.md](references/dedup-and-copyright.md).

## Image Generation (via recipe-image-generator)

Every article needs at minimum 3 original images:

| Type | Prompt Style | Placement |
|------|-------------|-----------|
| Hero Shot | 45° or overhead, styled plate, warm light | Article top / OG image |
| Ingredients Flat Lay | Top-down, grouped bowls, clean surface | Before ingredients list |
| Key Step Photo | Action shot, steam/sizzle, close-up | Within instructions |

Generation process:
1. Identify dish visual characteristics and key cooking moments
2. If reference images → pass to `recipe-image-generator` for style analysis
3. If no reference → use default food photography prompts from `recipe-image-generator`
4. Save as WebP, 1200px+ wide, named `[dish-slug]-[type].webp`
5. Write localized alt tags for each language version

For detailed prompt templates and examples, see the `recipe-image-generator` skill.

## Word Count Targets (SEO Sweet Spots)

| Language | Target Range | Unit |
|----------|-------------|------|
| EN | 1,500-2,500 | words |
| ZH | 2,000-4,000 | characters |
| DE | 1,200-2,000 | Wörter |
| JA | 3,000-5,000 | characters |
| FR | 1,200-2,000 | mots |

Below minimum = thin content risk. Above maximum = bounce rate increase.

## Article Structure (11 Parts)

1. **Hook** (~3%) - Sensory description or surprising fact, 1-2 sentences
2. **Story** (~13%) - Cultural background, history, or personal story. See [references/story-angles.md](references/story-angles.md)
3. **Quick Info** (~2%) - Prep time, cook time, servings, difficulty, spice level
4. **Ingredients** (~7%) - Grouped by purpose, with substitutes and affiliate links
5. **Instructions** (~27%) - One action per step, with sensory cues and "why" explanations
6. **Pro Tips** (~10%) - 3-5 advanced techniques
7. **Serving Suggestions** (~5%) - Pairings with internal links to other recipes
8. **Storage & Reheating** (~4%) - Practical 2-3 sentences
9. **FAQ** (~20%) - 4-6 real questions targeting "People Also Ask"
10. **Recipe Card** - JSON-LD structured data (not counted in word count)
11. **Affiliate CTA** (~5%) - 2-3 natural product recommendations

## Multilingual Production Flow

```
Step 1: Chinese master draft (source material, research summary)
Step 2: English version (primary site version, most effort)
Step 3: Translate EN → DE, JA, FR with cultural adaptation
Step 4: Localize each version (ingredients, measurements, shopping)
Step 5: SEO metadata per language (title, description, keywords)
```

### Key Localization Rules

- **EN**: US measurements (tbsp, cup, oz), Amazon US links, explain Chinese culture
- **ZH**: Metric (g, ml), casual tone, suitable for WeChat/Xiaohongshu redistribution
- **DE**: Metric, precise detailed steps, Amazon.de links, mention Asian-Laden stores
- **JA**: Metric (グラム, ml, 大さじ), Amazon.co.jp, highlight difference from Japanese-style versions
- **FR**: Metric (grammes, ml), Amazon.fr, compare techniques with French cooking where relevant

## SEO Requirements

For each language version:
- Title tag (EN/DE/FR: ≤60 chars, ZH: ≤30 chars, JA: ≤30 full-width chars)
- Meta description (EN/DE/FR: ≤160 chars, ZH/JA: ≤80 chars)
- URL slug (DE/FR use local language, JA keeps English)
- Target keyword + 2-3 secondary keywords
- hreflang tags linking all 5 versions
- JSON-LD Recipe structured data
- Image alt tags in target language

For detailed format, see [references/seo-metadata.md](references/seo-metadata.md).

## URL Structure

```
/[slug]/                      (English, default)
/zh/[slug]/                   (Chinese)
/de/[slug-in-german]/         (German, localized URL)
/ja/[slug]/                   (Japanese, English URL)
/fr/[slug-in-french]/         (French, localized URL)
```

## Affiliate Strategy

| Language | Platform | Links |
|----------|----------|-------|
| EN | Amazon US | affiliate-program.amazon.com |
| DE | Amazon.de | partnernet.amazon.de |
| JA | Amazon.co.jp | affiliate.amazon.co.jp |
| FR | Amazon.fr | partenaires.amazon.fr |
| ZH | JD/Taobao or AdSense only | — |

Placement: ingredient descriptions, cooking steps (tools), end-of-article product section.

## Writing Guidelines

- Each step: one core action, specific temperature/time, sensory cues
- Include Chinese cooking terms with pinyin (e.g., "炒出红油" chào chū hóng yóu)
- FAQ is the word count adjuster: add questions if under target, trim Story if over
- Internal link to 2-3 other recipe articles per language version
- All images shared across languages, only alt tags differ
- When using reference documents: summarize facts, write original expression

## Deduplication and Copyright Protection

Every article must pass deduplication checks before publishing:

1. Never copy-paste from reference recipes — rewrite in your own words
2. Add unique value: personal experience, Chinese cooking terms, failure stories
3. Verify with plagiarism tools (Copyscape/Quetext): overall similarity < 15%
4. Use only AI-generated images (via recipe-image-generator) — never save from other sites
5. Mark affiliate links with disclosure statement

For complete workflow, see [references/dedup-and-copyright.md](references/dedup-and-copyright.md).

## SEO Ranking Optimization

Key ranking strategies:

1. **Search Intent Coverage** — answer every question about the dish
2. **E-E-A-T Signals** — Experience, Expertise, Authority, Trust
3. **Core Web Vitals** — LCP < 2.5s, INP < 200ms, CLS < 0.1
4. **Internal Linking** — same-ingredient, pairing, knowledge guide
5. **Content Freshness** — regular updates, "Last updated" date
6. **Original Images** — AI-generated food photography (better than stock photos for E-E-A-T)

For full strategy, see [references/seo-ranking.md](references/seo-ranking.md).

## Quality Checklist

For pre-publish checklist, see [references/checklist.md](references/checklist.md).

## Time Estimate

~4.5 hours per article (all 5 languages + images):
- Research + reference summary + keywords: 30min
- Image generation (hero + ingredients + steps): 25min
- Chinese draft: 15min
- English version + polish: 55min
- DE/JA/FR translation + localization: 50min
- SEO optimization: 25min
- Dedup check + final review: 25min
