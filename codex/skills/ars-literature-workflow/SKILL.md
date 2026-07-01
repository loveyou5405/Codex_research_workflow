# ARS Literature Workflow

Use this skill when the user wants automated literature search, review, manuscript checking, or report generation from this project.

## Default Workflow

1. Prefer the `academic-research-suite` skill for research design, literature review, paper writing, manuscript review, and citation checking.
2. Prefer the `cloakbrowser_research` MCP server for browser-backed discovery, DOI resolution, publisher-page inspection, screenshots, and authorized institutional access checks.
3. Include likely subscription or paywalled publisher journals in source discovery when the user has authorized school, VPN, library, institutional, or publisher access. Do not limit searches to open-access sources; actively check relevant high-impact venues such as Nature Medicine, Nature family journals, The Lancet family, NEJM, Science, Cell, Wiley, Springer Nature, Elsevier, and society journals when they fit the research topic.
4. Treat the user as responsible for confirming legitimate school, VPN, library, institutional, or publisher access. Do not bypass CAPTCHA, paywalls, subscriptions, or access controls.
5. Download PDF, Word, RIS, BibTeX, NBIB, ZIP, or related literature files only when the user explicitly allows it or the Research Console prompt says downloads are allowed.
6. The default download policy is `temporary`: call `cloakbrowser_research.set_download_policy` with `mode=temporary`, store downloaded and converted files under `downloads/`, and delete them at task completion.
7. When the user selects PDF preservation or explicitly asks to keep PDFs, call `cloakbrowser_research.set_download_policy` with `mode=preserve_pdf`. For every paper shown in the candidate table and final included list, actively search for a legally accessible PDF and actually attempt the download; having an abstract, HTML full text, or metadata does not satisfy or waive this attempt. Check publisher PDF links, PubMed Central or other official repositories, author/institutional repositories, and PDFs available through the user's authorized school/library session. Never bypass a paywall, CAPTCHA, login, or access control.
8. A paper counts as downloaded only when a detected PDF file actually exists under `output_PDF/`. Keep non-PDF files and conversion artifacts under temporary `downloads/`.
9. Store user uploads under `uploads/` and final synthesis under `reports/`. Cleanup must never delete `reports/` or `output_PDF/`.
10. Use `.venv/bin/markitdown` when converting a downloaded or uploaded file to Markdown/text would improve reading, citation extraction, or structured analysis. Keep conversion outputs temporary unless the user explicitly asks otherwise.
11. At task completion, delete temporary screenshots, uploads, downloads, and conversion artifacts. Preserve only final reports and PDFs explicitly selected for `output_PDF/`.

## Browser Rules

- If a site shows reCAPTCHA, Cloudflare, "Just a moment", SSO, or a publisher access check, stop bypass attempts early.
- If metadata is enough, record the issue and continue through official metadata sources such as PubMed, DOI/Crossref, NCBI E-utilities, or the publisher abstract page.
- Ask the user only when they need to log in, confirm authorization, handle a CAPTCHA, or decide whether a core article needs full text.

## Report Expectations

For literature reviews, include the search strategy, search log, candidate papers, literature matrix, key claims, counterevidence, limitations, research gaps, and next-step reading list.

When PDF preservation is selected, add a `PDF 下載狀態` column to both the candidate-paper table and final included list. Every row must be one of:

- `已下載 — output_PDF/<filename>.pdf` only after confirming the PDF exists on disk.
- `未下載 — <reason>` when no PDF was obtained, including no legally accessible full text, manual login/CAPTCHA required, HTML-only access, broken link, or download failure.

Never leave this field blank, write only `未確認`, or treat an HTML page as a downloaded PDF. Add report totals for downloaded and not-downloaded papers.

When requested by the Research Console prompt, add a brief Traditional Chinese mechanism summary for every candidate and included paper. Each summary should normally be 2-4 sentences (about 80-160 Chinese characters) covering the biological context, causal molecular/cellular chain, and phenotypic, resistance, or therapeutic significance. Ground it only in verified abstract or full-text evidence, distinguish direct evidence from author hypothesis or inference, and write `此文獻未提供足夠的機制證據` when the available source does not support a mechanistic account. Never invent a mechanism merely to fill the field.

When requested by the Research Console prompt, end with a reusable ChatGPT deep-analysis prompt for cautious downstream review.
