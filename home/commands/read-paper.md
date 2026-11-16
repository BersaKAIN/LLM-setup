---
description: "Read an academic paper using the paper-reader skill and save a technical review"
---

Follow the **paper-reader** skill in `skills/shared/paper-reader/SKILL.md` as the authoritative workflow.

Use the paper already supplied in the conversation. If none is identifiable, ask for a PDF, title, DOI, arXiv URL, project page, or paper-library link.

Apply the skill's source verification, method explanation, rendered architecture and training diagrams, sourced training recipe, benchmark explanations, Paperpile registration, and Notion publishing requirements. Follow its defaults unless the user overrides them. For follow-up questions, reuse the existing review and follow the skill's tested-improvement process.

Return the verified review link and a concise result, including any publishing or Paperpile operation that remains pending. Keep workflow details in the skill so this command does not maintain a separate copy.
