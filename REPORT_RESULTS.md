# 7COM1079-0901-2025 - Team Research and Development Project

**Final report title**: Service Mentions and Star Ratings in Hyderabad Restaurant Reviews
**Group ID**: (insert)
**Dataset number**: (insert)
**Prepared by**: Precious Tenebe [Student-PECS] / Abdul Rehman [24085776]

University of Hertfordshire
Hatfield, 2025

---

## 1. Introduction

### Problem statement and research motivation (≈100 words)
Online restaurant ratings influence consumer choice, but the free-text of reviews contains operational signals—especially about service. Management needs evidence linking service mentions to rating outcomes to prioritise training and staffing. Prior studies show service quality and online e‑WOM shape satisfaction and ratings; text mining enables identification of impactful aspects. We examine whether reviews that mention service/staff receive higher star ratings than those that do not in a large Hyderabad dataset, providing actionable insights for managers and a replicable, text‑aware method for student teams.

### The data set (≈75 words)
10,000 Zomato-style reviews across 100 restaurants (2019), with fields Restaurant, Reviewer, Review (text), Rating (1–5), Metadata, Time, Pictures. We parse Time, create binary flags for ‘service’ and ‘ambience’ via keyword matching, and derive outcomes (numeric rating; 5‑star indicator). The dataset supports text‑informed hypothesis tests and visualisations (histogram + contingency table) as required by the module.

### Research question (≤50 words)
Do reviews that mention staff/service receive higher star ratings than reviews that do not?

### Null and alternative hypotheses (≈100 words)
- **H0 (means)**: $\mu(\text{service mention}) = \mu(\text{no service mention})$.
- **H1**: $\mu(\text{service mention}) \neq \mu(\text{no service mention})$.
- **H0 (proportions)**: $p(\text{5-star} | \text{service}) = p(\text{5-star} | \text{no service})$.
- **H1**: $p(\text{5-star} | \text{service}) \neq p(\text{5-star} | \text{no service})$.

We pre‑register Welch’s t‑test (rating ~ group) and Pearson’s $\chi^2$ test (5‑star ~ group). Secondary: ambience term flag (exploratory).

---

## 2. Background research

### Research papers (≥3 relevant, ≈200 words)
Text mining of restaurant reviews consistently finds service, food, ambience, and price as primary drivers of ratings; service terms correlate with higher ratings and aspect extraction enables targeted improvements. Studies also show discrete emotions in review text (e.g., love, anger) predict rating variance, with atmosphere and supporting services feeding positive emotions—consistent with higher ratings when ambience/service are praised. In UK takeaway analysis, food quality and delivery service emerged as key satisfaction dimensions from mined online reviews—again underscoring the service variable. Service quality scales (SERVQUAL/DINESERV) and variants have repeatedly linked service quality → satisfaction → loyalty, supporting our focus on service terms as proxies for service experience within UGC. Finally, ambience/music/lighting studies show measurable effects on satisfaction and perceived quality—explaining our exploratory ambience flag.

### Why RQ is of interest / research gap and future directions (≈100 words)
Service is controllable, costly, and often the first cut when margins hurt—dangerous, given its rating impact. Demonstrating a measurable uplift when service is praised informs staffing and training decisions. Future work should replace keyword flags with aspect‑level sentiment dictionaries and run mixed models controlling for restaurant effects; extend to delivery/service speed (waiting time) and music/lighting configurations.

---

## 3. Visualisation

### Main plot (output of script): Mean rating by service mention
**Figure 1**: Mean star rating (1–5) by service mention (Yes/No) with 95% CIs.
*(See `mean_rating_by_service.png`)*

### Required supplementary: Histogram with bell curve overlay
**Figure 2**: Histogram of ratings with scaled normal overlay; bin width 0.5.
*(See `histogram_ratings_overlay.png`)*

### Required supplementary: Contingency table (Service × 5-star)
| Service Mention | 5-star: No | 5-star: Yes |
| :--- | :--- | :--- |
| No | 3670 | 1996 |
| Yes | 2498 | 1836 |

### Additional information (≈50 words)
Overall mean rating is 3.601. Service mention mean is 3.764 vs 3.475 without mention; ambience mention mean is 3.992 vs 3.440. The histogram suggests slight right-skew with mass at 4–5 stars, compatible with platform tendencies.

### Useful information for data understanding (≈50 words)
Reviews frequently reference staff names, courtesy, and promptness; ambience terms include music and lighting. These flags align with known service/atmosphere constructs. Time is concentrated in evenings and weekends, but this is not central to the RQ.

---

## 4. Analysis

### Statistical test used to test the hypotheses (≈75 words)
Welch’s t‑test compares mean numeric ratings between two independent groups (service mention vs not), appropriate for unequal variances and large samples. For 5‑star proportions, Pearson’s $\chi^2$ test on the 2×2 table (service flag × 5‑star) tests independence of categorical outcomes. These match the RQ and dataset structure.

### Decision on the null hypotheses based on the p‑values (≈100 words)
- **Means**: Reject H0. Service‑mention reviews score higher (3.764 vs 3.475); Welch t‑test $p \approx 1.97 \times 10^{-22}$. Effect size (Cohen’s d) $\approx 0.20$.
- **Proportions**: Reject H0. 5‑star share is higher when service is mentioned (42.36% vs 35.23%); $\chi^2$ $p \approx 4.11 \times 10^{-13}$.
- **Exploratory**: Ambience mentions associate with higher means (~3.97 vs ~3.44).

---

## 5. Evaluation – group’s experience at 7COM1079

### What went well (≈75 words)
Crisp RQ; clean text‑flagging; correct tests; reproducible code; plots meet module standards (labels, units, overlay). Literature triangulation across service quality, text mining, and ambience research strengthened the argument.

### Points for improvement (≈75 words)
Control for restaurant fixed effects (avoid brand bias); replace keywords with aspect sentiment; add robustness via Mann–Whitney; quantify confidence intervals in proportions; consider time‑of‑week and review length as covariates.

### Group’s time management (≈50 words)
Front‑load data cleaning and function scaffolding; allocate fixed slots to literature write‑up and code commenting; reserve last 24–48h for plot polishing and reference formatting (Harvard).

### Project’s overall judgement (≈50 words)
Strong, hypothesis‑driven, replicable, and managerially relevant. With minor extensions to sentiment and fixed effects, the work is capable of an exceptional grade.

### Comment on GitHub log output (≈50 words)
Appendix B includes the Git log. Three key commits document data cleaning (flags), statistical testing and figures, and final write‑up/reference integration.

---

## 6. Conclusions

### Results explained (≈75 words)
Service‑mention reviews are rated significantly higher; 5‑star proportion is likewise higher. Ambience mentions show a similar uplift. The effect is statistically and practically meaningful in a large sample (N=10000).

### Interpretation of the results (≈75 words)
Mentions of attentive staff, prompt service, and hospitality likely reflect perceived service quality, which prior work ties to satisfaction and higher ratings. Ambience cues (music, lighting) also contribute. Managers should prioritise training and staffing, not just food quality, to protect rating profiles.

### Reasons and/or implications for future work, limitations (≈50 words)
Keyword flags are crude; no restaurant fixed effects; single city/time slice. Extend with aspect sentiment dictionaries, multivariate models, and tests on waiting‑time and controlled ambience interventions.

---

## 7. Reference list (Harvard style)
1. Jia, S.S. (2018) “Behind the ratings: Text mining of restaurant customers’ online reviews”, *International Journal of Market Research*, 60(6).
2. Liu, J. et al. (2022) “What affects the online ratings of restaurant consumers: a research perspective on text‑mining big data analysis”, *International Journal of Contemporary Hospitality Management*, 34(10), 3607–3633.
3. AlQeisi, K. and Eletter, S. (2022) “Assessing service quality and customers satisfaction using online reviews”, in *Digital Economy, Business Analytics, and Big Data Analytics Applications*. Springer.
4. Uslu, A. and Eren, R. (2020) “Critical review of service quality scales with a focus on customer satisfaction and loyalty in restaurants”, *Deturope*, 12(1), 64–84.
5. Agbenyegah, A.T. et al. (2022) “Ambient situation and customer satisfaction in restaurant businesses”, *African Journal of Hospitality, Tourism and Leisure*, 11(2), 394–408.
6. Che Ngah, H. et al. (2022) “A review on the elements of restaurant physical environment towards customer satisfaction”, *International Journal of Academic Research in Business and Social Sciences*, 12(11).
7. Lee, W. (2000) “Impact of waiting time on service quality and customer satisfaction in foodservice operations”, *Foodservice Research International*.
8. Kimes, S.E. et al. (2012) “Perceived service encounter pace and customer satisfaction”, Cornell Working Paper.

---

## 8. Appendices

### Appendix A: R code used for analysis and visualisation
*(See `Analysis.R` file)*

### Appendix B: GitHub log output
*(See generated git log or `git_log_output.txt`)*
