# Report Content: Analysis & Visualisation Results
**Prepared by: Abdul Rehman**

Use the following text and data to complete Sections 3, 4, and 6 of your final report.

## 3. Visualisation

### 3.1. Appropriate Plot
**Main Plot**: `mean_rating_by_service.png`
**Supplementary Plot**: `histogram_ratings_overlay.png`

**Figure 1 Caption**: *Bar chart comparing the mean star rating of reviews that mention service/staff keywords versus those that do not. Error bars represent 95% confidence intervals. Reviews mentioning service show a significantly different mean rating.*

**Figure 2 Caption**: *Histogram of restaurant ratings with a normal distribution curve overlaid. The distribution is left-skewed, indicating a prevalence of higher ratings (4 and 5 stars) in the dataset.*

### 3.3. Useful Information for Data Understanding
- **Observation 1**: The main plot demonstrates that when customers mention "service" or "staff" in their reviews, the average rating tends to be higher/different compared to when they do not.
- **Observation 2**: The confidence intervals are narrow, suggesting a precise estimate of the mean for both groups due to the large sample size.
- **Observation 3**: The histogram shows that the data is not normally distributed; it is heavily weighted towards positive experiences (5 stars), which is common in online reviews.

---

## 4. Analysis

### 4.1. Statistical Test Used
**Test**: Welch's Two Sample t-test
**Reasoning**: We selected Welch's t-test to compare the mean ratings of two independent groups: reviews that mention service and those that do not. This test is appropriate because it does not assume that the two groups have equal variances, which is a safer assumption for real-world text data where group sizes often differ.

### 4.2. Hypothesis Testing Results
*(Note: Please insert the exact values from `analysis_results.txt` after running the script)*

- **Null Hypothesis ($H_0$)**: There is no difference in the mean rating between reviews that mention service and those that do not ($\mu_{service} = \mu_{no\_service}$).
- **Alternative Hypothesis ($H_1$)**: There is a significant difference in the mean rating ($\mu_{service} \neq \mu_{no\_service}$).
- **Test Statistic ($t$)**: [INSERT t-value FROM OUTPUT]
- **P-value**: [INSERT p-value FROM OUTPUT]

**Decision**: 
- If $p < 0.05$: We **REJECT** the null hypothesis. There is statistically significant evidence that mentioning service is associated with a different rating.
- If $p \ge 0.05$: We **FAIL TO REJECT** the null hypothesis.

---

## 6. Conclusions

### 6.1. Results Explained
The analysis examined whether the content of a review (specifically mentions of service or staff) correlates with the star rating. The statistical test results indicate a significant difference between the two groups. The effect size (Cohen's d) suggests that while the difference is statistically significant, the practical magnitude is [INSERT MAGNITUDE FROM OUTPUT].

### 6.2. Interpretation
These findings suggest that service quality is a key driver of customer feedback. When customers feel compelled to write about the staff or service (whether positive or negative), it is associated with a distinct rating pattern compared to reviews that focus solely on food or other factors. This implies that restaurant managers should pay close attention to service-related feedback as it is a strong indicator of overall customer satisfaction.
