---
name: recipe-image-generator
description: "Generate original food photography images for Chinese recipe articles. Creates hero shots, step-by-step cooking photos, and ingredient layouts using AI image generation, optionally based on reference images for style/composition guidance. Use when: generating recipe images, creating food photos for blog, making hero shot for recipe, generating cooking step images, need food photography for article. Triggers: generate recipe image, create food photo, make hero shot, recipe photography, food image, generate cooking photo, create dish image, AI food photo, reference image style transfer, recipe visual content."
---

# Recipe Image Generator

Generate original, copyright-safe food photography for Chinese recipe articles. Supports reference-image-guided generation for consistent style.

## Workflow

```
Has reference image(s)?
├── YES → Analyze reference → Extract style/composition → Generate with style guidance
└── NO  → Use dish name + default food photography style → Generate from prompt
```

## Image Types Required Per Article

Each recipe article needs at minimum 3 images:

| Type | Purpose | Placement | Style Notes |
|------|---------|-----------|-------------|
| Hero Shot | Main dish, finished result | Top of article / Open Graph | Overhead or 45° angle, styled plate, warm lighting |
| Ingredients Flat Lay | All ingredients arranged | Before "Ingredients" section | Top-down, organized groups, clean background |
| Key Step Photo | Critical cooking moment | Within "Instructions" | Action shot, steam/sizzle visible, close-up |

Optional bonus images (improves SEO dwell time):
- Serving/plating shot (for "Serving Suggestions" section)
- Before/after comparison (raw vs cooked)
- Texture close-up (e.g., silky tofu, crispy skin)

## Reference Image Workflow

When user provides reference images:

### Step 1: Analyze Reference

Read the reference image and extract:
- **Composition**: angle (overhead/45°/side), framing (tight/wide), subject placement
- **Lighting**: natural/studio, warm/cool, direction, shadows
- **Styling**: plate type, background surface, props, garnish style
- **Color palette**: dominant colors, contrast level
- **Mood**: rustic/modern/minimalist/homey

### Step 2: Build Generation Prompt

Construct the image generation prompt combining:
```
[Dish name and description] +
[Composition from reference: angle, framing] +
[Lighting style from reference] +
[Surface/background from reference] +
[Color mood from reference] +
[Food photography quality keywords]
```

### Step 3: Generate Image

Use the image generation tool with the constructed prompt and reference image path.

### Step 4: Verify Output

Check generated image for:
- Food looks appetizing and recognizable as the target dish
- No text/watermarks in image
- Composition matches reference style
- Colors are natural (no oversaturation)
- No obvious AI artifacts (extra fingers on hands, melted utensils, etc.)

If quality is insufficient, regenerate with adjusted prompt.

## Prompt Templates (No Reference Image)

### Hero Shot
```
Professional food photography of [dish name], [brief description of dish appearance].
Shot from [45-degree angle / overhead / eye level].
Served on [plate type] on [surface type: dark wood / marble / rustic table].
Warm natural lighting from the left side. Shallow depth of field.
Garnished with [appropriate garnish: scallions / sesame / chili oil].
Steam rising gently. Rich colors, appetizing presentation.
High-end food magazine quality, 4K resolution.
```

### Ingredients Flat Lay
```
Overhead flat lay food photography of ingredients for [dish name].
Arranged in small bowls and measuring spoons on [surface].
Ingredients include: [list key visual ingredients].
Clean, organized composition. Soft natural lighting.
Minimalist food styling, editorial quality.
```

### Key Step Action Shot
```
Close-up food photography of [specific cooking action: stir-frying in wok / sauce bubbling / adding ingredient].
Action moment captured with slight motion blur on utensil.
[Steam/sizzle/color change] visible. Warm kitchen lighting.
Shot from slightly above, shallow depth of field on the focal point.
Professional cooking process documentation style.
```

## Image Specifications

| Property | Value |
|----------|-------|
| Format | PNG or WebP (WebP preferred for web) |
| Aspect Ratio | 16:9 (hero), 1:1 (ingredients), 4:3 (steps) |
| Min Resolution | 1200px wide |
| File Naming | `[dish-slug]-[type]-[number].webp` |
| Alt Text | Descriptive, localized per language |

## File Naming Convention

```
mapo-tofu-hero.webp
mapo-tofu-ingredients.webp
mapo-tofu-step-1-fry-aromatics.webp
mapo-tofu-step-2-add-sauce.webp
mapo-tofu-serving.webp
```

## Integration with chinese-recipe-writer

This skill is called by `chinese-recipe-writer` during the image generation phase:

1. Recipe writer identifies dish and key visual moments
2. If user provides reference images → this skill analyzes and style-matches
3. If no reference → this skill uses default food photography prompts
4. Generated images are saved to `public/images/recipes/[dish-slug]/`
5. Recipe writer references images with localized alt tags

## Quality Standards

- Food must look **appetizing** — warm tones, visible texture, appropriate gloss
- No **uncanny valley** — avoid obviously AI-generated artifacts
- **Consistent style** across all images in one article
- **No text or watermarks** in generated images
- **Culturally appropriate** — Chinese dish on suitable dishware (not Italian plate for Chinese food)
- Chopsticks, Chinese spoon, or appropriate utensils if included
