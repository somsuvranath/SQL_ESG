# Integrated ESG Analytics: A Data-Driven Framework for Sustainable Investment Decisions

> SQL-based ESG analytics framework for evaluating sustainability performance and financial
> metrics across global manufacturing, automotive, and energy sector companies (2015–2025),
> enabling data-driven Net Zero-aligned investment decisions.

---

## Project Overview

This project develops a structured SQL analytics framework that integrates ESG (Environmental,
Social, and Governance) scores with financial metrics across 20 global companies spanning the
**manufacturing, automotive, and energy industries** — sectors at the forefront of the circular
economy and Net Zero transition.

The analysis simulates the kind of data-driven decision-making used in **ESG assurance,
sustainability reporting, and responsible investment** — identifying top ESG performers,
laggards, and companies with the highest improvement trajectory over a 10-year period
(2015–2025).

---

## Business Context & ESG Themes

| ESG Theme | Relevance in This Project |
|---|---|
| **Net Zero transition** | Identifies companies with high ESG improvement trajectories (2015–2025), signalling Net Zero commitment |
| **Circular Economy** | Screens industries with the highest revenue but lowest ESG scores — key targets for circular economy engagement |
| **Carbon Footprint / GHG Risk** | High-growth, low-ESG companies flagged as Scope 1/2/3 emissions risks for portfolio managers |
| **Sustainable Investment** | Buy/hold/engage signals derived from ESG leader and laggard screening (top and bottom 10%) |
| **Regional ESG Benchmarking** | North America vs Europe ESG comparison — relevant for CSRD-ESRS and GRI Standards reporting alignment |
| **Industry Baseline Setting** | Industry-average ESG scores for 2024 — used for target-setting and materiality assessments |

---

## Dataset

**File:** `esgfinancialdata.csv`

| Column | Description |
|---|---|
| CompanyID | Unique company identifier |
| CompanyName | Company name |
| Industry | Sector (Manufacturing, Automotive, Energy, Technology, etc.) |
| Region | Geographic region (North America, Europe, Asia-Pacific) |
| Year | Year of data (2015–2025) |
| ESG_Overall | Composite ESG score (0–100) |
| MarketCap | Market capitalisation (USD millions) |
| Revenue | Annual revenue (USD millions) |
| ProfitMargin | Net profit margin (%) |
| GrowthRate | Year-on-year revenue growth rate (%) |

---

## 12 Key Analysis Queries

| # | Query | ESG / Investment Purpose |
|---|---|---|
| 1 | Above-average Market Cap & ESG (2025) | Identify companies balancing financial strength with sustainability |
| 2 | Top 5 companies by Revenue + ESG score | Revenue leaders with ESG performance context |
| 3 | Highest revenue, lowest ESG industry | Circular economy engagement targets — industries needing ESG uplift |
| 4 | High growth but low ESG companies | GHG / Scope 1/2/3 risk flags for responsible portfolio screening |
| 5 | ESG ranking within each industry | Competitive ESG positioning — useful for materiality assessments |
| 6 | Industry ESG baseline (2024) | Sector benchmarks for Net Zero target-setting and GRI reporting |
| 7 | ESG leaders — top 10% (2025) | Buy signals / sustainable investment portfolio inclusion |
| 8 | ESG laggards — bottom 10% (2025) | Sell signals / shareholder engagement opportunities |
| 9 | North America vs Europe ESG comparison | Regional benchmarking aligned with CSRD-ESRS and GRI Standards |
| 10 | ESG improvement 2015–2025 | Net Zero commitment tracking — companies with highest ESG trajectory |
| 11 | Companies with ESG score > 70 (2025) | ESG-focused investment screening threshold |
| 12 | Negative profit margin + high ESG (2024) | Value investing — sustainability leaders under financial pressure |

---

## SQL Techniques Demonstrated

- **Window functions:** `RANK()`, `ROW_NUMBER()`, `NTILE()` with `PARTITION BY` and `ORDER BY`
- **Common Table Expressions (CTEs):** Multi-step analysis with `WITH` clauses
- **Subqueries:** Dynamic benchmarking against dataset averages
- **Aggregate functions:** `AVG()`, `MAX()`, `MIN()`, `ROUND()` with `GROUP BY` and `HAVING`
- **Multi-table joins:** Year-on-year ESG improvement via self-join on CTEs
- **Conditional filtering:** `WHERE`, `HAVING` for ESG threshold screening

---

## Sample Queries

**ESG Leaders — Top 10% performers for sustainable portfolio inclusion:**
```sql
WITH cte AS (
    SELECT CompanyName, ESG_Overall,
    NTILE(10) OVER (ORDER BY ESG_Overall DESC) AS bucket
    FROM esgfinancialdata
    WHERE Year = 2025
)
SELECT * FROM cte WHERE bucket = 1;
```

**Net Zero Commitment — Companies with highest ESG improvement (2015–2025):**
```sql
WITH ESG_2015 AS (
    SELECT CompanyID, CompanyName, ESG_Overall AS ESG_2015
    FROM esgfinancialdata WHERE Year = 2015
),
ESG_2025 AS (
    SELECT CompanyID, CompanyName, ESG_Overall AS ESG_2025
    FROM esgfinancialdata WHERE Year = 2025
)
SELECT e2015.CompanyName,
       ROUND(e2025.ESG_2025 - e2015.ESG_2015, 2) AS ESG_Improvement,
       e2015.ESG_2015, e2025.ESG_2025
FROM ESG_2015 e2015
JOIN ESG_2025 e2025 ON e2015.CompanyID = e2025.CompanyID
ORDER BY ESG_Improvement DESC;
```

**Circular Economy Targets — Industry with highest revenue but lowest ESG score:**
```sql
SELECT Industry,
       ROUND(AVG(Revenue), 2) AS avg_revenue,
       ROUND(AVG(ESG_Overall), 2) AS avg_ESG
FROM esgfinancialdata
GROUP BY Industry
ORDER BY avg_revenue DESC, avg_ESG ASC
LIMIT 1;
```

---

## Key Findings

- **ESG leaders in 2025** are concentrated in Technology and Healthcare; Manufacturing and
  Automotive lag behind — reinforcing the need for circular economy and Net Zero interventions
  in industrial sectors
- **High-growth, low-ESG companies** present the most significant Scope 1/2/3 GHG risk —
  flagged as engagement opportunities where ESG improvement potential is highest
- **Europe outperforms North America** on average ESG scores in 2025, consistent with
  CSRD-ESRS regulatory pressure driving stronger sustainability disclosures
- **10-year ESG trajectory (2015–2025)** shows companies with consistent ESG improvement
  correlate with stronger long-term revenue growth, supporting the business case for
  sustainable investment

---

## Relevance to Sustainability Roles

This project directly mirrors analytical workflows used in:
- ESG assurance and reporting (GRI Standards, CSRD-ESRS compliance)
- Sustainability consulting for manufacturing and industrial sector clients
- Responsible investment and ESG portfolio construction
- Net Zero strategy — identifying improvement leaders and engagement targets

---

## Tools & Environment

- SQL (MySQL)
- Dataset: `esgfinancialdata.csv` (included in repository)

---

## Author

**Somsuvra Nath**
ESG & Sustainability Professional | MBA Energy Management | B.Tech Electrical Engineering
LinkedIn: linkedin.com/in/somsuvranath | Kolkata, India
