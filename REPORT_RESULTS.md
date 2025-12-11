# Report Content: Analysis & Visualisation Results

Use the following text and data to complete Sections 3, 4, and 6 of your final report.

## 3. Visualisation

### 3.1. Appropriate Plot
**Main Plot**: `rating_boxplot.png`
**Supplementary Plot**: `rating_distribution.png`

**Figure 1 Caption**: *Boxplot comparing the distribution of ratings between Text-Only and Photographic reviews. The diamond shape represents the mean rating. Photographic reviews show a higher median and mean rating compared to text-only reviews.*

**Figure 2 Caption**: *Density plot showing the frequency distribution of ratings. Text-only reviews have a higher density of lower ratings (1-3 stars) compared to photographic reviews, which are heavily skewed towards 5 stars.*

### 3.3. Useful Information for Data Understanding
- **Observation 1**: The boxplot clearly shows that the median rating for photographic reviews is higher (4 or 5) compared to text-only reviews.
- **Observation 2**: The spread (interquartile range) is similar, but the mean (diamond) for photographic reviews (3.86) is visibly higher than for text-only (3.54).
- **Observation 3**: The density plot reveals that users who upload photos are much more likely to give a perfect 5-star rating, whereas text-only reviews have a flatter distribution with more negative ratings.

---

## 4. Analysis

### 4.1. Statistical Test Used
**Test**: Welch's Two Sample t-test
**Reasoning**: We selected Welch's t-test because it compares the means of two independent groups (Photographic vs. Text-Only) and does not assume equal variance between the groups. Given the large difference in sample sizes (1,983 vs 7,978) and potential variance differences, this is the most robust choice.

### 4.2. Hypothesis Testing Results
- **Null Hypothesis ($H_0$)**: There is no difference in the mean rating between photographic and text-only reviews.
- **Alternative Hypothesis ($H_1$)**: There is a significant difference in the mean rating.
- **Test Statistic**: $t = 10.981$
- **Degrees of Freedom**: $4307.6$
- **P-value**: $< 2.2 \times 10^{-16}$ (extremely small, effectively zero)

**Decision**: Since the p-value ($< 2.2e-16$) is significantly less than the significance level ($\alpha = 0.05$), we **REJECT** the null hypothesis.

---

## 6. Conclusions

### 6.1. Results Explained
The analysis reveals a statistically significant difference in customer satisfaction based on review modality. Restaurants receiving reviews with photographs have a significantly higher mean rating (**3.86**) compared to those receiving text-only reviews (**3.54**). The 95% confidence interval suggests the true difference lies between 0.27 and 0.39 stars.

### 6.2. Interpretation
The results strongly support the alternative hypothesis ($H_1$). This implies that visual content in reviews is positively correlated with higher satisfaction scores. Customers who take the time to upload photos are likely having a more positive, "share-worthy" experience. Conversely, text-only reviews may capture more casual or negative dining experiences where the user does not feel compelled to visually document the meal.
