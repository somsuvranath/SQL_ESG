create database esg_db;
use esg_db;
select * from esgfinancialdata;

-- 1) Which companies have both above-average Market Cap and above-average ESG scores in 2025?
select CompanyName, ROUND(AVG(MarketCap), 2) as avg_market_cap, ROUND(AVG(ESG_Overall), 2) as avg_esg_score
from esgfinancialdata
where Year = 2025
group by CompanyName
having AVG(MarketCap) > (Select AVG(MarketCap) from esgfinancialdata where Year = 2025)
    and AVG(ESG_Overall) > (Select AVG(ESG_Overall) from esgfinancialdata where Year = 2025);

-- 2) Find the top 5 companies by Revenue in 2025 and their corresponding ESG scores.
with cte as(select CompanyName, Revenue, ESG_Overall,
rank() over (order by Revenue desc) as rnk
from esgfinancialdata
where Year = 2025)

select *
from cte
where rnk <= 5;

-- 3) Find the industry with the highest average Revenue but lowest average ESG score.
select Industry, avg(Revenue) as av_revenue, avg(ESG_Overall) as av_ESG
from esgfinancialdata
group by Industry
order by av_revenue desc, av_ESG asc
limit 1;

-- 4) Which companies have high GrowthRate but low ESG scores in 2025?
select CompanyName, avg(GrowthRate) as av_growth, avg(ESG_Overall) as av_ESG
from esgfinancialdata
where Year = 2025
group by CompanyName
having avg(GrowthRate) > (select avg(GrowthRate) from esgfinancialdata where Year = 2025) and 
avg(ESG_Overall) < (select avg(ESG_Overall) from esgfinancialdata where Year = 2025)
order by av_growth desc, av_ESG asc;

-- 5)Rank companies within each industry by ESG score in 2025.
with cte as(select CompanyName, Industry, ESG_Overall,
row_number() over (partition by Industry order by ESG_Overall desc) rnk_ESGscore
from esgfinancialdata
where Year = 2025)

select *
from cte
order by Industry, rnk_ESGscore;

-- 6) What is the average ESG score by industry in 2024? (Industry baseline - useful for target setting)
select Industry, avg(ESG_Overall) as av_esg
from esgfinancialdata
where Year = 2024
group by Industry;

-- 7) Identify ESG leaders (top 10%) in 2025.(Portfolio construction - buy/sell signals)
with cte as(select CompanyName, ESG_Overall,
ntile(10) over (order by ESG_Overall desc) as bucket
from esgfinancialdata
where Year = 2025)

select *
from cte
where bucket = 1;

-- 8) Identify ESG laggards (bottom 10%) in 2025.(Portfolio construction - buy/sell signals)
with cte as(select CompanyName, ESG_Overall,
ntile(10) over (order by ESG_Overall) as bucket
from esgfinancialdata
where Year = 2025)

select *
from cte
where bucket = 1;

-- 9)Compare the ESG score between North America and Europe in 2025.
select Region, avg(ESG_Overall) as av_ESG , max(ESG_Overall) as max_ESG, min(ESG_Overall) as min_ESG, Year
from esgfinancialdata
where Region in ('North America','Europe') and Year = 2025
group by Region;

-- 10)Which companies improved their ESG score the most from 2015 to 2025?
with ESG_2015 as(select CompanyID, CompanyName, ESG_Overall as ESG_2015
from esgfinancialdata
where Year = 2015),
ESG_2025 as(select  CompanyID,CompanyName, ESG_Overall as ESG_2025
from esgfinancialdata
where Year = 2025)
select e2015.CompanyID, e2015.CompanyName, round(e2025.ESG_2025 - e2015.ESG_2015, 2) as ESG_improvement
from ESG_2015 e2015 join ESG_2025 e2025 on e2015.CompanyID = e2025.CompanyID
order by ESG_improvement desc;

-- 11)List companies with ESG scores above 70 in 2025, along with their industry.
select CompanyName, Industry, ESG_Overall, Year
from esgfinancialdata
where ESG_Overall > 70 and Year = 2025;

-- 12) List companies with negative Profit Margin but high ESG scores in 2024.
select CompanyName, ProfitMargin, ESG_Overall, Year
from esgfinancialdata
where ProfitMargin < 0 and Year = 2024
order by ESG_Overall desc;

