# SMA circulating miRNA biomarker manuscript deep review

日期：2026-06-23  
模式：academic-research-suite / academic-paper-reviewer / full  
瀏覽與查證：優先使用 CloakBrowser Research；文獻 metadata 以 PubMed/NCBI 與 DOI 頁面核對  
使用者提供材料：`619664684761219092_20260622_.pdf`，Word 匯出 PDF，51 頁，建立時間 2026-06-23 02:01 CST

## 0. Executive summary

這份草稿的核心是探索 SMA 患者接受 nusinersen 治療後，plasma 與 CSF miRNA 是否可作為 prognostic 或 treatment-monitoring biomarkers。草稿目前最有價值的部分是：有 plasma small RNA-seq discovery、RT-qPCR validation、LP/MP longitudinal framing、多種 motor score 關聯、ROC matrix 與 CSF/NfL 補充分析。以研究方向來看，主題有發表潛力，且與近年 SMA biomarker 需求相符。

但以投稿稿件標準判斷，現在仍屬於「結果堆疊型工作稿」，不是完整 manuscript。主要問題不是單一段落寫不好，而是研究敘事與統計設計尚未鎖定：同一批資料中反覆用多個 miRNA、多個 motor scales、多個 phase、多個 cut-offs 探索 ROC，容易產生 optimism bias / multiple testing / circular threshold selection。草稿也缺完整 Abstract、Introduction、Methods、Discussion、References、ethics/data availability 等必要部分，PDF 內仍保留作者註解、`Ref.` placeholder、空白頁和圖文分離版面。

建議 editorial decision：**Reject and resubmit / Major restructuring required before submission**。這不是因為題目沒有價值，而是因為目前稿件尚未具備可審稿的完整結構與統計可信度。最優先修改是：把主 claim 降級為 exploratory/hypothesis-generating；預先定義 primary biomarker、primary outcome、primary phase；把 ROC matrix 改寫為探索性篩選，而非驗證性證據；補完整方法學細節與外部文獻支撐；新增 limitations，把 sample size、同資料 cut-off selection、缺 independent validation、未校正多重比較寫清楚。

## 1. 文件結構與原稿內容判讀

### 1.1 目前稿件實際內容

PDF 抽取後顯示正文從「Experimental workflow for circulating miRNA biomarker discovery and validation」開始，接續多個 results-style 小節，最後是 Conclusion。第 14 頁為空白頁，15 頁起主要是圖，16 頁起出現 figure legends。目視渲染確認：第 1 頁沒有正式 title page / abstract / introduction；第 14 頁空白；圖與圖說分頁嚴重，右側保留大塊 Word 註解欄空白。

目前可辨識內容：

| 部分 | 原稿內容 | 審稿判斷 |
|---|---|---|
| Workflow | Plasma/CSF collection, TRIzol-chloroform RNA extraction, cel-miR-39 spike-in, NGS small RNA-seq, RT-qPCR validation | 方向合理，但 Methods 細節不足 |
| Discovery cohort | 8 SMA patients, G/P group, LP/MP paired plasma, 16 plasma samples | discovery sample very small |
| Prognostic candidates | miR-675-5p, miR-10401-3p, miR-181c-5p, miR-519d-5p, miR-10a-3p, miR-4741, miR-6724-5p | candidate attrition 需更透明 |
| Plasma validation | miR-675-5p, miR-10a-3p, miR-181c-5p；後續又納入 miR-142-5p、miR-628-3p、let-7b-3p | prognostic vs monitoring 邊界混合 |
| ROC matrix | 多 motor scales / thresholds / miRNA panels | 目前最主要統計風險 |
| CSF analysis | plasma-derived miRNAs in CSF, miR-34 family, NfL reference biomarker | 有補強價值，但目前像 appendices 堆疊 |
| Conclusion | 指出 miR-628-3p、let-7b-3p、CSF miR-142-5p 等候選 biomarker | 結論已較謹慎，但仍需更明確區分 exploratory vs validated |

### 1.2 PDF/Word 留下的直接寫作問題

- 原稿保留作者註解，例如 miR-10a 是否應做 LP ROC 的疑問，這會使審稿人立即認定稿件未完成。
- 仍有 `Ref.` placeholder：例如 SMA beyond motor neurons/systemic components、miR-34 family biomarker relevance。
- 存在 typo：Conclusion 中 `has-miR-142-5p` 應為 `hsa-miR-142-5p`。
- 圖頁與圖說分離，部分頁面幾乎空白，圖說文字很長，讀者很難同步檢查結果。
- Figure 17 legend 有 `-log10(p-value.` 少右括號。
- `So, we used...`、`It can define...` 等句子不夠正式。
- `good-prognosis / good-response`、`poor-prognosis / poor-response / lesser-response` 用語混雜；原稿自己又說 P group 不是 clinical deterioration 或 absolute poor prognosis，建議全稿統一為 `greater motor-improvement group` 與 `lesser motor-improvement group`。

## 2. Reviewer configuration cards

| 角色 | 身分設定 | 核心審查重點 |
|---|---|---|
| EIC | Neuromuscular disorders / translational biomarker journal associate editor | 是否具備投稿完整性、臨床轉譯價值、讀者興趣、claim 是否符合證據 |
| R1 Methodology | Biomarker statistics / molecular diagnostics reviewer | discovery-validation split、sample size、ROC threshold selection、multiple testing、normalisation、replicability |
| R2 Domain | SMA / neuromuscular biomarker researcher | SMA miRNA / NfL / nusinersen response 文獻定位、機制與臨床量表解釋 |
| R3 Perspective | Clinical translation / assay implementation reviewer | biomarker utility、clinical workflow、biofluid feasibility、stakeholders、regulatory/diagnostic pathway |
| Devil's Advocate | Core-argument stress tester | 找出 strongest counter-argument、邏輯斷點、過度推論與替代解釋 |

## 3. Editorial decision package

### 3.1 Decision

**Decision: Reject and resubmit / Major restructuring before peer review.**

這份研究有潛力，但目前不是可投稿版本。核心原因是 manuscript incompleteness 加上 exploratory statistical strategy 的不穩定。若補齊 full manuscript structure，並把統計設計改成清楚的 exploratory discovery report，較適合轉為 Major Revision 等級。

### 3.2 Consensus issues

| Issue | EIC | R1 | R2 | R3 | DA | 結論 |
|---|---|---|---|---|---|---|
| 稿件結構不完整 | raised | raised | raised | raised | raised | 必修 |
| ROC/cut-off 同資料選擇風險 | raised | critical | raised | raised | critical | 必修 |
| claim 過度接近 biomarker validation | raised | raised | raised | raised | critical | 必修 |
| 文獻支撐不足/Ref placeholder | raised | noted | major | noted | major | 必修 |
| plasma/CSF 結果互補但不可互換 | noted | noted | raised | raised | raised | 必修 |
| multiple testing 未處理 | noted | critical | noted | noted | major | 必修 |
| clinical implementation 尚未定義 | raised | noted | noted | major | noted | 應修 |

## 4. Five-reviewer reports

### 4.1 EIC review

**Recommendation:** Reject and resubmit  
**Confidence:** 4/5

**Strengths**

1. **Timely translational topic.** SMA 治療進入 disease-modifying therapy era 後，response heterogeneity 與 biomarker demand 是真實問題。
2. **Multi-biofluid design.** Plasma 加 CSF 的設計可連接 systemic / CNS compartments，具備敘事潛力。
3. **Exploratory workflow clear.** 原稿有 discovery、validation、motor-score association、ROC screening 的雛形。
4. **Conclusion 已部分謹慎。** 結尾承認 limited cohort、same-dataset cut-off selection、independent validation requirement。

**Weaknesses**

1. **Manuscript not complete.** 缺 abstract、introduction、methods、discussion、references；目前像 Results + figure legends。
2. **Main message 過多。** miR-675、miR-10a、miR-142、miR-628、let-7b、miR-34a/c、NfL、single markers、panels、plasma、CSF 全部同時出現，讀者不知道 primary story 是哪一個。
3. **Journal fit 受限於成熟度。** 若目標為 translational neurology 或 biomarker journal，需更嚴格的方法學與獨立驗證；若目標為 exploratory neuromuscular biomarker note，可保留較多 hypothesis-generating language。
4. **Claim language 需再降級。** `emerged as the leading biomarker candidate` 可以，但 `predict`, `monitoring biomarker` 需加 `candidate`, `exploratory`, `requires independent validation`。

### 4.2 Methodology reviewer

**Recommendation:** Reject and resubmit / Major restructuring  
**Confidence:** 5/5

**Major methodological concerns**

1. **Outcome and threshold selection is data-driven.** 多個 miRNA、多個 phase、多個 motor scales、多個 thresholds 以 ROC matrix 挑最佳條件，若沒有 hold-out set 或 nested validation，AUC 與 p-value 會高估。
2. **Discovery and validation are not sufficiently independent.** discovery cohort 只有 8 人/16 plasma samples；validation set 包含 9 longitudinal + 14 unpaired plasma samples，但分層、phase、outcome、cut-off 的獨立性未交代。
3. **Multiple testing not addressed.** 草稿回報大量 nominal p-values，但沒有 FDR、family-wise correction、或清楚聲明 p-values are descriptive/exploratory。
4. **Composite miRNA panel construction is under-specified.** raw -ΔCt summation without z-score standardization, weighting, or direction reversal 很容易受 expression scale 主導；如果方向不同，summation 甚至可能抵消訊號。
5. **Statistical reporting incomplete.** 需要每個 ROC 的 N、positive/negative group counts、AUC CI、method for AUC SE、p-value method、correlation method、paired/unpaired test choice、missingness、outlier handling。
6. **Normalization strategy needs justification.** cel-miR-39 spike-in 可控制 extraction/RT variation，但不能完全處理 hemolysis、sample input、endogenous normalization、biofluid matrix effects；需報告 hemolysis QC 或 erythrocyte contamination controls。

**Suggested redesign**

- Declare one primary analysis, e.g. `LP plasma hsa-miR-628-3p for ΔMFM32 >= pre-specified MCID/clinically meaningful threshold`.
- Move all ROC matrix results to exploratory screening.
- Use bootstrap optimism correction or cross-validation only if N allows；否則明確標示 descriptive.
- Report exact sample counts per analysis, because LP-only、MP-only、CSF、plasma、paired/unpaired analyses 的 N 不同。
- Consider penalized/logistic modeling only as exploratory; do not fit multivariable panels with this sample size unless framed as pilot feasibility.

### 4.3 Domain reviewer

**Recommendation:** Major restructuring  
**Confidence:** 4/5

**Domain strengths**

1. **Topic aligns with recent SMA biomarker literature.** PubMed 查詢顯示 SMA miRNA、circulating biomarkers、NfL、multi-omics biomarkers 是活躍領域。
2. **The plasma/CSF distinction is scientifically plausible.** 草稿指出 plasma and CSF profiles should be complementary rather than interchangeable，這是合理敘事方向。
3. **miR-34 family is a plausible literature-informed addition.** 但目前仍以 `Ref.` placeholder 表示，需補正式引用。

**Domain weaknesses**

1. **文獻 review 幾乎未出現。** 應至少建立三層背景：SMA disease-modifying therapy response heterogeneity；既有 NfL/proteomic/miRNA biomarkers；plasma vs CSF biological interpretation。
2. **miRNA candidate biology 未充分連接。** 例如 miR-142、miR-628、let-7b、miR-675、miR-34a/c 是否與 muscle, immune, neuronal injury, extracellular vesicles, SMN pathway 有關，需分清楚 direct SMA relevance 與 generic circulating miRNA relevance。
3. **NfL 角色需更準確。** 草稿將 NfL 作為 reference biomarker 是合理的，但不應因本 cohort 未見 LP/MP phase change 就暗示其 monitoring value 弱；NfL 可能受年齡、disease stage、治療時點、早期/晚期 SMA 影響。
4. **引用格式不可只放 DOI 或 Ref.** 例如多 miRNA panel 類比引用了 breast cancer early detection panel，方法學上可當「multi-marker panel concept」例子，但不能當 SMA-specific evidence。

### 4.4 Perspective reviewer

**Recommendation:** Major revision after restructuring  
**Confidence:** 3/5

**Clinical translation concerns**

1. **Clinical use-case 尚未定義。** Prognostic biomarker 是 treatment initiation 前預測？loading phase 中早期預測？maintenance monitoring？每一種 use-case 的 sample timing、decision point、clinical consequence 不同。
2. **Motor scales are not interchangeable.** HFMSE、RULM L/R、MFM32 反映不同 motor domains；若用 ROC matrix 自動挑最好的 scale，需說明臨床上為何該 scale/cut-off 合理。
3. **Biofluid feasibility differs.** Plasma 較可臨床化；CSF 伴隨 nusinersen lumbar puncture 可取得，但若未來治療轉向口服或基因治療，CSF routine collection 的場景不同。
4. **Assay implementation missing.** 若目標是 biomarker development，需討論 sample handling、hemolysis、RNA extraction reproducibility、RT-qPCR assay availability、limit of detection、inter-run variation。

### 4.5 Devil's advocate stress test

**Strongest counter-argument**

The strongest critique is that the manuscript may be discovering the structure of its own dataset rather than identifying reliable SMA treatment-response biomarkers. The evidence comes from a very small cohort, multiple candidate miRNAs, multiple sample phases, multiple biofluids, several motor scales, numerous dichotomized thresholds, and repeated ROC matrix selection. Several reported AUCs and nominal p-values are then interpreted as biomarker promise even though the cut-offs were selected in the same data and no independent validation cohort is available. This means the apparent best-performing marker may be an artifact of flexible analysis choices. The manuscript partially acknowledges this in the conclusion, but the body still builds a biomarker narrative around selected winners. Unless the authors predefine primary outcomes, label the ROC matrix as exploratory, and avoid validation language, a reviewer could argue that the current data support only hypothesis generation, not prognostic or monitoring biomarker discovery.

**Critical / major issues**

| Severity | Dimension | Issue | Location |
|---|---|---|---|
| Critical | Data-conclusion mismatch | ROC-based biomarker claims rely on same-dataset cut-off selection and multiple testing without independent validation | pp. 4, 6-13 |
| Major | Logic chain | miR-10a is excluded from ROC despite LP negative association; internal author note indicates unresolved decision logic | pp. 3-4 |
| Major | Evidence gap | `Ref.` placeholders leave key biological claims unsupported | pp. 10-12 |
| Major | Overgeneralization | `monitoring biomarker` language stronger than current exploratory sample supports | pp. 6, 11-13 |
| Major | Alternative explanations | phase-associated miRNA changes may reflect disease duration, sampling timing, treatment schedule, hemolysis, inflammation, or peripheral tissue changes rather than treatment response | throughout |

## 5. 搜尋策略

### 5.1 Research questions used for external check

1. SMA patients treated with nusinersen: what is known about circulating plasma/CSF miRNAs as prognostic or treatment-response biomarkers?
2. What does the literature say about CSF/plasma NfL as a treatment or disease-activity biomarker in SMA?
3. Is miR-34 family connected to SMA pathogenesis or biomarker relevance?
4. Is the manuscript's use of multi-miRNA ROC panels methodologically defensible?

### 5.2 Search strings

| # | Query | Source / route | Purpose |
|---|---|---|---|
| S1 | `(spinal muscular atrophy) AND (microRNA OR miRNA) AND (nusinersen OR biomarker OR circulating OR plasma OR CSF)` | PubMed via CloakBrowser; NCBI E-utilities metadata | SMA miRNA biomarker core set |
| S2 | `(spinal muscular atrophy) AND (nusinersen) AND (neurofilament OR NfL OR biomarker)` | PubMed via CloakBrowser; NCBI E-utilities metadata | NfL/reference biomarker context |
| S3 | `(spinal muscular atrophy) AND (miR-34 OR microRNA-34 OR mir34)` | PubMed/NCBI metadata | miR-34 placeholder check |
| S4 | DOI `10.1038/s41416-021-01593-6` | DOI/Nature page via CloakBrowser | Check multi-miRNA panel analogy |

### 5.3 Search record

| Time | Action | Result |
|---|---|---|
| 2026-06-23 | Opened PubMed S1 in CloakBrowser | 37 results; top relevant items included Magri 2018, Chen 2020, Barbo 2024, Quaglia/Giorgia 2023, Doi/Yamashita-related plasma miRNA papers |
| 2026-06-23 | Opened PubMed S2 in CloakBrowser | 121 results; top page included NfL/SMA articles, 2024/2026 biomarker papers |
| 2026-06-23 | Queried NCBI E-utilities for S1-S3 | Candidate PMID list extracted and DOI metadata cleaned |
| 2026-06-23 | Opened DOI 10.1038/s41416-021-01593-6 | Confirmed article is a British Journal of Cancer circulating miRNA panel paper, not SMA-specific |
| 2026-06-23 | No external PDFs downloaded | No literature files retained in downloads |

## 6. 候選文獻表

| Priority | Citation | DOI / PMID | Why it matters for this manuscript | Use |
|---|---|---|---|---|
| High | Doi et al. 2022, `Response of plasma microRNAs to nusinersen treatment in patients with SMA` | DOI 10.1002/acn3.51579; PMID 35584175 | Direct plasma miRNA + nusinersen response evidence | Must cite in Introduction/Discussion |
| High | `Muscle microRNAs in the cerebrospinal fluid predict clinical response to nusinersen therapy...` 2022 | DOI 10.1111/ene.15382; PMID 35510740 | Direct CSF miRNA + clinical response evidence | Must cite for CSF framing |
| High | `Assessment of cerebral spinal fluid biomarkers and microRNA-mediated disease mechanisms...` 2022 | DOI 10.1093/hmg/ddab365; PMID 34919695 | CSF biomarkers and miRNA disease mechanisms | Supports CSF rationale |
| High | `Identification of Novel CSF-Derived miRNAs in Treated Paediatric Onset SMA` 2023 | DOI 10.3390/pharmaceutics15010170; PMID 36678797 | Exploratory CSF miRNA biomarker study | Compare methods and limitations |
| High | Barbo et al. 2024, `MicroRNAs as Biomarkers in Spinal Muscular Atrophy` | DOI 10.3390/biomedicines12112428; PMID 39594995 | Recent review | Literature positioning |
| High | Quaglia/Giorgia et al. 2023, `Role of circulating biomarkers in SMA` | DOI 10.3389/fneur.2023.1226969; PMID 38020652 | Reviews circulating biomarkers in new treatment era | Intro/Discussion |
| High | Darras et al. 2019, `Neurofilament as a potential biomarker for SMA` | DOI 10.1002/acn3.779; PMID 31139691 | Foundational SMA neurofilament biomarker evidence | NfL framing |
| High | Andres-Benito et al. 2024, `Neurodegeneration Biomarkers in Adult SMA Patients Treated with Nusinersen` | DOI 10.3390/ijms25073810; PMID 38612621 | Adult SMA/nusinersen biomarker context | NfL/reference biomarker comparison |
| Medium | `The Dynamics of Neurofilament Light Chain in SMA` 2026 | DOI 10.1002/ana.78207; PMID 41845532 | Current NfL dynamics evidence | Update NfL discussion |
| Medium | `Plasma NfL as a Potential Biomarker of Presymptomatic SMA` 2026 | DOI 10.1002/mus.70155; PMID 41556253 | Presymptomatic pNfL dynamics | Boundary condition for NfL |
| Medium | `RNA biomarkers in SMA: enhancing pathogenesis understanding and guiding precision medicine` 2026 | DOI 10.1007/s00018-026-06164-7; PMID 41817636 | Recent RNA biomarker review | Broader framing |
| Medium | `MyomiR Networks in SMA` 2026 | DOI 10.1007/s12035-026-05862-4; PMID 42062642 | MyomiR networks, severity/response | Candidate biology |
| Medium | `Longitudinal multi-omics profiling of SMA` 2026 | DOI 10.1016/j.neurot.2026.e00880; PMID 41825231 | Multi-omics treatment heterogeneity | Supports multi-marker rationale |
| Medium | `MiR34 contributes to SMA...` 2023 | DOI 10.1016/j.omtn.2023.03.005; PMID 37064776 | Direct miR-34/SMA mechanistic support | Replace `Ref.` for miR-34 paragraph |
| Low/context | Zou et al. 2022, circulating miRNA breast cancer panel | DOI 10.1038/s41416-021-01593-6 | Methodological analogy for multi-miRNA panel; not SMA-specific | Cite cautiously only as panel-method precedent |

## 7. 文獻矩陣

| Evidence axis | Manuscript claim | Relevant literature | Strength | Gap |
|---|---|---|---|---|
| Plasma miRNAs respond to nusinersen | plasma miRNAs may track treatment response | Doi et al. 2022 direct plasma evidence | Moderate | Need compare overlapping miRNAs and sampling schedule |
| CSF miRNAs predict/associate with response | CSF miR-142-5p may monitor HFMSE improvement | CSF muscle miRNA 2022; CSF-derived miRNA 2023; HMG 2022 | Moderate | Need clarify whether candidate miRNAs overlap or are novel |
| miR-34 family relevance | miR-34a/c added as literature-informed exploratory candidates | MiR34 SMA mouse/mechanistic study 2023 | Moderate for mechanism, weak for human biomarker | Need cite exact mechanism and avoid human biomarker overclaim |
| NfL as reference biomarker | CSF NfL complementary reference biomarker | Darras 2019; Andres-Benito 2024; NfL dynamics 2026 | Strong for NfL relevance, variable for this cohort | Need discuss stage/timing differences |
| Plasma/CSF non-interchangeability | biofluids are complementary | circulating biomarker reviews and CSF-specific studies | Moderate | Need propose biological model |
| Multi-miRNA panels | panels may improve ROC discrimination | breast cancer panel DOI 10.1038/s41416-021-01593-6; multi-omics biomarker literature | Weak as SMA evidence | Need avoid claiming external validation |
| Peripheral/systemic SMA pathology | plasma may capture peripheral disease aspects | SMA biomarker reviews and systemic component literature | Needs verification | Replace `Ref.` with specific sources |

## 8. Claim-to-evidence 檢查

| Claim | Current evidence in manuscript | Evidence class | Support strength | Recommendation |
|---|---|---|---|---|
| hsa-miR-628-3p is leading plasma prognostic candidate | LP plasma ROC AUC 0.800 +/- 0.10, p = 0.0201 for ΔMFM32 >= 5.2 | RT-qPCR + selected ROC | Moderate/weak due to same-dataset selection | Say `strongest exploratory candidate in this dataset`; do not say validated |
| hsa-let-7b-3p is plasma monitoring candidate | MP increase, ROC AUC 0.950 +/- 0.07, p = 0.0275 for ΔRULM L >= 5 | RT-qPCR + selected ROC | Moderate/weak | Add group counts, CI, correction status; avoid clinical utility claim |
| hsa-miR-675-5p has limited prognostic association | LP negative correlation with RULM L; ROC AUC 0.6455 +/- 0.13 not significant | correlation + ROC | Weak/moderate | Keep as exploratory secondary finding |
| hsa-miR-10a-3p should not advance | mixed LP/pooled/MP directions; author comment suggests unresolved ROC issue | internal analysis | Needs decision | Either predefine exclusion rule or include LP ROC as sensitivity analysis |
| CSF hsa-miR-142-5p is candidate monitoring marker | phase decrease, MP negative ΔHFMSE correlation, ROC AUC 0.7846 +/- 0.12, p = 0.0218 | CSF RT-qPCR + selected ROC | Moderate/weak | Good candidate, but report exact N, missingness, multiple test status |
| miR-34a/c have biomarker relevance | phase changes; ROC non-significant; `Ref.` placeholder | internal + missing citation | Weak | Present as literature-informed exploratory add-on |
| NfL is complementary reference biomarker | no LP/MP change; ROC AUC 0.7917 +/- 0.11, p = 0.0492 for ΔRULM R >= 5 | collaborator data + selected ROC | Weak/moderate | Do not overinterpret nominal p = 0.0492 after many thresholds |
| Multi-miRNA panels may improve performance | AUCs sometimes high but often do not outperform best single miRNA | unweighted composite ROC | Weak | Use as exploratory model-generation only |

## 9. 主要寫作問題

### 9.1 缺完整 manuscript architecture

目前應重組為：

1. Title page
2. Structured abstract
3. Introduction
4. Methods
5. Results
6. Discussion
7. Limitations
8. Conclusion
9. References
10. Figure legends
11. Supplementary tables/figures

### 9.2 Results 過度線性堆疊

現在每個 miRNA 都被詳細敘述，讀者會迷失。建議用「主線 + supplementary」：

- Main Figure 1：study design / cohort / sample availability
- Main Figure 2：discovery-to-validation candidate selection
- Main Figure 3：primary plasma prognostic candidate
- Main Figure 4：primary plasma monitoring candidate
- Main Figure 5：CSF exploratory extension
- Main Figure 6 或 supplement：NfL and miR-34 exploratory analyses
- Supplement：all ROC matrix, all rejected candidates, all non-significant correlations

### 9.3 Prognostic vs monitoring definitions need discipline

建議明確定義：

- **Prognostic biomarker:** measured before or during LP to predict later motor improvement.
- **Monitoring biomarker:** longitudinal phase-associated change that tracks treatment course and/or response.
- **Reference biomarker:** comparator marker such as NfL, not central miRNA discovery target.

### 9.4 Good/poor wording is risky

原稿說 P group 是 smaller motor improvement, not deterioration。建議全稿改：

- `greater improvement group`
- `lesser improvement group`
- 避免 `poor prognosis`，除非有長期 clinical prognosis data。

### 9.5 Statistical claims should be rewritten

避免：

- `demonstrated strong performance`
- `predict`
- `distinguish patients` without caveat
- `biomarker utility`

改為：

- `showed exploratory discriminative signal`
- `was associated with`
- `was selected as a candidate for independent validation`
- `hypothesis-generating`

## 10. 研究缺口

1. **Independent validation gap.** 需要獨立 cohort 或至少 internal validation / bootstrap optimism correction。
2. **Pre-specified clinical endpoint gap.** 需要事先定義 primary motor outcome 與 clinically meaningful threshold。
3. **Mechanistic interpretation gap.** miR-142、miR-628、let-7b、miR-675、miR-34 與 SMA pathophysiology 的 biological plausibility 需補。
4. **Biofluid compartment gap.** plasma/CSF 不一致時，需提出可檢驗模型，而不是只說 complementary。
5. **Assay reproducibility gap.** 需補 spike-in、hemolysis、Ct detection threshold、technical replicate、inter-run CV、primer availability。
6. **Clinical implementation gap.** 什麼時間點抽血/CSF？結果會改變何種 clinical decision？這些仍未定義。
7. **Multiple testing gap.** 需處理或明確標示所有 p-values exploratory。
8. **Reporting transparency gap.** 每個分析的 N、missingness、excluded samples、group count、cut-off selection rule 需可追蹤。

## 11. 建議補充項目

### 必補方法與表格

| Item | Why | 建議位置 |
|---|---|---|
| Cohort table | age, SMA type, SMN2 copy, treatment duration, baseline motor scores | Table 1 |
| Sample availability matrix | plasma/CSF, LP/MP, NGS/qPCR/NfL, paired/unpaired | Table 2 / supplement |
| Candidate attrition table | NGS candidates -> primer unavailable -> undetected -> qPCR validated | Figure 2 / Table S1 |
| Statistical analysis plan | correlation, ROC, threshold selection, p-value correction, CI | Methods |
| ROC summary table | marker, phase, outcome, threshold, N per group, AUC, CI, p | Table S2 |
| Ct/QC table | Ct cutoffs, undetected rate, hemolysis/QC metrics | Methods / supplement |
| Literature comparison table | overlap with prior plasma/CSF miRNA SMA studies | Discussion |

### 建議新增段落

1. **Introduction paragraph 1:** SMA therapy era and response heterogeneity.
2. **Introduction paragraph 2:** current biomarkers, NfL, creatinine/proteomic/RNA biomarkers, limitations.
3. **Introduction paragraph 3:** rationale for circulating miRNAs and plasma/CSF comparison.
4. **Methods:** study population, ethics, consent, sample processing, sequencing, qPCR, motor scales, statistical methods.
5. **Discussion:** primary finding first; secondary findings; comparison with prior studies; biofluid interpretation; limitations; future validation.

## 12. 後續精讀清單

### Tier 1: must read before rewriting Introduction/Discussion

1. Doi et al. 2022, plasma microRNAs response to nusinersen, DOI 10.1002/acn3.51579.
2. Muscle microRNAs in CSF predict clinical response to nusinersen, DOI 10.1111/ene.15382.
3. Assessment of CSF biomarkers and miRNA-mediated mechanisms in SMA, DOI 10.1093/hmg/ddab365.
4. Barbo et al. 2024, MicroRNAs as Biomarkers in SMA, DOI 10.3390/biomedicines12112428.
5. Role of circulating biomarkers in SMA, DOI 10.3389/fneur.2023.1226969.
6. Darras et al. 2019, Neurofilament as potential biomarker for SMA, DOI 10.1002/acn3.779.

### Tier 2: useful for strengthening novelty and limitations

1. MyomiR Networks in SMA, DOI 10.1007/s12035-026-05862-4.
2. RNA biomarkers in SMA, DOI 10.1007/s00018-026-06164-7.
3. Longitudinal multi-omics profiling of SMA, DOI 10.1016/j.neurot.2026.e00880.
4. Extracellular vesicles as biomarkers in SMA, DOI 10.1016/j.omta.2026.201757.
5. MiR34 contributes to SMA, DOI 10.1016/j.omtn.2023.03.005.

### Tier 3: methodological analogy only

1. Development and validation of circulating microRNA panel for early detection of breast cancer, DOI 10.1038/s41416-021-01593-6. Use only to justify the general concept of multi-miRNA panels; do not use as SMA-specific support.

## 13. Concrete revision roadmap

### P1: before any submission

1. Remove all Word comments, placeholders, blank pages, and unresolved notes.
2. Write a complete title/abstract/introduction/methods/discussion/reference list.
3. Define primary endpoint and primary biomarker analysis.
4. Reclassify all ROC matrix outputs as exploratory.
5. Add exact N and group counts for every analysis.
6. Add multiple-testing statement and avoid confirmatory p-value language.
7. Replace `Ref.` with real citations.
8. Create cohort/sample availability tables.

### P2: strengthen scientific argument

1. Add literature comparison with prior SMA plasma/CSF miRNA studies.
2. Explain biological plausibility for top candidates.
3. Separate plasma prognostic, plasma monitoring, CSF exploratory, NfL reference analyses.
4. Move low-priority non-significant markers to supplementary material.
5. Add sensitivity analysis for miR-10a LP-only ROC or explicitly justify exclusion.

### P3: polish

1. Unify terminology and abbreviations.
2. Shorten figure legends.
3. Put figures and legends in a readable order.
4. Fix grammar, punctuation, and p-value formatting.

## 14. Suggested rewritten framing

### Possible title

`Exploratory plasma and cerebrospinal fluid microRNA profiling identifies candidate biomarkers of nusinersen-associated motor response in spinal muscular atrophy`

### Possible abstract conclusion

`In this exploratory cohort, selected plasma and CSF miRNAs showed phase-specific associations with motor improvement after nusinersen treatment. hsa-miR-628-3p and hsa-let-7b-3p showed the strongest plasma signals, while CSF hsa-miR-142-5p showed exploratory monitoring potential. Because ROC thresholds were selected within the same dataset and the cohort was small, these candidates should be considered hypothesis-generating and require independent validation.`

## 15. 可丟入 ChatGPT 的深度分析 Prompt

我已上傳一份由 ARS/Codex 產生的研究 report。請你先完整閱讀整份 report，再以非常深入、審慎、可追溯的方式分析。請不要急著總結；先建立你對 report 結構的理解，再逐步回答。

請完成以下任務：
1. 用分層方式摘要 report：研究問題、搜尋策略、資料來源、納入/排除邏輯、文獻矩陣、主要發現、反證或不一致處、研究缺口。
2. 對每個重要 claim 做證據檢查：指出它依賴哪些文獻、metadata、DOI、摘要、全文或 AI 推論；標示支持強度為 strong / moderate / weak / needs verification。
3. 嚴格區分四類內容：report 已驗證的事實、合理但尚未完全驗證的推論、需要再次查證的問題、目前沒有足夠證據支持的說法。
4. 檢查 report 是否有過度推論、引用不足、文獻選擇偏差、時間線錯置、方法學漏洞、或把相關性寫成因果性的風險。
5. 如果我要把這份 report 變成論文、研究計畫、grant proposal、簡報或投稿前草稿，請提出具體結構與修改路線。
6. 給我一份優先級排序的後續行動清單：哪些文獻要精讀、哪些 citation 要核對、哪些圖表/表格值得補、哪些分析或實驗能最大幅度提高可信度。
7. 最後請用繁體中文輸出：A) 一頁高密度 executive summary；B) 詳細分析；C) claim-to-evidence 表；D) 風險與限制；E) 下一步建議。

重要規則：不要編造 report 沒有提供的來源或 DOI；若你需要外部知識，請明確標示那是待查證推測。請保持謹慎，寧可指出不確定，也不要給過度確定的結論。

## 16. Source links

- PubMed search S1: <https://pubmed.ncbi.nlm.nih.gov/?term=%28spinal+muscular+atrophy%29+AND+%28microRNA+OR+miRNA%29+AND+%28nusinersen+OR+biomarker+OR+circulating+OR+plasma+OR+CSF%29>
- PubMed search S2: <https://pubmed.ncbi.nlm.nih.gov/?term=%28spinal+muscular+atrophy%29+AND+%28nusinersen%29+AND+%28neurofilament+OR+NfL+OR+biomarker%29>
- Doi et al. 2022 plasma microRNAs: <https://pubmed.ncbi.nlm.nih.gov/35584175/>
- CSF muscle microRNAs / nusinersen response: <https://pubmed.ncbi.nlm.nih.gov/35510740/>
- CSF biomarkers and miRNA-mediated mechanisms: <https://pubmed.ncbi.nlm.nih.gov/34919695/>
- Novel CSF-derived miRNAs in treated pediatric-onset SMA: <https://pubmed.ncbi.nlm.nih.gov/36678797/>
- MicroRNAs as Biomarkers in SMA review: <https://pubmed.ncbi.nlm.nih.gov/39594995/>
- Circulating biomarkers in SMA review: <https://pubmed.ncbi.nlm.nih.gov/38020652/>
- Neurofilament as biomarker for SMA: <https://pubmed.ncbi.nlm.nih.gov/31139691/>
- Neurodegeneration biomarkers in adult SMA: <https://pubmed.ncbi.nlm.nih.gov/38612621/>
- miR34 contributes to SMA: <https://pubmed.ncbi.nlm.nih.gov/37064776/>
- Breast cancer circulating miRNA panel analogy: <https://doi.org/10.1038/s41416-021-01593-6>

