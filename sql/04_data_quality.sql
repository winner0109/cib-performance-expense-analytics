-- 4A. Data-quality headline

SELECT
    COUNT(DISTINCT Issue_ID) AS Total_DQ_Issues,
    COUNT(DISTINCT CASE WHEN Status <> 'Resolved' THEN Issue_ID END)
        AS Open_or_In_Remediation_Issues,
    COUNT(DISTINCT CASE
        WHEN Status <> 'Resolved' AND Severity = 'Critical'
        THEN Issue_ID
    END) AS Open_Critical_Issues,
    SUM(CASE
        WHEN Status <> 'Resolved' THEN Difference_Amount_CAD
        ELSE 0
    END) AS Outstanding_Difference_CAD,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN Status = 'Resolved' THEN Issue_ID
        END) / NULLIF(COUNT(DISTINCT Issue_ID), 0),
        1
    ) AS Resolution_Rate_Pct,
    ROUND(AVG(CASE
        WHEN Resolved_Date IS NOT NULL
        THEN date_diff('day', Detected_Date, Resolved_Date)
    END), 1) AS Average_Resolution_Days
FROM fact_dq_log;


-- 4B. Issue mix

SELECT
    Issue_Type,
    COUNT(DISTINCT Issue_ID) AS Issue_Count,
    SUM(CASE
        WHEN Status <> 'Resolved' THEN Difference_Amount_CAD
        ELSE 0
    END) AS Outstanding_Difference_CAD
FROM fact_dq_log
GROUP BY Issue_Type
ORDER BY Issue_Count DESC, Outstanding_Difference_CAD DESC;


-- 4C. Open issues by source system and owner

SELECT
    Source_System,
    Owner,
    COUNT(DISTINCT Issue_ID) AS Open_Issue_Count,
    SUM(Difference_Amount_CAD) AS Outstanding_Difference_CAD
FROM fact_dq_log
WHERE Status <> 'Resolved'
GROUP BY Source_System, Owner
ORDER BY Open_Issue_Count DESC, Outstanding_Difference_CAD DESC;


-- 4D. Critical and high-severity remediation queue

SELECT
    Issue_ID,
    Detected_Date,
    Client,
    Source_System,
    Issue_Type,
    Severity,
    Status,
    Difference_Amount_CAD,
    Owner
FROM fact_dq_log
WHERE
    Status <> 'Resolved'
    AND Severity IN ('Critical', 'High')
ORDER BY
    CASE Severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        ELSE 3
    END,
    Difference_Amount_CAD DESC,
    Detected_Date;
