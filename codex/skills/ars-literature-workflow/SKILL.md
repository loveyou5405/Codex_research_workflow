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

- Reuse one `cloakbrowser_research` session and the same page/tab for a batch of DOI or official-URL checks. Navigate sequentially with `open_url`, equivalent to pasting each next URL into the same address bar. Do not relaunch Terminal, the browser, or a new window for each paper; close the session only after the batch is complete.
- If a site shows reCAPTCHA, Cloudflare, "Just a moment", SSO, or a publisher access check, stop bypass attempts early.
- If metadata is enough, record the issue and continue through official metadata sources such as PubMed, DOI/Crossref, NCBI E-utilities, or the publisher abstract page.
- Ask the user only when they need to log in, confirm authorization, handle a CAPTCHA, or decide whether a core article needs full text.

## PMC PDF Resolution

- For a PubMed Central paper, call `cloakbrowser_research.resolve_pmc_pdf` with its PMCID. This resolver prefers the current PMC Cloud Service article-version object (`pmc-oa-opendata/PMC….version/`) and can save a verified PDF according to the active download policy.
- Never reuse or cache an OA API FTP link from an earlier run. The April 2026 PMC migration moved legacy paths under `deprecated`, and those transitional legacy objects are scheduled for removal in August 2026.
- Only when no current Cloud PDF object exists may the resolver use the fresh OA API response from the same run. During the April-August 2026 transition it corrects the moved package path to `deprecated`, uses HTTPS, extracts the article PDF, and verifies its file signature. If neither route yields a verified PDF, record `未下載 — PMC 新版 Cloud 與即時 OA 連結皆無可用 PDF` rather than treating HTML as a PDF.

## Report Expectations

For literature reviews, include the search strategy, search log, candidate papers, literature matrix, key claims, counterevidence, limitations, research gaps, and next-step reading list.

Every candidate-paper table must include a `DOI / 文獻網址` column with a non-empty value for every row:

- Prefer the paper's verified article-level DOI and normalize it as `https://doi.org/<DOI>`.
- Verify that the resolved DOI title, authors, and year match the candidate paper. Never guess a DOI or take a DOI from the paper's reference list.
- Only when the paper genuinely has no DOI, use a verified official publisher, PubMed/PMC, or institutional-repository article URL. Do not use a search-results URL.
- If neither a DOI nor an official article URL can be obtained, write `未取得 — <reason>` instead of leaving the cell blank.

When PDF preservation is selected, add a `PDF 下載狀態` column to both the candidate-paper table and final included list. Every row must be one of:

- `已下載 — output_PDF/<filename>.pdf` only after confirming the PDF exists on disk.
- `未下載 — <reason>` when no PDF was obtained, including no legally accessible full text, manual login/CAPTCHA required, HTML-only access, broken link, or download failure.

Never leave this field blank, write only `未確認`, or treat an HTML page as a downloaded PDF. Add report totals for downloaded and not-downloaded papers.

When requested by the Research Console prompt, add a brief Traditional Chinese mechanism summary for every candidate and included paper. Each summary should normally be 2-4 sentences (about 80-160 Chinese characters) covering the biological context, causal molecular/cellular chain, and phenotypic, resistance, or therapeutic significance. Ground it only in verified abstract or full-text evidence, distinguish direct evidence from author hypothesis or inference, and write `此文獻未提供足夠的機制證據` when the available source does not support a mechanistic account. Never invent a mechanism merely to fill the field.

When requested by the Research Console prompt, end with a reusable ChatGPT deep-analysis prompt for cautious downstream review.
