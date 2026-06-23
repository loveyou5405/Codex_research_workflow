# ARS Literature Workflow

Use this skill when the user wants automated literature search, review, manuscript checking, or report generation from this project.

## Default Workflow

1. Prefer the `academic-research-suite` skill for research design, literature review, paper writing, manuscript review, and citation checking.
2. Prefer the `cloakbrowser_research` MCP server for browser-backed discovery, DOI resolution, publisher-page inspection, screenshots, and authorized institutional access checks.
3. Treat the user as responsible for confirming legitimate school, VPN, library, institutional, or publisher access. Do not bypass CAPTCHA, paywalls, subscriptions, or access controls.
4. Download PDF, Word, RIS, BibTeX, NBIB, ZIP, or related literature files only when the user explicitly allows it or the Research Console prompt says downloads are allowed.
5. Store downloaded external literature files only under the project `downloads/` directory. Store user uploads under `uploads/`. Keep final synthesis under `reports/`.
6. Use `.venv/bin/markitdown` when converting a downloaded or uploaded file to Markdown/text would improve reading, citation extraction, or structured analysis.
7. At task completion, delete temporary screenshots, uploads, downloads, and conversion artifacts unless the user explicitly asks to keep them. Do not delete `reports/`.

## Browser Rules

- If a site shows reCAPTCHA, Cloudflare, "Just a moment", SSO, or a publisher access check, stop bypass attempts early.
- If metadata is enough, record the issue and continue through official metadata sources such as PubMed, DOI/Crossref, NCBI E-utilities, or the publisher abstract page.
- Ask the user only when they need to log in, confirm authorization, handle a CAPTCHA, or decide whether a core article needs full text.

## Report Expectations

For literature reviews, include the search strategy, search log, candidate papers, literature matrix, key claims, counterevidence, limitations, research gaps, and next-step reading list. When requested by the Research Console prompt, end with a reusable ChatGPT deep-analysis prompt for cautious downstream review.
