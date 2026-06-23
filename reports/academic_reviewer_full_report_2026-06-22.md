# Academic Paper Reviewer Full Report

Date: 2026-06-22  
Mode: academic-research-suite / academic-paper-reviewer / full  
Manuscript: `__V8_cite.pdf`  
Review language: Chinese, with technical terms retained in English

## 0. File Intake And Conversion Decision

### User-Provided Material

| File | Role in this review | Conversion decision | Reason |
|---|---|---|---|
| `uploads/2026-06-22T11-34-11-449Z/__V8_cite.pdf` | User-provided thesis/progress-report manuscript | Used direct PDF text extraction; no MarkItDown conversion | PDF is a Microsoft Word-generated tagged PDF with 86 pages and a usable text layer. `pdfplumber` extraction preserved page boundaries and chapter structure well enough for review. MarkItDown was not installed and was not necessary. |

Scope note: This report distinguishes manuscript content, externally verified metadata, and AI reviewer inference. No external PDF, Word, RIS, BibTeX, or document file was downloaded.

## 1. Search Strategy

### Main Questions

1. Does the manuscript's central mechanism fit the current literature on CDK4/6 inhibitor resistance, mt-dsRNA surveillance, innate RNA sensing, immunoproteasome remodeling, and RB destabilization?
2. Are the cited references real, correctly described, and aligned with the claims they support?
3. What would a simulated peer-review panel flag as conceptual, methodological, translational, and writing weaknesses?

### Search Tracks

| Track | Search intent | Search examples | Preferred sources |
|---|---|---|---|
| T1 Clinical context | Breast cancer burden, HR+/HER2- frequency, CDK4/6 standard of care, RB1 mutation frequency | `"Cancer statistics, 2026"`, `"RB1 mutation 2% 9% CDK4/6 inhibitor resistance"` | PubMed, WHO/IARC, ASCO/JCO, reviews |
| T2 Core datasets | Confirm GEO dataset identity and design | `GSE186901`, `GSE241943`, `GSE262288` | NCBI GEO visible accession pages |
| T3 Mechanistic foundation | mt-dsRNA, SUV3/PNPase/C1QBP, RIG-I/MDA5/IRF3 | `"mitochondrial double-stranded RNA triggers antiviral signalling"`, `"RNA 5-methylcytosine C1QBP"` | PubMed, journal metadata pages |
| T4 CDKi-RB axis | RB degradation, E2F reactivation, CDKi adaptation | `"Sequential activation of E2F via Rb degradation"` | PubMed, Cell Reports/Nature pages |
| T5 Immunoproteasome translation | PSMB8/PSMB9/ONX-0914/KZR-616 | `"ONX-0914 immunoproteasome"`, `"KZR-616 zetomipzomib immunoproteasome"` | PubMed, PMC, ClinicalTrials.gov |
| T6 Citation red flags | Validate out-of-field or suspicious references | exact title searches for Refs 76, 86, 107 | PubMed/search result metadata |

## 2. Search Record

| # | Tool/source route | Query or URL | Result | Use in review |
|---|---|---|---|---|
| S1 | CloakBrowser -> PubMed | `Cancer statistics, 2026 CA Cancer J Clin` | Found Siegel et al. 2026, CA Cancer J Clin 76(1):e70043, DOI 10.3322/caac.70043, PMID 41528114. PubMed abstract snippet indicates U.S. projected cancer cases/deaths. | Ref 1 exists, but manuscript's claim says WHO/IARC/GLOBOCAN global statistics; this is a claim-source mismatch. |
| S2 | CloakBrowser -> PubMed | exact search for Ref 76 | Access check/reCAPTCHA triggered; screenshot recorded temporarily, then public metadata route used. | Ref 76 is real but unrelated to mitochondrial RNA/CDKi. |
| S3 | Web search fallback for public metadata | `"Unselfish traits and social decision-making patterns characterize six populations"` | Found PubMed/Nature Communications metadata; topic is extraordinary altruists/social decision-making. | Citation mismatch red flag. |
| S4 | Web search fallback | `"Burst firing in Alzheimer's disease: A shift beyond amyloid"` | Found PubMed metadata; Cell 2025 commentary on Alzheimer's disease. | Citation mismatch red flag. |
| S5 | Web search fallback | `"TGF-beta is elevated in hyperuricemic individuals"` | Metadata indicates hyperuricemia/mononuclear-cell inflammation, not KZR-616/immunoproteasome clinical development. | Citation mismatch red flag for Ref 107. |
| S6 | CloakBrowser -> NCBI GEO | `GSE186901` | GEO: longitudinal multi-omics study of palbociclib resistance in HR+/HER2- MBC; baseline and PD tumors from 67 patients; 90 WTS samples. | Dataset use broadly appropriate. |
| S7 | CloakBrowser -> NCBI GEO | `GSE241943` | GEO: MCF7 xenografts treated with OP-1250 and/or palbociclib/ribociclib for 30 days; 32 samples. | Dataset is CDKi-treated xenograft, but not primarily a resistance model; manuscript should describe it more narrowly. |
| S8 | CloakBrowser -> NCBI GEO | `GSE262288` | GEO: scRNA-seq HR+/HER2- mBC baseline/progression samples; early progressors n=3, late progressors n=8; citation Luo et al. 2025 Mol Cancer. | Dataset use appropriate, but early/late group size limitations should be stated. |
| S9 | Web search | `"RB1 mutations 2-9% CDK4/6 inhibitor resistance"` | Frontiers review reports 2-9% incidence at progression, citing Asghar et al. 2022. | Supports manuscript's 2-9% claim, with proper caveat. |
| S10 | Web search | `"RNA 5-methylcytosine marks mitochondrial double-stranded RNAs"` | Found Kim et al. 2024 Mol Cell metadata; C1QBP recognizes m5C-modified mtRNAs and recruits PNPT1 for turnover. | Strong support for C1QBP/mt-dsRNA rationale. |
| S11 | Web search | `"Mitochondrial double-stranded RNA triggers antiviral signalling in humans"` | Found Dhir et al. 2018 Nature/PubMed; SUV3/PNPase restrict mt-dsRNA, MDA5-driven antiviral signaling. | Supports mt-dsRNA surveillance foundation; note sensor may be MDA5 in this canonical paper, while manuscript proposes RIG-I dominance in CDKi context. |
| S12 | Web search | `"Sequential activation of E2F via Rb degradation"` | Found Kim et al. 2023 Cell Reports metadata. | Supports RB degradation/CDKi resistance premise. |
| S13 | Web search | `"CDK4/6 inhibition triggers anti-tumour immunity"` | Found Goel et al. 2017 Nature metadata. | Supports CDKi-immune signaling background. |
| S14 | Web search | `"KZR-616 zetomipzomib immunoproteasome inhibitor"` | Found PMC/clinical trial metadata; KZR-616 is a selective immunoproteasome inhibitor investigated in autoimmune disorders. | Supports translational statement, but manuscript's Ref 107 is wrong source. |

Sources consulted include: PubMed pages for Siegel 2026, Dhir 2018, Kim 2023, Kim 2024, Goel 2017; NCBI GEO accession pages for GSE186901, GSE241943, GSE262288; WHO/IARC breast cancer statistics pages; ClinicalTrials.gov/PMC metadata for KZR-616/zetomipzomib.

## 3. Candidate Literature Table

| Priority | Citation / source | Verified metadata status | Relevance to manuscript | Recommendation |
|---|---|---|---|---|
| Core | Dhir et al., 2018, Nature, `Mitochondrial double-stranded RNA triggers antiviral signalling in humans`, DOI 10.1038/s41586-018-0363-0 | Verified via PubMed/search metadata | Foundational mt-dsRNA surveillance via SUV3/PNPase and innate immune activation | Keep; discuss MDA5 vs RIG-I sensor specificity more carefully. |
| Core | Kim et al., 2024, Molecular Cell, `RNA 5-methylcytosine marks mitochondrial double-stranded RNAs for degradation and cytosolic release`, DOI 10.1016/j.molcel.2024.06.023 | Verified | Strong support for C1QBP-mediated mtRNA turnover model | Keep; cite as direct mechanistic foundation for C1QBP. |
| Core | Kim et al., 2023, Cell Reports, `Sequential activation of E2F via Rb degradation and c-Myc drives resistance to CDK4/6 inhibitors in breast cancer`, DOI 10.1016/j.celrep.2023.113198 | Verified | Supports RB degradation as a CDKi resistance route | Keep; compare your immunoproteasome-RB mechanism against this model explicitly. |
| Core | Goel et al., 2017, Nature, `CDK4/6 inhibition triggers anti-tumour immunity`, DOI 10.1038/nature23465 | Verified | CDKi-induced immune/interferon background | Keep; use to contrast antitumor immunity vs tumor-intrinsic adaptive survival. |
| Core | Park et al., 2023, Genome Medicine; GEO GSE186901 | GEO verified; article metadata likely matches | Clinical palbociclib resistance baseline/PD bulk transcriptome | Keep; state accession and cohort design precisely. |
| Core | Luo et al., 2025, Molecular Cancer; GEO GSE262288 | GEO verified | scRNA-seq early/late progressor analysis | Keep; disclose small early-progressor group and metastatic-site heterogeneity. |
| Support | Lopez-Polo et al., 2024, Nature Communications, mt-dsRNA in senescence/SASP | Verified | Bridges mt-dsRNA and senescence-associated inflammatory phenotype | Add or emphasize in Discussion to connect CDKi cytostasis/senescence to mt-dsRNA. |
| Support | Hong et al., 2024, Cell Death Discovery, RB nuclear translocation/multistep CDKi response | Verified | Provides dynamic CDKi response context | Keep as background; do not overstate as resistance-specific. |
| Support | Rehwinkel & Gack, 2020, Nat Rev Immunol, RIG-I-like receptors | Verified indirectly via PubMed metadata/search | RLR biology | Keep; use for sensor-specific phrasing. |
| Support | Asghar et al., 2022, JCO Precision Oncology systematic review | Verified via PubMed/search metadata | Supports RB1 mutation frequency and resistance biomarkers | Keep; cite directly for 2-9% claim. |
| Support | Zhou et al., 2023, Front Cell Dev Biol CDK4/6i resistance perspective | Verified via search metadata | Provides 2-9% at progression and resistance framework | Use as secondary review, not primary evidence. |
| Support | Zetomipzomib/KZR-616 clinical trial or review source | Verified via PMC/ClinicalTrials.gov metadata | Supports claim that clinical-stage immunoproteasome inhibitors exist | Replace Ref 107 with a direct KZR-616 source. |
| Red flag | Rhoads et al., 2023, Nat Commun extraordinary altruists | Verified, but unrelated | Currently Ref 76; no apparent relevance to mtRNA/CDKi | Remove or replace. |
| Red flag | Lopes & Pousinha, 2025, Cell Alzheimer's commentary | Verified, but unrelated | Currently Ref 86; no apparent relevance to immunoproteasome/cancer | Remove or replace. |
| Red flag | Kluck et al., 2023, Arthritis Res Ther hyperuricemia/TGF-beta | Verified, but wrong support for KZR-616 | Currently Ref 107; does not support clinical-stage immunoproteasome inhibitor statement | Replace. |

## 4. Literature Matrix

| Manuscript claim | Manuscript location | Current support | Verification judgment | Needed action |
|---|---|---|---|---|
| Breast cancer is the most common malignancy among women worldwide; HR+/HER2- about 65-70% | Abstract; p.14 | WHO/IARC support 2022 global breast cancer burden; Ref 1 is ACS U.S. cancer statistics 2026, not WHO/IARC/GLOBOCAN | Partly correct, citation mismatch | Cite WHO/IARC/GLOBOCAN 2022 or Sung/Bray global statistics for global claim; keep ACS only for U.S. statistics. |
| CDK4/6 inhibitors plus endocrine therapy are standard for advanced HR+/HER2- breast cancer | p.15 | ASCO guideline/reviews support | Correct | Good; add current guideline wording if target journal expects clinical precision. |
| RB1 mutations after CDKi are only about 2-9%, lower than clinical resistance | Abstract; p.17 | Asghar 2022 / Zhou 2023 support range at progression | Correct with caveat | Say "reported in some progression cohorts/reviews" rather than universal frequency. |
| mt-dsRNA accumulation can activate innate RNA sensing | p.21-25, p.30-35 | Dhir 2018 and later mt-dsRNA literature support | Correct | Clarify that canonical mt-dsRNA examples often emphasize MDA5; your CDKi-specific RIG-I dominance is a new finding requiring direct mechanistic evidence. |
| C1QBP is linked to mtRNA surveillance and mt-dsRNA turnover | p.26, p.34, p.42-43 | Kim 2024 Mol Cell supports C1QBP/m5C/Pnpt1 recruitment | Strong | Keep; add more detail about whether C1QBP acts as reader/adaptor rather than general degradation enzyme. |
| CDKi-treated xenograft dataset GSE241943 represents in vivo CDKi-treated model | p.30, p.50 | GEO says MCF7 xenografts treated with OP-1250 and/or palbociclib/ribociclib | Partly correct | Describe as short-term pharmacologic treatment/transcriptional-response xenograft, not resistance model. |
| GSE262288 early-PD vs late-PD tumor-cell analysis supports clinical relevance | p.31, p.34-38, p.50 | GEO confirms scRNA-seq with early progressors n=3 and late progressors n=8 | Correct but fragile | Add limitation: small EP group, heterogeneous metastatic sites, baseline/progression mixture. |
| Immunoproteasome induction destabilizes RB | p.38-40, p.45-47 | Your data support; external literature supports immunoproteasome biology but not yet this exact RB mechanism in CDKi-treated breast cancer | Novel but under-validated | Strengthen with RB ubiquitination/substrate validation and direct proteasome dependency assays. |
| ONX-0914 targets immunoproteasome / PSMB8-PSMB9 axis | p.39-47 | External sources support ONX-0914 as immunoproteasome inhibitor, commonly beta5i/LMP7-focused; exact PSMB8/PSMB9 wording should be precise | Needs wording refinement | Say ONX-0914 is an immunoproteasome-selective inhibitor with strong LMP7/PSMB8 targeting; avoid implying equal direct targeting of PSMB8 and PSMB9 unless supported by cited pharmacology. |
| KZR-616/zetomipzomib shows clinical feasibility of selective immunoproteasome inhibition | p.47 | External sources support autoimmune/inflammatory clinical investigation | Correct claim, wrong citation | Replace Ref 107 with a KZR-616/zetomipzomib review or ClinicalTrials.gov citation. |

## 5. Field Analysis And Reviewer Configuration

### Field Analysis

| Dimension | Assessment |
|---|---|
| Primary discipline | Cancer biology / molecular oncology |
| Secondary disciplines | Mitochondrial RNA biology; innate immunity; proteostasis/pharmacology; translational breast cancer therapy |
| Research paradigm | Experimental mechanistic study with public transcriptomic/scRNA-seq validation and in vivo mouse treatment |
| Methodology type | Cell-line perturbation, xenograft/orthotopic mouse model, IHC/IF/qPCR/western blot, public transcriptomic reanalysis, drug-combination functional assays |
| Target journal tier | Q2-Q1 cancer biology/translational oncology if core mechanism is validated; currently closer to strong thesis/progress-report manuscript than final journal article |
| Paper maturity | Revised draft / pre-submission mechanistic draft, but citation accuracy, methods reporting, figure quantification details, and translational caveats need tightening |

### Simulated Review Panel

1. EIC: Associate Editor, translational oncology journal, focused on novelty, clinical relevance, and whether the mechanistic claim is strong enough for an international readership.
2. Reviewer 1 Methodology: Molecular oncology methods reviewer specializing in RNA biology, cell-cycle assays, perturbation-rescue logic, and public omics reanalysis.
3. Reviewer 2 Domain: Breast cancer/CDK4/6 resistance expert focused on literature positioning, resistance mechanisms, and citation accuracy.
4. Reviewer 3 Perspective: Cancer immunology/proteostasis translational reviewer focused on immune consequences, druggability, toxicity, and patient-selection logic.
5. Devil's Advocate: Mechanistic stress-test reviewer focused on whether the causal chain from CDKi to C1QBP loss to mt-dsRNA to RIG-I/IRF3 to immunoproteasome to RB degradation is proven rather than assembled from correlated steps.

## 6. Simulated Reviewer Reports

### EIC Review

Recommendation: Major Revision  
Confidence: 4/5

The manuscript proposes a compelling mechanism in which CDK4/6 inhibitor exposure creates early mitochondrial RNA surveillance failure, leading to mt-dsRNA accumulation, RIG-I-IRF3 signaling, immunoproteasome remodeling, RB destabilization, and cell-cycle re-entry. The topic is timely and potentially important because it addresses the gap between low RB1 mutation frequency and high clinical resistance. The strongest feature is the integrated trajectory from clinical data, public omics, in vitro models, and in vivo combination treatment. However, for an international journal, the current manuscript still overstates some translational conclusions and contains several citation mismatches that would weaken editorial confidence. The central mechanism is promising, but the manuscript must more sharply distinguish what is directly demonstrated from what is inferred.

Key strengths:

1. Clear mechanistic hypothesis linking early adaptive stress to later CDKi escape.
2. Strong disease relevance: HR+/HER2- CDKi resistance remains clinically important.
3. The study connects RNA surveillance, innate sensing, proteostasis, and RB biology in a novel way.

Key weaknesses:

1. Several citations do not support the claims attached to them, including global cancer statistics and immunoproteasome translational claims.
2. The Discussion sometimes turns a preclinical mechanism into a therapeutic strategy too quickly.
3. Dataset descriptions need more exact framing, especially GSE241943 and the small early-progressor group in GSE262288.

### Reviewer 1: Methodology

Recommendation: Major Revision  
Confidence: 4/5

The experimental logic is coherent but needs stronger causal closure. The manuscript uses multiple perturbations: IMT1, C1QBP restoration, RIG-I/MDA5/IRF3 knockdown, PSMB8/PSMB9 knockdown, proteasome/immunoproteasome inhibitors, EdU, CHX chase, and xenograft treatment. This is a good mechanistic toolkit. The main methodological weakness is that several key links are still inferred from rescue patterns rather than directly demonstrated. In particular, the claim that immunoproteasome remodeling directly destabilizes RB needs biochemical confirmation.

Major methodological issues:

1. RB degradation mechanism: show RB ubiquitination, proteasome dependency, immunoproteasome association, or substrate-trapping evidence. Current CHX/rescue data support altered stability but do not establish direct immunoproteasome-mediated degradation.
2. RIG-I specificity: canonical mt-dsRNA surveillance literature often implicates MDA5 for long mt-dsRNA. Your result that RIG-I is dominant under CDKi is interesting, but it needs RNA feature characterization: length, 5' phosphate state, dsRNA structure, protein association, and whether RIG-I physically engages the enriched RNA species.
3. Public omics reproducibility: methods describe GSEA/ssGSEA and trajectory analyses, but should report software versions, gene sets, filtering thresholds, covariates, multiple-testing correction, and sample-level independence.
4. Drug combination interpretation: use synergy/additivity models where possible. "Enhanced efficacy" is acceptable, but synergy should not be implied unless quantified.
5. In vivo toxicity and tolerability: body weight, blood counts, and immune-cell consequences are important for CDKi plus proteasome/immunoproteasome blockade.

### Reviewer 2: Domain / Literature Accuracy

Recommendation: Major Revision  
Confidence: 4/5

The manuscript is well positioned in the broad CDK4/6 resistance field, and the 2-9% RB1 mutation rationale is supported by current reviews. The strongest domain contribution is to frame functional RB insufficiency as a non-genetic, proteostasis-linked adaptive state. However, the literature review needs a stricter citation audit. A reviewer would likely notice unrelated references in the bibliography and question the reliability of the citation pipeline.

Major domain issues:

1. Ref 1 exists but is U.S. ACS cancer statistics; it should not be used as WHO/IARC/GLOBOCAN global breast cancer evidence.
2. Ref 76 is about extraordinary altruists and appears unrelated to mitochondrial RNA biology. Remove or replace.
3. Ref 86 is a Cell commentary on Alzheimer's disease. Remove or replace unless there is a very specific proteostasis point, which is not apparent.
4. Ref 107 is about TGF-beta in hyperuricemia, not KZR-616/zetomipzomib. Replace with direct KZR-616 immunoproteasome clinical-development evidence.
5. GSE241943 should not be framed as a CDKi resistance dataset. It is an OP-1250/CDKi-treated MCF7 xenograft transcriptomic dataset.

Suggested references to strengthen positioning:

1. Dhir et al. 2018 Nature for mt-dsRNA surveillance.
2. Kim et al. 2024 Molecular Cell for C1QBP/m5C/mt-dsRNA turnover.
3. Kim et al. 2023 Cell Reports for RB degradation in CDKi resistance.
4. Lopez-Polo et al. 2024 Nature Communications for mt-dsRNA in senescence/SASP.
5. Direct KZR-616/zetomipzomib clinical or review source for selective immunoproteasome inhibitor translation.

### Reviewer 3: Cross-Disciplinary / Translational Perspective

Recommendation: Major Revision  
Confidence: 3/5

From a cancer immunology and translational pharmacology perspective, the study's most valuable idea is also its main risk: the same mt-dsRNA/interferon/immunoproteasome axis may have opposite effects depending on compartment and timing. CDK4/6-induced immune activation can support antitumor immunity, antigen presentation, and T-cell responses, yet the manuscript emphasizes a tumor-cell-intrinsic adaptive survival role. This duality is plausible but needs clearer boundaries.

Cross-disciplinary issues:

1. Tumor-intrinsic vs microenvironmental effects: In vivo ONX-0914 may affect immune cells as well as tumor cells. The manuscript should not assume all in vivo benefit is tumor-cell-intrinsic RB preservation.
2. Timing: The model depends on early adaptive intervention. Define when the therapeutic window opens and closes.
3. Patient selection: propose biomarkers such as RB1 wild-type status, C1QBP decrease, mt-dsRNA/J2 signal, IRF3 activation, PSMB8/PSMB9 induction, and RB protein loss.
4. Clinical feasibility: broad proteasome inhibitors have toxicity; immunoproteasome-selective agents are more plausible but still not established in breast cancer.
5. Immune-risk caveat: inhibiting immunoproteasome could reduce antigen processing or alter antitumor immunity. This must be discussed as a translational tradeoff, not only as a therapeutic opportunity.

### Devil's Advocate Stress Test

Strongest counter-argument:

The manuscript's central pathway may be a coherent post hoc assembly of stress-associated markers rather than a single linear mechanism. CDK4/6 inhibition can induce cell-cycle arrest, senescence-like programs, mitochondrial remodeling, interferon signaling, and proteostasis changes in parallel. The observed C1QBP decrease, mt-dsRNA accumulation, RIG-I/IRF3 activation, PSMB8/PSMB9 induction, RB decrease, and S-phase re-entry may therefore be co-occurring features of a broader adaptive state rather than a strict causal cascade. Rescue experiments support pathway involvement, but do not yet prove that C1QBP loss is the initiating event, that the relevant dsRNA species are direct RIG-I ligands, that IRF3 directly drives immunoproteasome remodeling, or that immunoproteasome directly degrades RB. A skeptical reviewer could argue that ONX-0914 improves CDKi response by broadly altering proteostasis or immune signaling, with RB restoration as a downstream correlate rather than the main mechanism.

Issue list:

| Severity | Dimension | Issue | Location | Suggested fix |
|---|---|---|---|---|
| Critical/Major | Logic chain | Direct causality across the full axis is not fully closed | Results Figures 2-6; Discussion p.41-47 | Add a causal chain figure separating demonstrated links from inferred links; add direct assays for dsRNA-RIG-I binding, IRF3-to-PSMB8/9 regulation, and RB degradation. |
| Major | Alternative explanation | General CDKi stress/senescence could explain mt-dsRNA and immunoproteasome changes | p.20-21, p.41-44 | Test senescence/SASP markers and show the axis is not merely a senescence byproduct. |
| Major | Overgeneralization | Preclinical ONX-0914 findings are translated toward clinical strategy too strongly | p.46-49 | Reframe as preclinical rationale; add toxicity and immune-function caveats. |
| Major | Citation integrity | Multiple unrelated references undermine trust | References 76, 86, 107; p.14 and p.47 claims | Conduct full citation audit before submission. |
| Minor | Terminology | ONX-0914 target wording may imply equal PSMB8/PSMB9 direct inhibition | p.39, p.47 | Specify ONX-0914 pharmacology precisely. |

## 7. Editorial Synthesis

Decision: Major Revision

The panel agrees that the manuscript has a strong, novel, and potentially publishable mechanistic concept. The major barrier is not lack of importance; it is evidentiary closure and citation reliability. The EIC and domain reviewer both flag claim-source mismatches. The methodology reviewer and Devil's Advocate converge on the same core scientific issue: the pathway is plausible and supported by rescue data, but several mechanistic links remain indirect. The translational reviewer adds that in vivo immunoproteasome inhibition has immune-cell and toxicity implications that the current Discussion underplays.

Required revisions:

| # | Revision item | Source | Priority | Acceptance criteria |
|---|---|---|---|---|
| R1 | Perform a full citation audit and replace unrelated/mismatched references | EIC, R2, DA | P1 | No unrelated references remain; each high-level claim has a direct source. |
| R2 | Reframe global breast cancer statistics with WHO/IARC/GLOBOCAN 2022 or equivalent global source | R2 | P1 | p.14 and Abstract distinguish global vs U.S. estimates. |
| R3 | Clarify GSE241943 as OP-1250/CDKi xenograft treatment data, not resistance data | R1, R2 | P1 | Methods/Results accurately describe accession design. |
| R4 | Strengthen or qualify direct immunoproteasome-mediated RB degradation | R1, DA | P1 | Add direct RB ubiquitination/proteasome/substrate evidence, or downgrade language to "associated with/promotes RB destabilization." |
| R5 | Define why RIG-I, rather than MDA5, is dominant in this CDKi-induced mt-dsRNA context | R1, DA | P1 | Add RNA feature data or direct RIG-I engagement evidence; at minimum discuss Dhir 2018 MDA5 precedent. |
| R6 | Add translational caveats for ONX-0914/KZR-616, toxicity, immune-cell effects, and timing | R3 | P1/P2 | Discussion states this is preclinical and biomarker-dependent. |
| R7 | Improve public omics methods reproducibility | R1 | P2 | Include versions, gene sets, cutoffs, multiple testing, and sample grouping details. |
| R8 | Add a limitations subsection | All reviewers | P2 | Addresses small clinical sample size, public dataset heterogeneity, lack of direct lineage tracing, and direct substrate evidence. |

## 8. Research Gaps

1. Upstream trigger gap: What molecular event causes C1QBP downregulation after CDK4/6 inhibition? Possibilities include transcriptional repression, altered translation, protein degradation, mitochondrial import defects, or RB/E2F-dependent regulation.
2. Ligand identity gap: What are the exact molecular features of CDKi-induced mt-dsRNA that make RIG-I functionally dominant? Length, 5' end chemistry, modifications, binding proteins, and subcellular route remain unresolved.
3. Direct transcriptional wiring gap: Does IRF3 directly regulate PSMB8/PSMB9, or is immunoproteasome induction mediated through IFNAR/JAK-STAT or another inflammatory circuit?
4. RB substrate gap: Is RB a direct immunoproteasome substrate, indirectly destabilized through altered E3 ligases/deubiquitinases, or reduced through broader proteostasis remodeling?
5. Cell-state lineage gap: Are mt-dsRNA-high/C1QBP-low cells true precursors of later acquired CDKi-resistant clones, or only a transient stress population?
6. Tumor microenvironment gap: Does immunoproteasome inhibition improve CDKi response through tumor-intrinsic RB preservation, immune-cell remodeling, or both?
7. Translational window gap: When should immunoproteasome inhibition be administered: upfront, during early adaptation, at minimal residual disease, or after progression?
8. Biomarker gap: Which marker combination best predicts benefit: RB1 wild-type, RB protein loss, PSMB8/PSMB9 induction, pIRF3, C1QBP loss, J2 mt-dsRNA signal, or a composite signature?

## 9. Writing And Presentation Problems

1. Overclaiming language: Replace "establishes" with "supports" where direct causal proof is incomplete.
2. Citation-to-claim mismatch: The most urgent writing problem is citation integrity, not grammar.
3. Methods are too compressed for reproducibility: Chapter 5 often names assays but omits key reagent identifiers, antibodies, statistical correction details, software versions, and exact public-data processing choices.
4. Results narrative sometimes repeats figure legends rather than building an argument. For each figure, start with the question, then result, then interpretation.
5. Discussion should distinguish "shown in this study", "consistent with prior literature", and "future hypothesis".
6. The manuscript needs a dedicated Limitations section before Conclusion.
7. Title is strong but dense. Consider: "Mitochondrial RNA Surveillance Failure Enables CDK4/6 Inhibitor Escape through Immunoproteasome-Dependent RB Destabilization."
8. Abstract should mention that ONX-0914 evidence is preclinical and that acquired clinical resistance validation remains future work.

## 10. Follow-Up Deep Reading List

Priority 1:

1. Dhir et al. 2018 Nature - mt-dsRNA, SUV3/PNPase, innate sensing.
2. Kim et al. 2024 Molecular Cell - C1QBP/m5C/mt-dsRNA turnover.
3. Kim et al. 2023 Cell Reports - RB degradation and CDKi resistance.
4. Park et al. 2023 Genome Medicine / GSE186901 - palbociclib resistance clinical dataset.
5. Luo et al. 2025 Molecular Cancer / GSE262288 - scRNA-seq predictors of CDKi progression.

Priority 2:

6. Goel et al. 2017 Nature - CDK4/6 inhibition and antitumor immunity.
7. Lopez-Polo et al. 2024 Nature Communications - mt-dsRNA in senescent inflammatory phenotype.
8. Rehwinkel & Gack 2020 Nat Rev Immunol - RIG-I-like receptor biology.
9. Asghar et al. 2022 JCO Precision Oncology - CDK4/6 resistance biomarkers.
10. KZR-616/zetomipzomib immunoproteasome clinical-development review or ClinicalTrials.gov records.

Priority 3:

11. ONX-0914 pharmacology and immunoproteasome subunit selectivity reviews.
12. Proteasome/immunoproteasome substrate-identification methods.
13. CDK4/6i combination-therapy toxicity and immune-monitoring literature.

## 11. Source Links

- PubMed search/result for Siegel et al. 2026: https://pubmed.ncbi.nlm.nih.gov/41528114/
- WHO breast cancer fact sheet: https://www.who.int/news-room/fact-sheets/detail/breast-cancer
- IARC breast cancer page: https://www.iarc.who.int/cancer-type/breast-cancer/
- GLOBOCAN 2022 global cancer statistics article: https://pubmed.ncbi.nlm.nih.gov/38572751/
- GEO GSE186901: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE186901
- GEO GSE241943: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE241943
- GEO GSE262288: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE262288
- Dhir et al. 2018 PubMed: https://pubmed.ncbi.nlm.nih.gov/30046113/
- Kim et al. 2024 Molecular Cell PubMed: https://pubmed.ncbi.nlm.nih.gov/39019044/
- Kim et al. 2023 Cell Reports PubMed: https://pubmed.ncbi.nlm.nih.gov/37865915/
- Goel et al. 2017 Nature: https://www.nature.com/articles/nature23465
- Lopez-Polo et al. 2024 Nature Communications: https://www.nature.com/articles/s41467-024-51363-0
- KZR-616/zetomipzomib PMC source: https://pmc.ncbi.nlm.nih.gov/articles/PMC10036830/

## 12. Cleanup Note

Temporary extracted text and browser CAPTCHA screenshot were used only for analysis and should be removed after final report creation. Reports are retained.
