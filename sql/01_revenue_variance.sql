-- 1A. Monthly actual revenue versus plan

SELECT
    Month_Start,
    SUM(Revenue_CAD) AS Total_Revenue_CAD,
    SUM(Planned_Revenue_CAD) AS Planned_Revenue_CAD,
    SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD) AS Variance_CAD,
    ROUND(
        100.0 * (
            SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD)
        ) / NULLIF(SUM(Planned_Revenue_CAD), 0),
        1
    ) AS Variance_Pct
FROM fact_performance
GROUP BY Month_Start
ORDER BY Month_Start;


-- 1B. Product contribution to the FY2025 revenue variance

SELECT
    Product,
    SUM(Revenue_CAD) AS Total_Revenue_CAD,
    SUM(Planned_Revenue_CAD) AS Planned_Revenue_CAD,
    SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD) AS Variance_CAD,
    ROUND(
        100.0 * (
            SUM(Revenue_CAD) - SUM(Planned_Revenue_CAD)
        ) / NULLIF(SUM(Planned_Revenue_CAD), 0),
        1
    ) AS Variance_Pct
FROM fact_performance
GROUP BY Product
ORDER BY Variance_CAD;
