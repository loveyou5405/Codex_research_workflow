# CDK4/6 Inhibitors, Lipid Metabolism, and Cancer: Lit-Review Brief

Date: 2026-06-22  
Mode: academic-research-suite / deep-research / lit-review  
Access posture: Prefer `cloakbrowser_research`; no automatic PDF, Word, RIS, BibTeX, or other document downloads.

## 1. 搜尋策略

### Research Focus

Working question: How do CDK4/6 inhibitors intersect with lipid metabolism, lipid peroxidation, ferroptosis, cholesterol biosynthesis, and lipid-linked clinical biomarkers in cancer?

Scope:
- In scope: palbociclib, ribociclib, abemaciclib, CDK4/6 inhibition, cancer lipid metabolism, ferroptosis, GPX4, SREBP/SREBF1, ACLY, cholesterol metabolism, triglyceride-glucose index.
- Cancer focus: breast cancer first, then selected prostate/general cancer papers when they clarify mechanism.
- Out of scope for this pass: broad CDK4/6 efficacy trials without lipid/metabolic content; automatic full-text PDF download; non-cancer metabolic disease papers unless mechanistically essential.

### Search Strings

Primary PubMed query:

```text
(CDK4/6 inhibitor OR palbociclib OR ribociclib OR abemaciclib)
AND (lipid metabolism OR fatty acid metabolism OR lipogenesis OR cholesterol OR triglyceride)
AND cancer
```

Focused PubMed query:

```text
(palbociclib OR ribociclib OR abemaciclib OR CDK4/6)
AND (SREBP OR SREBF1 OR ACLY OR FASN OR GPX4 OR ferroptosis OR cholesterol)
AND (breast cancer OR cancer OR tumor)
```

Supplemental exact-title / mechanism searches:
- `"CDK4/6 inhibitor" "GPX4" "lipid metabolism"`
- `"CDK4/6" "SREBP1" "cholesterol metabolism"`
- `"palbociclib" "ferroptosis" "lipid"`
- `"CDK4/6" "ACLY" "lipid metabolism"`
- `"Triglyceride-Glucose Index" "CDK4/6 inhibitors"`

### Inclusion / Exclusion Criteria

Include:
- Directly links CDK4/6 inhibition or cyclin D-CDK4/6 axis to lipid metabolism, cholesterol synthesis, ferroptosis, lipid peroxidation, or lipid-linked clinical biomarkers.
- Provides peer-reviewed metadata with DOI/PMID or authoritative publisher page.
- Preclinical mechanistic studies accepted because the field is mechanism-heavy and clinically sparse.

Exclude:
- General CDK4/6 clinical efficacy papers without lipid/metabolism angle.
- General lipid metabolism cancer papers without CDK4/6/cell-cycle link.
- PDF-only results not needed for metadata extraction.
- Sources requiring unresolved access checks are not excluded, but marked for human confirmation.

## 2. 搜尋紀錄

| Step | Tool / Source | Query or URL | Result | Notes |
|---|---|---|---|---|
| 1 | `cloakbrowser_research` | PubMed primary query | 47 PubMed results | Visible page text extracted; no downloads. |
| 2 | `cloakbrowser_research` | PMID 39500869 | Opened successfully | PubMed metadata/abstract visible for Nat Commun GPX4 paper. |
| 3 | `cloakbrowser_research` | PMID 39656925 | reCAPTCHA/browser check | Screenshot saved: `mcp/cloakbrowser-research/outputs/pubmed-39656925-recaptcha.png`. Human browser confirmation recommended. |
| 4 | `cloakbrowser_research` | DOI 10.1002/advs.202413103 | Wiley/Cloudflare check page | Screenshot saved: `mcp/cloakbrowser-research/outputs/wiley-advs-202413103-check.png`. |
| 5 | NCBI E-utilities | EFetch for selected PMIDs | Metadata/abstracts parsed | Official API; no document download. |
| 6 | Web / publisher metadata | DOI/PubMed/title search | Candidate expansion | Used for current/source verification where PubMed web page triggered reCAPTCHA. |

PRISMA-style count for this initial, non-systematic lit-review pass:
- Records identified from primary PubMed search: 47
- Additional targeted records considered: 6
- Records screened by title/abstract: about 20
- Candidate sources retained: 10
- Core mechanistic sources: 6
- Background/review/clinical biomarker sources: 4

## 3. 候選文獻表

| # | Source | DOI / PMID | Type | Why Candidate |
|---|---|---|---|---|
| 1 | Herrera-Abreu et al., 2024, *Nature Communications* | DOI: [10.1038/s41467-024-53837-7](https://doi.org/10.1038/s41467-024-53837-7); PMID: [39500869](https://pubmed.ncbi.nlm.nih.gov/39500869/) | Mechanistic preclinical, CRISPR screens, xenograft | Strongest direct evidence: CDK4/6 plus endocrine therapy creates oxidative stress, disordered lipid metabolism, and GPX4/ferroptosis vulnerability in ER+ breast cancer; extends to TNBC models. |
| 2 | Yang et al., 2025, *Advanced Science* | DOI: [10.1002/advs.202413103](https://doi.org/10.1002/advs.202413103); PMID: [39656925](https://pubmed.ncbi.nlm.nih.gov/39656925/) | Mechanistic preclinical | CDK4/6 + CDK7 dual inhibition suppresses TNBC via FOXM1/SREBF1-linked cholesterol biosynthesis reduction. |
| 3 | Velez et al., 2023, *Oncology Reports* | DOI: [10.3892/or.2022.8469](https://doi.org/10.3892/or.2022.8469); PMID: [36562384](https://pubmed.ncbi.nlm.nih.gov/36562384/) | Mechanistic preclinical | Combines ACLY inhibition with CDK4/6 inhibition; links AKT-ACLY/lipogenesis axis to cancer growth and invasion. |
| 4 | Rodencal et al., 2024, *Cell Chemical Biology* | DOI: [10.1016/j.chembiol.2023.10.011](https://doi.org/10.1016/j.chembiol.2023.10.011); PMID: [37963466](https://pubmed.ncbi.nlm.nih.gov/37963466/) | Mechanistic preclinical | Cell-cycle arrest, including CDK4/6 inhibition, increases GPX4-inhibitor ferroptosis sensitivity via PUFA-phospholipid remodeling. |
| 5 | Lee et al., 2024, *Nature Communications* | DOI: [10.1038/s41467-023-44412-7](https://doi.org/10.1038/s41467-023-44412-7); PMID: [38167301](https://pubmed.ncbi.nlm.nih.gov/38167301/) | Mechanistic preclinical | Important counterpoint: cell-cycle arrest induces DGAT-dependent lipid droplets that sequester PUFAs and suppress ferroptosis. |
| 6 | Zhang et al., 2024, *Cell Death Discovery* | DOI: [10.1038/s41420-024-02152-7](https://doi.org/10.1038/s41420-024-02152-7); PMID: [39362848](https://pubmed.ncbi.nlm.nih.gov/39362848/) | Mechanistic preclinical, prostate cancer | Palbociclib sensitizes prostate cancer to ferroptosis through TRIB3/SOX2/SLC7A11 downregulation. |
| 7 | Aldaalis et al., 2022, *Frontiers in Oncology* | DOI: [10.3389/fonc.2022.942386](https://doi.org/10.3389/fonc.2022.942386); PMID: [36091143](https://pubmed.ncbi.nlm.nih.gov/36091143/) | Mechanistic / conceptual | SREBP1 activates cyclin D1 and coordinates proliferation with lipid synthesis; frames upstream SREBP-cyclin D-CDK4/6 coupling. |
| 8 | Önder et al., 2024, *Clinical Breast Cancer* | DOI: [10.1016/j.clbc.2024.05.004](https://doi.org/10.1016/j.clbc.2024.05.004); PMID: [38879437](https://pubmed.ncbi.nlm.nih.gov/38879437/) | Retrospective clinical biomarker | Triglyceride-glucose index as prognostic marker in HR+/HER2- metastatic breast cancer treated with CDK4/6 inhibitor plus endocrine therapy. |
| 9 | Hodgson et al., 2026, *Molecular Cancer Research* | DOI: [10.1158/1541-7786.MCR-25-1270](https://doi.org/10.1158/1541-7786.MCR-25-1270); PMID: [41774082](https://pubmed.ncbi.nlm.nih.gov/41774082/) | Review | Current framing review on reciprocal roles of cell cycle and lipid metabolism in cancer and therapeutic exploitation. |
| 10 | Faur et al., 2025, *Life* | DOI: [10.3390/life15050689](https://doi.org/10.3390/life15050689); PMID: [40430118](https://pubmed.ncbi.nlm.nih.gov/40430118/) | Narrative review | Broader breast-cancer lipid metabolism / dyslipidemia context; useful for clinical lipid biomarkers but not CDK4/6-specific. |

## 4. 文獻矩陣

| Theme | Sources | Cancer context | Method / evidence level | Key Finding | Quality / Caveat |
|---|---|---|---|---|---|
| GPX4-ferroptosis vulnerability after CDK4/6 inhibition | Herrera-Abreu 2024; Rodencal 2024; Zhang 2024 | ER+ breast, TNBC models, prostate cancer | Preclinical functional genomics, lipid/redox assays, xenograft; Level VI by clinical hierarchy but strong mechanistic fitness | CDK4/6 inhibition can shift cells toward ferroptosis vulnerability through GPX4 dependence, PUFA-phospholipid remodeling, oxidative stress, or SLC7A11 downregulation. | Strong mechanistic convergence, limited clinical translation; several COIs/patent/industry ties need disclosure. |
| Cholesterol synthesis / SREBP axis | Yang 2025; Aldaalis 2022 | TNBC, general cancer cell-cycle biology | Preclinical mechanistic; Level VI | CDK4/6 pathway intersects with SREBP1/cyclin D1 and, in TNBC, dual CDK4/6-CDK7 inhibition reduces cholesterol biosynthesis via FOXM1-SREBF1. | Promising but mostly cell/xenograft; whether CDK4/6 inhibition alone is enough is unclear. |
| ACLY / lipogenesis and invasion | Velez 2023 | Breast and pancreatic cancer models | Preclinical combination therapy; Level VI | ACLY, downstream of AKT and central to acetyl-CoA/lipogenesis, may be co-targeted with CDK4/6 to reduce growth/invasion. | Small mechanistic study; needs broader cancer-type validation and pharmacologic selectivity checks. |
| Cell-cycle arrest can also protect from ferroptosis | Lee 2024 | Drug-resistant / slow-cycling cancer cells | Preclinical; Level VI | Arrested cells can form DGAT-dependent lipid droplets, sequestering PUFAs into TAGs and reducing ferroptosis. | Directly complicates the “CDK4/6 inhibition = ferroptosis sensitization” narrative; context and lipid-routing state matter. |
| Clinical lipid-linked biomarkers | Önder 2024; Faur 2025 | HR+/HER2- metastatic breast cancer; breast cancer broadly | Retrospective cohort / narrative review; Level IV for Önder, Level VII for Faur | TyG index may stratify outcomes in patients treated with CDK4/6 inhibitors; broader dyslipidemia may relate to prognosis/treatment response. | Biomarker association, not mechanism; confounding by endocrine therapy, BMI, diabetes, statins, and tumor subtype needs control. |
| Integrative framework | Hodgson 2026 | Cancer broadly | Review; Level VII | Lipidomic technologies are clarifying reciprocal links between cell-cycle regulators, lipid profiles, inhibitor response, and resistance. | Useful for framing hypotheses; not primary evidence. |

## 5. Synthesis and 研究缺口

### Main Synthesis

The literature does not support a single, linear claim that CDK4/6 inhibitors simply suppress or activate lipid metabolism. Instead, it suggests a context-dependent rewiring of lipid handling when cell-cycle progression is arrested.

The strongest emerging therapeutic axis is CDK4/6 inhibition plus ferroptosis targeting. Herrera-Abreu et al. show that palbociclib/endocrine therapy generates oxidative stress and disordered lipid metabolism in breast cancer models, creating GPX4 dependence and ferroptosis vulnerability. Rodencal et al. provides convergent evidence that cell-cycle arrest increases oxidizable PUFA-phospholipids and sensitizes cells to covalent GPX4 inhibitors. Zhang et al. extends this logic to prostate cancer through TRIB3/SOX2/SLC7A11.

However, Lee et al. introduces a critical contradiction: cell-cycle arrest can induce lipid droplet formation, redirect PUFAs into triacylglycerols, and protect cells from ferroptosis. This likely means the effect of CDK4/6 inhibition depends on how arrested cells partition PUFAs among phospholipids, triglycerides/lipid droplets, and peroxidation-prone membranes.

A second axis is cholesterol/lipogenesis control. Yang et al. suggests that TNBC resistance to CDK4/6 inhibition can be addressed through dual CDK4/6-CDK7 inhibition that suppresses FOXM1-SREBF1-driven cholesterol biosynthesis. Aldaalis et al. supports a broader conceptual link: SREBP1 can regulate cyclin D1, connecting lipid synthesis to cyclin D-CDK4/6-Rb cell-cycle entry.

Clinical translation remains thin. The Önder TyG-index study is valuable because it moves lipid metabolism toward patient stratification in CDK4/6-treated HR+/HER2- metastatic breast cancer, but it does not establish mechanism. There is not yet a mature clinical literature connecting lipidomic phenotypes, CDK4/6 inhibitor response, ferroptosis sensitivity, and combination-treatment benefit.

### Key Research Gaps

1. Context rules for ferroptosis sensitization vs resistance  
   Need to define when CDK4/6 inhibition pushes PUFAs into peroxidation-prone phospholipids versus protective lipid droplets.

2. Lack of patient lipidomics paired with CDK4/6 response  
   Few clinical studies measure tumor lipidome, plasma lipids, TyG index, ferroptosis markers, and CDK4/6 outcomes together.

3. Combination strategy uncertainty  
   GPX4 inhibitors, DGAT inhibitors, ACLY inhibitors, CDK7 inhibitors, statins, and endocrine therapy all touch different lipid nodes; optimal sequence and safety are unresolved.

4. Cancer-type specificity  
   Breast cancer dominates the evidence. Prostate, pancreatic, and other cancers appear only as early mechanistic extensions.

5. Drug-specific differences  
   Palbociclib appears most represented. Abemaciclib and ribociclib may differ due to kinase selectivity, off-target profile, pharmacokinetics, and toxicity; lipid-metabolic consequences are under-characterized.

6. Clinical safety and interaction layer  
   Lipid-targeted co-therapy may interact with statins, endocrine therapy, liver metabolism, myopathy/rhabdomyolysis risk, and CYP3A-mediated CDK4/6 inhibitor exposure.

## 6. 後續精讀清單

Priority A: core mechanism
1. Herrera-Abreu et al. 2024, *Nature Communications* — read full text first; central breast-cancer GPX4/CDK4/6 paper.
2. Rodencal et al. 2024, *Cell Chemical Biology* — clarify PUFA-phospholipid mechanism and GPX4 inhibitor specificity.
3. Lee et al. 2024, *Nature Communications* — read as counterweight; lipid droplets and ferroptosis resistance.
4. Yang et al. 2025, *Advanced Science* — TNBC cholesterol/SREBF1/CDK7-CDK4/6 combination mechanism.

Priority B: lipid synthesis / upstream framing
5. Velez et al. 2023, *Oncology Reports* — ACLY-CDK4/6 co-targeting.
6. Aldaalis et al. 2022, *Frontiers in Oncology* — SREBP1-cyclin D1 link.
7. Hodgson et al. 2026, *Molecular Cancer Research* — current integrative review.

Priority C: clinical translation
8. Önder et al. 2024, *Clinical Breast Cancer* — TyG index as patient biomarker.
9. Faur et al. 2025, *Life* — broader lipid profile/dyslipidemia context in breast cancer.

## Verification Notes

- CloakBrowser access was confirmed for PubMed search and one PubMed article page.
- PubMed and Wiley pages triggered reCAPTCHA/Cloudflare checks for some items. These were not bypassed.
- Metadata and abstracts were cross-checked via NCBI E-utilities and DOI/publisher metadata where page access was interrupted.
- No PDFs, citation files, Word files, or other documents were downloaded automatically.
