-- 3A. FY2025 expense-recovery headline

SELECT
    SUM(Incurred_Expense_CAD) AS Incurred_Expense_CAD,
    SUM(Recoverable_Expense_CAD) AS Recoverable_Expense_CAD,
    SUM(Recovered_Expense_CAD) AS Recovered_Expense_CAD,
    SUM(Unrecovered_Expense_CAD) AS Unrecovered_Expense_CAD,
    ROUND(
        100.0 * SUM(Recovered_Expense_CAD)
        / NULLIF(SUM(Recoverable_Expense_CAD), 0),
        1
    ) AS Recovery_Rate_Pct,
    COUNT(DISTINCT CASE WHEN Days_Delayed > 0 THEN Expense_ID END)
        AS Delayed_Case_Count,
    ROUND(AVG(CASE WHEN Days_Delayed > 0 THEN Days_Delayed END), 1)
        AS Average_Days_Delayed
FROM fact_expense_recovery;


-- 3B. Clients with the largest unrecovered balances

SELECT
    Client,
    SUM(Unrecovered_Expense_CAD) AS Unrecovered_Expense_CAD,
    COUNT(DISTINCT Expense_ID) AS Expense_Record_Count,
    ROUND(AVG(CASE WHEN Days_Delayed > 0 THEN Days_Delayed END), 1)
        AS Average_Days_Delayed
FROM fact_expense_recovery
GROUP BY Client
HAVING SUM(Unrecovered_Expense_CAD) > 0
ORDER BY Unrecovered_Expense_CAD DESC
LIMIT 10;


-- 3C. Vendors with the largest unrecovered balances

SELECT
    Vendor,
    SUM(Unrecovered_Expense_CAD) AS Unrecovered_Expense_CAD,
    COUNT(DISTINCT Expense_ID) AS Expense_Record_Count
FROM fact_expense_recovery
GROUP BY Vendor
HAVING SUM(Unrecovered_Expense_CAD) > 0
ORDER BY Unrecovered_Expense_CAD DESC
LIMIT 10;


-- 3D. Outstanding recovery detail

SELECT
    Expense_ID,
    Client,
    Project,
    Product,
    Vendor,
    Recovery_Due_Date,
    Recovery_Status,
    Days_Delayed,
    Unrecovered_Expense_CAD
FROM fact_expense_recovery
WHERE Unrecovered_Expense_CAD > 0
ORDER BY
    Unrecovered_Expense_CAD DESC,
    Days_Delayed DESC;
