---
name: paper-reader
description: "Read academic papers quickly and extract structured takeaways, notes, and key insights"
---

# Paper Reader Skill

Transform academic papers into concise, structured notes optimized for fast comprehension.

## Workflow

### Step 1: First Pass — Structure Scan (2 min read)

Skim the paper to map its structure:

1. Read title, abstract, and conclusion first
2. Identify the paper type: empirical study, survey, theoretical, system/tool, position paper
3. Note section headings and figure/table captions
4. Count pages, references, and key figures

**Output:** One-line summary + paper type + section map.

### Step 2: Deep Read — Extract Core Content

Read the full paper and extract:

1. **Problem** — What gap or question does this paper address?
2. **Approach** — What method, model, or framework do the authors propose?
3. **Key Results** — Top 3-5 quantitative or qualitative findings
4. **Novelty** — What is genuinely new vs. incremental improvement?
5. **Limitations** — What do the authors acknowledge or miss?

### Step 3: Synthesize Output

Produce a structured note in the output format below.

## Output Format

```markdown
# [Paper Title]
**Authors:** [First Author et al., Year]
**Venue:** [Conference/Journal]
**Paper type:** [empirical | survey | theoretical | system | position]

## TL;DR
[2-3 sentence summary a colleague could read in 30 seconds]

## Key Takeaways
1. [Most important finding or contribution]
2. [Second most important]
3. [Third — add more only if genuinely distinct]

## Method Summary
[3-5 sentences on the approach — enough to explain it to someone unfamiliar]

## Results Highlights
| Metric/Finding | Value/Outcome | Context |
|----------------|---------------|---------|
| ...            | ...           | ...     |

## Strengths
- [What the paper does well]

## Weaknesses & Open Questions
- [Limitations, missing comparisons, threats to validity]
- [Questions you'd ask the authors]

## Relevance & Connections
- [How this connects to your work or other papers]
- [Potential applications or follow-up ideas]

## Notable Figures
- **Fig X:** [Why it matters, what it shows]

## Key References to Follow
- [2-3 cited papers worth reading next, with one-line reason]
```

## Rules

- Lead with what matters — readers should get value from just the TL;DR and takeaways
- Be opinionated: flag weak methodology, overclaimed results, or missing baselines
- Distinguish the authors' claims from your assessment
- For math-heavy papers, explain key equations in plain language
- For system papers, focus on architecture decisions and trade-offs
- Skip boilerplate (related work padding, obvious definitions) — extract signal only
- If the paper is a PDF, use the Read tool with `pages` parameter for large files
- When the user provides a URL, use WebFetch to retrieve it
