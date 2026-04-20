---
name: pi-planning
description: >-
  Generate a PI planning document by reading context docs (PRD, team milestones,
  KPIs, previous roadmap) from Glean and synthesizing them into a structured
  plan. Use when the user asks to create a PI plan, roadmap, or planning doc,
  or says "plan the next PI", "create a roadmap", or "planning doc".
---

# PI Planning

Generate a structured PI planning document by deep-reading context documents
from Glean and synthesizing them against each other.

## Prerequisites

- The `glean-deep-read` skill must be available
- A Glean MCP server must be connected (`user-glean`)
- A `planning-context.json` file must exist in the workspace root

## Config File

The skill reads `planning-context.json` from the workspace root. Each entry
has a `url` and a `summary` field. See
[planning-context.example.json](planning-context.example.json) for the
template.

| Key | Role | Required |
|-----|------|----------|
| `prd` | Program PRD — what the product requires | Yes |
| `team_milestones` | Bigger team planning — org-level deadlines and constraints | Yes |
| `kpis` | Team KPI doc — success metrics that define "done" | Yes |
| `prev_roadmap` | Previous roadmap — what shipped, slipped, or changed | Yes |
| `output_template` | Template for the output doc's structure | No |

### Summary fields

Each entry's `summary` is a human-curated description of the document's role
and content. To populate summaries:

1. Run the skill with URLs only (summaries empty)
2. The agent deep-reads each doc and proposes summary text
3. User reviews and edits the summaries in `planning-context.json`
4. On subsequent runs, the skill uses both raw content AND curated summaries

## Workflow

### Phase 1: Read config

1. Read `planning-context.json` from the workspace root
2. Validate that all 4 required entries have URLs
3. Check if `output_template` is provided

### Phase 2: Deep-read documents

Read documents in this order so each layer adds context to the next:

1. **PRD** — establishes what the product needs
2. **Team milestones** — constrains timing and dependencies
3. **KPIs** — defines what success looks like
4. **Previous roadmap** — establishes baseline (what shipped, what slipped)
5. **Output template** (if provided) — determines output format

For each document, follow the `glean-deep-read` skill workflow:

```
CallMcpTool(
  server: "user-glean",
  toolName: "read_document",
  arguments: { "urls": ["<url-from-config>"] }
)
```

Extract from each:
- Document body (headings, tables, lists)
- Inline comments (author, text, timestamp)
- Embedded links and cross-references
- If `summary` field is populated, use it as interpretive context

### Phase 3: Synthesize

Cross-reference the 4 sources to answer:

1. **What does the PRD require?** — features, capabilities, deliverables
2. **What does the org constrain?** — milestones, deadlines, cross-team gates
3. **How is success measured?** — KPIs, targets, thresholds
4. **What changed since last plan?** — shipped items, slipped items, new scope
5. **What do the comments reveal?** — stakeholder concerns, open questions,
   unresolved debates, action items across all docs

Flag conflicts between sources (e.g., PRD scope vs. capacity, KPI targets
vs. timeline constraints).

### Phase 4: Output

#### Template resolution

Determine output format using this fallback chain:

1. **`output_template` provided** — deep-read the template doc and mirror its
   structure exactly, filling in synthesized content
2. **`output_template` empty, `prev_roadmap` provided** — use the previous
   roadmap's heading structure as the template (same sections, same table
   formats, updated content)
3. **Neither provided** — use the default structure below

#### Default output structure

If no template is available, produce these sections:

1. **Context summary** — one-paragraph orientation: team, PI dates, planning
   horizon
2. **PRD requirements** — what the product requires, distilled from the PRD
3. **Org constraints** — relevant milestones and deadlines from the bigger
   team plan
4. **Success criteria** — KPIs that define "done" for this PI
5. **Delta from previous plan** — what shipped, what slipped, what's new
6. **Proposed workstreams** — concrete work items with owners, dependencies,
   and PI targets
7. **Capacity and staffing** — allocation by person and workstream (if data
   available in the source docs)
8. **Risks and open questions** — aggregated from all docs including comments
9. **Dependencies** — cross-team or infra dependencies surfaced from any doc

#### Presentation

- Use bullet points for scannability
- Attribute insights to specific people when sourced from comments
- For data-heavy output (capacity tables, milestone grids), use a canvas
- Cite document URLs so the user can verify source material

## Summary Refinement Mode

When the user asks to "refine summaries" or "update context":

1. Deep-read each doc in `planning-context.json`
2. Propose updated `summary` text for each entry
3. Present the proposed summaries for user review
4. Update `planning-context.json` with approved summaries

This keeps the config file current as source documents evolve.
