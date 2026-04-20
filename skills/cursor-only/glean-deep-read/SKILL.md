---
name: glean-deep-read
description: >-
  Read raw document content from Glean and produce a thorough summary with
  insights that Glean's own AI summary misses. Use when the user shares a
  document URL (Google Docs, Confluence, SharePoint, etc.) and asks for a
  summary, analysis, review, or deep read. Also use when the user says
  "read this doc", "summarize this", or "what does this document say".
---

# Glean Deep Read

Read a document's full raw content via Glean MCP and summarize it yourself,
extracting details that automated summaries typically miss (comments,
stakeholder concerns, embedded links, appendix items).

## When to Use

- User shares a document URL and wants a summary or analysis
- User asks to "read", "summarize", or "review" an internal document
- User wants deeper insight than a quick Glean search snippet provides

## Workflow

### Step 1: Fetch raw content

Call the Glean `read_document` tool with the document URL. The parameter
is `urls` (an array):

```
CallMcpTool(
  server: "user-glean",
  toolName: "read_document",
  arguments: { "urls": ["<document-url>"] }
)
```

The response includes:
- `title`, `datasource`, `url`, `owner`, `updateTime`
- `percentRetrieved` — confirm this is close to 100%
- `richDocumentData.content` — JSON with `pageBody` (HTML) and `comments` (array)

If `percentRetrieved` is low, note the gap to the user.

### Step 2: Parse the raw content

The `pageBody` field is HTML (often from Apache Tika). Extract:

1. **Document structure** — headings, tables, lists
2. **Inline comments** — the `comments` array contains author, text, timestamp, and thread IDs. These are where stakeholder feedback, open questions, and action items live.
3. **Embedded links** — references to other docs, Jira tickets, dashboards
4. **Metadata** — owner, contributors, last update time

### Step 3: Summarize

Produce a summary with these sections (adapt as needed):

1. **Overview** — title, owner, date, purpose (2-3 sentences max)
2. **Key content** — main findings, decisions, or plans organized by the document's own structure
3. **Comment-sourced insights** — what stakeholders said in comments that isn't in the body text. Attribute by name.
4. **Open questions / action items** — unresolved threads, requests for input
5. **Dependencies and links** — referenced documents, tickets, external systems
6. **Risks or concerns** — anything flagged as a risk, blocker, or gap

### Step 4: Present

- Use bullet points for scannability
- Attribute insights to specific people when sourced from comments
- If presenting substantial structured data, consider using a canvas
- Cite the document URL so the user can verify

## Comparison: Deep Read vs Glean Chat

| Aspect | Glean `chat` | Deep Read |
|--------|-------------|-----------|
| Speed | Fast, single call | Two calls (read + parse) |
| Body text | Faithful extraction | Same |
| Comments | Usually omitted | Fully extracted and attributed |
| Cross-references | Mentioned if in body | Extracted with URLs |
| Analysis depth | Surface-level summary | Connects dots across sections |

Use Glean `chat` for quick orientation. Use Deep Read when the user needs
the full picture including stakeholder feedback.

## Fallback

If `read_document` fails or returns low `percentRetrieved`:
1. Try `search` with the document URL to get snippets
2. Try `chat` asking Glean to summarize the document
3. Tell the user what percentage was retrieved and what may be missing
