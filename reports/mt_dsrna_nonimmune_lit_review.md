# mt-dsRNA 除了免疫發炎以外的功能？文獻流程化報告

生成日期：2026-06-22  
模式：academic-research-suite / deep-research / lit-review  
資料擷取限制：優先使用 CloakBrowser Research；只擷取頁面可見文字、metadata、摘要、DOI、期刊資訊；未下載 PDF、Word、RIS、BibTeX 或 citation files。

## 0. 快速結論

目前文獻對 mt-dsRNA 的「非免疫發炎功能」支持度並不平均。最強證據不是顯示 mt-dsRNA 本身像 miRNA/lncRNA 一樣有明確調控功能，而是顯示 mt-dsRNA 是線粒體 bidirectional transcription、antisense RNA、RNA secondary structure 與 RNA decay/processing 系統交會後產生的內源性 RNA 物種；細胞需要 SUV3/SUPV3L1、PNPT1/PNPase、GRSF1、NSUN4、C1QBP、MTPAP 等因子控制它的生成、穩定性、降解與輸出。

較可信的非免疫功能軸如下：

1. **mtRNA quality control / surveillance**：SUV3-PNPase degradosome 可降解 structured RNA/dsRNA，限制不必要或錯誤折疊 RNA，維持 mitochondrial transcriptome integrity。
2. **antisense RNA removal and transcriptome shaping**：大量 light-strand/antisense mtRNA 通常被快速移除；若監控失衡，sense/antisense 形成 dsRNA，影響 mtRNA homeostasis。
3. **mt-mRNA processing, stability, polyadenylation, and energy response**：SUV3-PNPase-mtPAP 軸可調控 mt-mRNA poly(A) tail length，並與 mitochondrial matrix Pi / ATP 狀態連動。
4. **cellular stress / translation arrest**：PNPT1 下降導致 mt-dsRNA 外漏後可經 PKR-eIF2alpha 造成 protein synthesis arrest 與組織損傷；這包含免疫以外的 translational stress 生理後果。
5. **organelle-to-cytosol RNA trafficking / DAMP biology**：2024 研究開始定義 mt-dsRNA 輸出路徑，涉及 PNPase、VDAC1/2、BAK/BAX、PHB1/2 與 TIA-1 granules。這仍與 innate immune signaling 相連，但「輸出通道與 RNA trafficking」本身是可獨立追問的細胞生物學問題。
6. **aging/neurodegeneration 候選方向**：2026 bioRxiv 預印本把 brain aging / AD 中 mt-dsRNA accumulation 與 mtRNA processing/translation machinery 下降連結，但仍需 peer review 與機制驗證。

## 1. 搜尋策略

### 研究問題

mt-dsRNA 除了作為 MDA5/RIG-I/PKR 等 innate immune / inflammatory ligand 之外，是否具有其他功能或生物學角色？

### PICO/PECO 式範圍

| 元件 | 定義 |
|---|---|
| Entity | mitochondrial double-stranded RNA, mt-dsRNA, mtdsRNA, mitochondrial antisense RNA |
| Context | human cells, mammalian mitochondria, Drosophila in vivo models, disease/aging contexts |
| Mechanism | RNA turnover, degradosome, transcript processing, polyadenylation, RNA modification, RNA trafficking |
| Excluded focus | 純免疫發炎路徑研究，除非其摘要同時提供非免疫機制資訊 |

### 核心搜尋式

1. `(mitochondrial dsRNA OR mt-dsRNA OR mitochondrial double-stranded RNA)`
2. `(mitochondrial double-stranded RNA OR mtdsRNA OR mt-dsRNA) (PNPase OR PNPT1 OR SUV3 OR RNA decay OR turnover OR processing OR gene expression OR translation)`
3. `(PNPT1 OR PNPase OR SUV3) mitochondrial RNA (antisense OR double-stranded OR dsRNA)`
4. `"mitochondrial antisense" "GRSF1"`
5. `"Defects of mitochondrial RNA turnover" "double-stranded RNA"`
6. `"mt-dsRNA" aging Alzheimer brain`

### 納入標準

- 明確提到 mitochondrial dsRNA、mtdsRNA、mitochondrial antisense RNA，或直接研究 SUV3/PNPase/PNPT1/GRSF1/MTPAP/NSUN4/C1QBP 對 mitochondrial RNA turnover 的影響。
- 提供非免疫機制線索：RNA surveillance、mRNA stability、polyadenylation、translation arrest、organelle RNA trafficking、disease physiology。
- 優先 peer-reviewed primary research；review 只作框架與追文獻用；preprint 標記為低確定性。

### 排除標準

- 只討論 viral dsRNA sensing 而未連到 mitochondrial RNA。
- 只討論 mtDNA release、mitochondrial DNA editing，且不涉及 mtRNA/dsRNA。
- 只提供 PDF 或 citation file 而沒有可見 metadata/摘要者。

## 2. 搜尋紀錄

| 時間 | 平台/頁面 | 查詢或動作 | 可見結果/紀錄 | 處理 |
|---|---|---|---|---|
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | `(mitochondrial dsRNA OR mt-dsRNA OR mitochondrial double-stranded RNA)` | PubMed 顯示 947 results；前列包含 Dhir 2018, Kim 2024, Krieger 2024, Sadeq 2021 review, López-Polo 2024 | 保留核心結果，排除明顯非 mtRNA/dsRNA 文章 |
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | `(mitochondrial double-stranded RNA OR mtdsRNA OR mt-dsRNA) (PNPase OR PNPT1 OR SUV3 OR RNA decay OR turnover OR processing OR gene expression OR translation)` | 412 results；前列含 Dhir 2018, Zhu 2023, Kim 2024 | 用於找 PNPT1/SUV3/processing 相關文獻 |
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | `(PNPT1 OR PNPase OR SUV3) mitochondrial RNA (antisense OR double-stranded OR dsRNA)` | 32 results；前列含 Dhir 2018, Zhu 2023, Chen 2023 review, Krieger 2024, Pennisi 2022, Wang 2009, Pietras 2018, Santonoceto 2024 | 作為候選文獻主池 |
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | `PMID:29967381` | 觸發 reCAPTCHA/access check | 臨時截圖記錄；改用 PubMed 搜尋結果與 DOAJ/其他公開 metadata；截圖最後刪除 |
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | `PMID:38955468` | 觸發 reCAPTCHA/access check | 臨時截圖記錄；改用 Life Science Alliance article-info/full article 可見文字；截圖最後刪除 |
| 2026-06-22 18:xx CST | PubMed via CloakBrowser | Kim et al. 2024 單篇頁 | 成功取得 PubMed metadata、摘要、DOI、PMCID、COI | 納入候選表與矩陣 |
| 2026-06-22 18:xx CST | PLOS Genetics via CloakBrowser | Pajak et al. 2019 HTML article | 取得 title、authors、DOI、abstract、author summary、method overview | 納入核心 primary research |
| 2026-06-22 18:xx CST | JBC via CloakBrowser | Wang et al. 2009 HTML article | 取得 title、DOI、abstract；頁面有下載按鈕文字但未點擊 | 納入 biochemical mechanism |
| 2026-06-22 18:xx CST | JBC via CloakBrowser | Wang et al. 2014 HTML article | 取得 title、DOI、abstract；頁面有下載按鈕文字但未點擊 | 納入 poly(A)/energy response theme |
| 2026-06-22 18:xx CST | Life Science Alliance via CloakBrowser | Krieger et al. 2024 article-info/full article | 取得 title、authors、DOI、PubMed ID、abstract、article info | 納入 trafficking theme |
| 2026-06-22 19:xx CST | bioRxiv via CloakBrowser | Doser & LaRocca 2026 HTML full text | 取得 title、DOI、preprint status、abstract、methods summary | 標記為 preprint，只列候選與精讀 |

## 3. 候選文獻表

| # | 文獻 | 類型/期刊 | DOI / PMID | 與「非免疫功能」的關係 | 納入判斷 |
|---|---|---|---|---|---|
| 1 | Wang et al. (2009), *Human mitochondrial SUV3 and PNPase form a 330-kDa heteropentamer...* | Primary, JBC | [10.1074/jbc.M109.009605](https://www.jbc.org/article/S0021-9258(17)48405-5/fulltext); PMID [19509288](https://pubmed.ncbi.nlm.nih.gov/19509288/) | 體外證明 SUV3-PNPase 複合體可 ATP-dependent 降解 dsRNA，支持 mt-dsRNA 作為 RNA surveillance substrate | 核心 |
| 2 | Szczesny et al. (2010), *Human mitochondrial RNA turnover caught in flagranti...* | Primary, NAR | [10.1093/nar/gkp903](https://pubmed.ncbi.nlm.nih.gov/19864255/); PMID 19864255 | hSuv3p 參與成熟 mRNA stability 與 noncoding processing intermediate removal | 核心背景 |
| 3 | Borowski et al. (2013), *Human mitochondrial RNA decay mediated by PNPase-hSuv3 complex takes place in distinct foci* | Primary, NAR | [10.1093/nar/gks1130](https://pubmed.ncbi.nlm.nih.gov/23221631/); PMID 23221631 | PNPase-SUV3 RNA decay foci，支持 degradosome 是 mtRNA turnover 的組織化機制 | 核心背景 |
| 4 | Wang et al. (2014), *Helicase SUV3, PNPase, and mtPAP form a transient complex...* | Primary, JBC | [10.1074/jbc.M113.536540](https://www.jbc.org/article/S0021-9258(20)40646-5/fulltext); PMID [24770417](https://pubmed.ncbi.nlm.nih.gov/24770417/) | SUV3-PNPase-mtPAP 調控 mt-mRNA poly(A) tails，與 energetic changes 連動 | 核心 |
| 5 | Clemente et al. (2015), *SUV3 helicase is required for correct processing of mitochondrial transcripts* | Primary, NAR | [10.1093/nar/gkv692](https://pubmed.ncbi.nlm.nih.gov/26152302/); PMID 26152302 | SUV3 缺失造成 transcript processing defects、reduced mitochondrial translation、respiratory chain deficiency | 核心 |
| 6 | Dhir et al. (2018), *Mitochondrial double-stranded RNA triggers antiviral signalling in humans* | Primary, Nature | [10.1038/s41586-018-0363-0](https://pubmed.ncbi.nlm.nih.gov/30046113/); PMID 30046113 | 免疫主線文章，但同時確認 native mt-dsRNA、SUV3/PNPase 限制 mt-dsRNA、PNPase-dependent cytosolic escape | 背景核心 |
| 7 | Pietras et al. (2018), *Dedicated surveillance mechanism controls G-quadruplex forming non-coding RNAs in human mitochondria* | Primary, Nat Commun | [10.1038/s41467-018-05007-9](https://pubmed.ncbi.nlm.nih.gov/29967381/); PMID 29967381 | G4-forming noncoding antisense mtRNAs 由 SUV3-PNPase-GRSF1 監控；直接連到 antisense removal | 核心 |
| 8 | Pietras et al. (2018), *Controlling the mitochondrial antisense...* | Commentary, Mol Cell Oncol | [10.1080/23723556.2018.1516452](https://pubmed.ncbi.nlm.nih.gov/30525095/); PMID 30525095 | 摘要與圖說清楚指出 L-strand transcription 產生大量 antisense RNAs，由 SUV3-PNPase + GRSF1 移除並塑造 transcriptome | 輔助 |
| 9 | Pajak et al. (2019), *Defects of mitochondrial RNA turnover lead to the accumulation of double-stranded RNA in vivo* | Primary, PLOS Genetics | [10.1371/journal.pgen.1008240](https://journals.plos.org/plosgenetics/article?id=10.1371%2Fjournal.pgen.1008240); PMID [31365523](https://pubmed.ncbi.nlm.nih.gov/31365523/) | Drosophila in vivo 顯示 mRNA stability、polyadenylation、antisense removal 互相依賴；失衡導致 dsRNA accumulation | 核心 |
| 10 | Pennisi et al. (2022), *Heterogeneity of PNPT1 neuroimaging...* | Clinical/Genetics, J Med Genet | [10.1136/jmedgenet-2020-107367](https://pubmed.ncbi.nlm.nih.gov/33199448/); PMID 33199448 | PNPT1 variants 牽涉 mitochondriopathy 與 interferonopathy；可作 disease phenotype bridge | 候選 |
| 11 | Zhu et al. (2023), *PNPase protects against renal tubular injury via blocking mt-dsRNA-PKR-eIF2alpha axis* | Primary, Nat Commun | [10.1038/s41467-023-36664-0](https://pubmed.ncbi.nlm.nih.gov/36869030/); PMID 36869030 | PNPT1 下降造成 translation arrest / tubular atrophy；雖有 PKR stress signaling，但 phenotype 不只是發炎 | 核心 |
| 12 | Chen (2023), *SUV3 Helicase and Mitochondrial Homeostasis* | Review, IJMS | [10.3390/ijms24119233](https://www.mdpi.com/1422-0067/24/11/9233); PMID 37298184 | 匯整 SUV3 對 mitochondrial homeostasis、aging、cancer 的影響 | 輔助 review |
| 13 | Santonoceto et al. (2024), *RNA degradation in human mitochondria: the journey is not finished* | Review, HMG | [10.1093/hmg/ddae043](https://pubmed.ncbi.nlm.nih.gov/38779774/); PMID 38779774 | 最新 review，整理 human mitochondrial RNA degradation 與未解問題 | 輔助 review |
| 14 | Krieger et al. (2024), *Trafficking of mitochondrial double-stranded RNA from mitochondria to the cytosol* | Primary, Life Science Alliance | [10.26508/lsa.202302396](https://www.life-science-alliance.org/content/7/9/e202302396); PMID 38955468 | 定義 mt-dsRNA export 候選通道與 cytosolic granule localization；非免疫的 trafficking 機制很重要 | 核心 |
| 15 | Kim et al. (2024), *RNA 5-methylcytosine marks mitochondrial double-stranded RNAs for degradation and cytosolic release* | Primary, Molecular Cell | [10.1016/j.molcel.2024.06.023](https://pubmed.ncbi.nlm.nih.gov/39019044/); PMID 39019044 | NSUN4 m5C, C1QBP, PNPT1 建立 light-strand mtRNA selective degradation mark | 核心 |
| 16 | Doser & LaRocca (2026), *Mitochondrial double-stranded RNA accumulation in brain aging and Alzheimer’s disease* | Preprint, bioRxiv | [10.64898/2026.02.02.703345](https://www.biorxiv.org/content/10.64898/2026.02.02.703345v1.full-text) | human brain RNA-seq 分析；mt-dsRNA signatures 與 aging/AD、mtRNA processing machinery 下降相關 | 精讀候選，低確定性 |
| 17 | *Asymmetric dimeric assembly of Suv3 helicase facilitates processive RNA unwinding* (2026) | Primary, Nat Commun | [Nature page](https://www.nature.com/articles/s41467-026-71901-2) | 近期結構機制；幫助理解 SUV3 如何支援 RNA unwinding/surveillance，但不直接證明 mt-dsRNA 生理功能 | 機制候選 |

## 4. 文獻矩陣

| 文獻 | RNA surveillance / decay | Antisense/G4 control | mt-mRNA processing/poly(A) | Cytosolic export / trafficking | Disease / physiology | 證據強度 |
|---|---|---|---|---|---|---|
| Wang 2009 | 強：SUV3-PNPase 降解 dsRNA | 間接 | 間接 | 無 | 無 | Biochemical primary |
| Szczesny 2010 | 強：hSuv3p RNA surveillance | 中 | 中 | 無 | mitochondrial function | Cellular primary |
| Borowski 2013 | 強：PNPase-hSuv3 decay foci | 中 | 中 | 無 | mitochondrial RNA turnover | Cellular primary |
| Wang 2014 | 中：decay complex | 弱 | 強：poly(A) tail responds to Pi/ATP | 無 | energy status response | Biochemical/cellular primary |
| Clemente 2015 | 中 | 弱 | 強：processing, translation, respiratory chain | 無 | developmental/respiratory phenotype | In vivo/cellular primary |
| Dhir 2018 | 強：SUV3/PNPase restrict mt-dsRNA | 中 | 間接 | 強：PNPase-dependent escape | PNPT1 disease/interferon | Primary, immune-centered |
| Pietras 2018 Nat Commun | 強 | 強：G4-forming noncoding mtRNA | 中 | 無 | transcriptome shaping | Primary |
| Pietras 2018 MCO | 中 | 強：概念整合 | 中 | 無 | transcriptome shaping | Commentary |
| Pajak 2019 | 強 | 強：antisense RNA removal | 強：mRNA stability/polyadenylation | 中：cytoplasmic escape | Drosophila physiology | In vivo primary |
| Pennisi 2022 | 間接 | 弱 | PNPT1 RNA processing | 間接 | PNPT1 neuroimaging phenotype | Clinical genetics |
| Zhu 2023 | PNPT1 blocks mt-dsRNA buildup/leakage | 間接 | translation arrest via PKR-eIF2alpha | 中 | renal tubular atrophy/injury | Primary disease model |
| Chen 2023 review | 強整理 | 中 | 中 | 弱 | aging/cancer/homeostasis | Review |
| Santonoceto 2024 review | 強整理 | 中 | 強整理 | 弱 | disease framing | Review |
| Krieger 2024 | 中 | 弱 | 間接 | 強：VDAC/BAK/BAX/PHB candidates, TIA-1 granules | glycolytic NSCLC subset | Primary |
| Kim 2024 | 強：NSUN4-C1QBP-PNPT1 turnover | 強：light-strand lncRNA | 中 | 中/強：cytosolic release | stress/immune activation | Primary |
| Doser 2026 preprint | 間接 | 弱 | processing/translation machinery correlation | inferred | brain aging/AD correlation | Preprint |

## 5. 主題式綜整

### Theme A：mt-dsRNA 是 mitochondrial RNA decay machinery 的核心底物或副產物

Wang et al. 2009 的體外研究建立 SUV3-PNPase 複合體可降解 dsRNA，且單獨組件不足以完成有效 dsRNA degradation。這使 mt-dsRNA 的最小功能定位不是「訊號分子」而是「必須被解旋與降解的 structured RNA substrate」。後續 Szczesny 2010、Borowski 2013、Pietras 2018、Pajak 2019 把這個概念推向細胞與 in vivo：如果 SUV3/PNPase/MTPAP/GRSF1 軸失衡，antisense mtRNA 與 dsRNA 會累積。

### Theme B：antisense RNA removal 可能是最接近「非免疫功能」的主軸

Pietras et al. 2018 指出 human mitochondrial genome transcription 會產生大量 non-coding antisense RNAs，其中 G4-forming species 需要 SUV3-PNPase 與 GRSF1 限制。這不是以免疫為主的模型，而是 mitochondrial transcriptome shaping：哪些 RNA 被穩定、哪些 antisense/noncoding RNA 被清掉，決定 mitochondrial RNA landscape。

### Theme C：mt-mRNA stability / polyadenylation / energy-state response 與 mt-dsRNA 生成相連

Wang et al. 2014 顯示 SUV3-PNPase-mtPAP 可依 Pi/ATP ratio lengthen 或 shorten mt-mRNA poly(A) tails。Pajak et al. 2019 在 Drosophila in vivo 顯示 mRNA stability、polyadenylation、antisense RNA removal 彼此高度依賴，破壞 degradation 或 polyadenylation 皆可造成 dsRNA accumulation。這支持一個模型：mt-dsRNA 不是孤立功能物，而是 mtRNA maturation/decay 網路失衡的讀出。

### Theme D：非免疫後果包括 translation arrest、組織萎縮與 mitochondrial dysfunction

Zhu et al. 2023 把 PNPT1 reduction 連到 renal tubular translation arrest and atrophy，機制含 mt-dsRNA-PKR-eIF2alpha。PKR 本身常放在 antiviral/stress signaling，但 protein synthesis arrest、Fanconi syndrome-like phenotype、tubular injury 是免疫以外的細胞生理後果。Clemente et al. 2015 也支持 SUV3 對 mitochondrial transcript processing、mitochondrial translation 與 respiratory chain function 重要。

### Theme E：mt-dsRNA export 是獨立值得追的 organelle RNA trafficking 問題

Krieger et al. 2024 把 mt-dsRNA export 從「有外漏」推進到「可能有哪些通道與膜蛋白參與」：PNPase localization、VDAC1/2、BAK/BAX、PHB1/2，以及 cytosolic TIA-1 granules。雖然最終常導向 IFN-1 stress response，但從非免疫角度看，這是 mitochondria-to-cytosol RNA traffic 與 mitochondrial membrane biology 的新問題。

### Theme F：RNA modification 可能是 mt-dsRNA fate decision 的新層次

Kim et al. 2024 以 CRISPR screening 找到 NSUN4，提出 m5C marks mtRNAs，C1QBP 辨識並招募 PNPT1 促進 turnover；C1QBP deficiency 會增加 cytosolic mt-dsRNAs。這把 mt-dsRNA 從「被動 accumulation」推向「可由 RNA modification 標記 fate」的機制層次，是後續研究非免疫功能的高價值切入點。

## 6. 研究缺口

| 缺口 | 類型 | 目前狀態 | 為什麼重要 |
|---|---|---|---|
| mt-dsRNA 是否有正常生理條件下的正向功能 | Conceptual / empirical | 多數研究把 mt-dsRNA 視為需被限制的 byproduct 或 danger signal | 若沒有正向功能，題目應改問「mt-dsRNA 產生與處理的非免疫後果」 |
| mt-dsRNA 與 antisense mtRNA/G4 RNA 的關係 | Mechanistic | Pietras/Kim/Pajak 支持重疊，但 dsRNA、G4、light-strand lncRNA fate 尚未完全分清 | 需要區分 RNA structure classes，避免把所有 antisense accumulation 都等同 mt-dsRNA |
| mitochondrial matrix 內 mt-dsRNA 是否直接影響 translation/processing | Mechanistic | processing/poly(A) 缺陷會伴隨 dsRNA accumulation，但因果方向不清 | 若 mt-dsRNA 本身能阻礙 mitoribosome 或 RNA granule，才是真正非免疫功能 |
| mt-dsRNA export 通道是否專一 | Mechanistic | Krieger 2024 提供 VDAC/BAK/BAX/PHB candidates | 通道特異性可區分 regulated export、membrane damage、stress leakage |
| tissue specificity | Empirical | renal tubule、immune cells、cancer cell lines、brain preprint 分散 | 不同組織 mtRNA turnover 需求與 immune-sensing threshold 可能不同 |
| human disease genotype-to-mechanism | Translational | PNPT1 variants 同時呈 mitochondriopathy/interferonopathy | 需分辨 mitochondrial dysfunction primary vs mt-dsRNA immune/stress secondary |
| aging/AD 證據仍偏 correlation | Methodological | 2026 bioRxiv 用 public RNA-seq / editing footprint | 需要 spatial/cell-type validation 與 perturbation experiment |
| RNA modification beyond m5C | Mechanistic | NSUN4-m5C 是新線索 | 其他 mtRNA modifications 是否決定 dsRNA formation/degradation 尚不清楚 |

## 7. 後續精讀清單

### 第一優先：建立非免疫機制骨架

1. Wang et al. 2009, JBC - SUV3-PNPase dsRNA degradation biochemical foundation.
2. Pietras et al. 2018, Nature Communications - G4-forming noncoding mtRNA / antisense surveillance.
3. Pajak et al. 2019, PLOS Genetics - in vivo RNA turnover, polyadenylation, antisense RNA, dsRNA accumulation.
4. Kim et al. 2024, Molecular Cell - NSUN4-m5C-C1QBP-PNPT1 fate marking.
5. Krieger et al. 2024, Life Science Alliance - mt-dsRNA trafficking/export pathway.

### 第二優先：連到 gene expression / physiology

6. Wang et al. 2014, JBC - mt-mRNA poly(A) tail length and energetic changes.
7. Clemente et al. 2015, NAR - SUV3 and transcript processing / mitochondrial translation.
8. Zhu et al. 2023, Nature Communications - translation arrest and renal tubular injury.
9. Pennisi et al. 2022, J Med Genet - PNPT1 clinical phenotype boundary.

### 第三優先：框架與新方向

10. Santonoceto et al. 2024, HMG review - human mitochondrial RNA degradation open questions.
11. Chen 2023, IJMS review - SUV3 and mitochondrial homeostasis.
12. Doser & LaRocca 2026, bioRxiv preprint - brain aging/AD hypothesis, use as hypothesis generator only.
13. 2026 Nat Commun SUV3 structure paper - structural basis for SUV3 processive RNA unwinding.

## 8. Source verification notes

- Peer-reviewed primary research dominates the core matrix except Doser & LaRocca 2026, which is explicitly marked preprint.
- PubMed direct pages for PMID 29967381 and 38955468 triggered reCAPTCHA/access check in CloakBrowser; metadata was cross-checked from PubMed search snippets plus publisher/DOAJ/Life Science Alliance pages where available.
- No DOI/title mismatch was observed among included core records.
- Reviews were used only to identify mechanisms and references, not as sole support for primary claims.

## 9. Working answer to the topic

如果用一句話回答：「mt-dsRNA 除了免疫發炎之外，最有證據的功能不是獨立訊號功能，而是作為 mitochondrial RNA homeostasis 的受控產物/底物：它反映 antisense RNA removal、structured RNA decay、mt-mRNA polyadenylation/processing、RNA modification 與 mitochondria-to-cytosol trafficking 的狀態；當這些系統失衡時，才延伸出 translation arrest、organ dysfunction、aging/disease association 與 immune inflammation。」

因此後續若要做研究題目，建議把問題從「mt-dsRNA 有什麼非免疫功能？」改成更可驗證的版本：

> Under non-infectious and low-inflammatory conditions, does mitochondrial dsRNA directly regulate mitochondrial RNA processing/translation, or is it primarily a byproduct and stress signal of impaired mitochondrial RNA surveillance?

