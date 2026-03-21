# ESG Financial Data Analysis

## 📊 Project Overview
SQL-based analysis of ESG scores and financial metrics across companies (2015-2025) to identify investment opportunities and sustainability trends.

## 🎯 Key Skills Demonstrated
- **Advanced SQL**: Window functions, CTEs, subqueries, ranking, percentile analysis
- **Financial Analysis**: Market cap, revenue, profit margins, growth rates
- **Business Intelligence**: ESG scoring, portfolio construction, risk assessment

## 🔍 12 Key Analysis Queries

| # | Analysis | Business Value |
|---|----------|----------------|
| 1 | Above-average Market Cap & ESG | Identify top performers balancing profit & sustainability |
| 2 | Top 5 by Revenue + ESG | Revenue leaders with ESG context |
| 3 | High Revenue vs Low ESG Industry | Find industries needing ESG improvement |
| 4 | High Growth but Low ESG | Risk identification in high-growth companies |
| 5 | Industry ESG Rankings | Competitive positioning within sectors |
| 6 | Industry ESG Baseline (2024) | Benchmark for target setting |
| 7 | ESG Leaders (Top 10%) | Buy signals / portfolio inclusion |
| 8 | ESG Laggards (Bottom 10%) | Sell signals / engagement opportunities |
| 9 | North America vs Europe ESG | Regional performance comparison |
| 10 | ESG Improvement (2015-2025) | Track sustainability commitment over time |
| 11 | ESG > 70 Companies | ESG-focused investment screen |
| 12 | Negative Profit + High ESG | Value investing opportunities |

## 💡 Sample Query (ESG Leaders)
```sql
with cte as(
    select CompanyName, ESG_Overall,
    ntile(10) over (order by ESG_Overall desc) as bucket
    from esgfinancialdata
    where Year = 2025
)
select * from cte where bucket = 1;  -- Top 10% ESG performers
