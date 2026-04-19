---
description: "Read an academic paper and produce structured takeaways and notes"
---

The user wants to read and analyze an academic paper. Follow this workflow:

1. Ask the user for the paper — accept any of:
   - A local PDF file path
   - A URL (arXiv, Semantic Scholar, direct PDF link)
   - A pasted abstract or paper title to search for

2. If given a URL, fetch the paper content using WebFetch. If given a PDF path, read it using the Read tool (use `pages` parameter for papers over 10 pages — read in chunks of 15-20 pages).

3. If given only a title or abstract, search for the paper using WebSearch, then fetch it.

4. Once you have the paper content, follow the **paper-reader** skill workflow:
   - First pass: structure scan
   - Deep read: extract core content
   - Synthesize into the structured output format

5. Present the structured notes to the user.

6. After presenting, offer to:
   - Deep-dive into a specific section
   - Compare with another paper
   - Extract all equations/algorithms
   - Generate citation entry (BibTeX)
   - Save the notes to a file
