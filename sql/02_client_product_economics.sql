-- 2A. Client economics and concentration

WITH client_economics AS (
    SELECT
        Client,
        SUM(Revenue_CAD) AS Revenue_CAD,
        SUM(Direct_Expense_CAD + Allocated_Expense_CAD) AS Expense_CAD,
        SUM(
            Revenue_CAD
            - Direct_Expense_CAD
            - Allocated_Expense_CAD
        ) AS Net_Contribution_CAD,
        SUM(Planned_Revenue_CAD) AS Planned_Revenue_CAD
    FROM fact_performance
    GROUP BY Client
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY Revenue_CAD DESC) AS Revenue_Rank,
        SUM(Revenue_CAD) OVER () AS Total_Portfolio_Revenue_CAD
    FROM client_economics
)
SELECT
    Client,
    Revenue_CAD,
    Expense_CAD,
    Net_Contribution_CAD,
    ROUND(
        100.0 * Net_Contribution_CAD / NULLIF(Revenue_CAD, 0),
        1
    ) AS Net_Contribution_Margin_Pct,
    Revenue_CAD - Planned_Revenue_CAD AS Variance_to_Plan_CAD,
    Revenue_Rank,
    ROUND(
        100.0 * Revenue_CAD / NULLIF(Total_Portfolio_Revenue_CAD, 0),
        1
    ) AS Portfolio_Revenue_Share_Pct
FROM ranked
ORDER BY Revenue_CAD DESC;


-- 2B. Underperforming client-product segments

SELECT
    Client,
    Product,
    SUM(Revenue_CAD) AS Revenue_CAD,
    SUM(Planned_Revenue_CAD) AS Planned_Revenue_CAD,
    SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD) AS Variance_CAD,
    ROUND(
        100.0 * (
            SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD)
        ) / NULLIF(SUM(Planned_Revenue_CAD), 0),
        1
    ) AS Variance_Pct,
    SUM(
        Revenue_CAD
        - Direct_Expense_CAD
        - Allocated_Expense_CAD
    ) AS Net_Contribution_CAD
FROM fact_performance
GROUP BY Client, Product
HAVING SUM(Revenue_CAD) < SUM(Planned_Revenue_CAD)
ORDER BY Variance_CAD
LIMIT 25;


-- 2C. Product economics

SELECT
    Product,
    SUM(Revenue_CAD) AS Revenue_CAD,
    SUM(Direct_Expense_CAD + Allocated_Expense_CAD) AS Expense_CAD,
    SUM(
        Revenue_CAD
        - Direct_Expense_CAD
        - Allocated_Expense_CAD
    ) AS Net_Contribution_CAD,
    ROUND(
        100.0 * SUM(
            Revenue_CAD
            - Direct_Expense_CAD
            - Allocated_Expense_CAD
        ) / NULLIF(SUM(Revenue_CAD), 0),
        1
    ) AS Net_Contribution_Margin_Pct
FROM fact_performance
GROUP BY Product
ORDER BY Net_Contribution_CAD DESC;
