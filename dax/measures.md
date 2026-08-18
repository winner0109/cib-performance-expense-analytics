# DAX Measures

The measures below are grouped by the dashboard page where they are primarily used.

## 1. Executive Overview

### Total Revenue

```DAX
Total Revenue =
SUM('Fact_Performance'[Revenue_CAD])
```

### Planned Revenue

```DAX
Planned Revenue =
SUM('Fact_Performance'[Planned_Revenue_CAD])
```

### Total Expense

```DAX
Total Expense =
SUM('Fact_Performance'[Direct_Expense_CAD])
    + SUM('Fact_Performance'[Allocated_Expense_CAD])
```

### Net Contribution

```DAX
Net Contribution =
[Total Revenue] - [Total Expense]
```

### Variance to Plan

```DAX
Variance to Plan =
[Total Revenue] - [Planned Revenue]
```

### Variance %

```DAX
Variance % =
DIVIDE(
    [Variance to Plan],
    [Planned Revenue],
    0
)
```

### Total Transactions

```DAX
Total Transactions =
SUM('Fact_Performance'[Transaction_Count])
```

## 2. Client & Product Economics

### Direct Expense

```DAX
Direct Expense =
SUM('Fact_Performance'[Direct_Expense_CAD])
```

### Allocated Expense

```DAX
Allocated Expense =
SUM('Fact_Performance'[Allocated_Expense_CAD])
```

### Net Contribution Margin

```DAX
Net Contribution Margin =
DIVIDE(
    [Net Contribution],
    [Total Revenue],
    0
)
```

### Average Capital

```DAX
Average Capital =
AVERAGEX(
    VALUES('Dim_Date'[Month_Start]),
    CALCULATE(
        SUM('Fact_Performance'[Capital_CAD])
    )
)
```

### Revenue / Average Capital

```DAX
Revenue to Average Capital =
DIVIDE(
    [Total Revenue],
    [Average Capital],
    0
)
```

### Top 5 Client Revenue

```DAX
Top 5 Client Revenue =
VAR TopClients =
    TOPN(
        5,
        ALLSELECTED('Dim_Client'[Client]),
        [Total Revenue],
        DESC
    )
RETURN
    SUMX(
        TopClients,
        CALCULATE([Total Revenue])
    )
```

### Top 5 Client Concentration

```DAX
Top 5 Client Concentration =
DIVIDE(
    [Top 5 Client Revenue],
    CALCULATE(
        [Total Revenue],
        ALLSELECTED('Dim_Client'[Client])
    ),
    0
)
```

## 3. Expense Recovery

### Incurred Expense

```DAX
Incurred Expense =
SUM('Fact_Expense_Recovery'[Incurred_Expense_CAD])
```

### Recoverable Expense

```DAX
Recoverable Expense =
SUM('Fact_Expense_Recovery'[Recoverable_Expense_CAD])
```

### Recovered Expense

```DAX
Recovered Expense =
SUM('Fact_Expense_Recovery'[Recovered_Expense_CAD])
```

### Unrecovered Expense

```DAX
Unrecovered Expense =
SUM('Fact_Expense_Recovery'[Unrecovered_Expense_CAD])
```

### Expense Recovery Rate

```DAX
Expense Recovery Rate =
DIVIDE(
    [Recovered Expense],
    [Recoverable Expense],
    0
)
```

### Delayed Case Count

```DAX
Delayed Case Count =
CALCULATE(
    DISTINCTCOUNT('Fact_Expense_Recovery'[Expense_ID]),
    'Fact_Expense_Recovery'[Days_Delayed] > 0
)
```

### Average Days Delayed

```DAX
Average Days Delayed =
AVERAGEX(
    FILTER(
        'Fact_Expense_Recovery',
        'Fact_Expense_Recovery'[Days_Delayed] > 0
    ),
    'Fact_Expense_Recovery'[Days_Delayed]
)
```

### Overdue Unrecovered Expense

```DAX
Overdue Unrecovered Expense =
CALCULATE(
    [Unrecovered Expense],
    'Fact_Expense_Recovery'[Days_Delayed] > 0
)
```

## 4. Data Quality

### Total DQ Issues

```DAX
Total DQ Issues =
DISTINCTCOUNT('Fact_DQ_Log'[Issue_ID])
```

### Open DQ Issues

```DAX
Open DQ Issues =
CALCULATE(
    [Total DQ Issues],
    'Fact_DQ_Log'[Status] <> "Resolved"
)
```

### Resolved DQ Issues

```DAX
Resolved DQ Issues =
CALCULATE(
    [Total DQ Issues],
    'Fact_DQ_Log'[Status] = "Resolved"
)
```

### DQ Resolution Rate

```DAX
DQ Resolution Rate =
DIVIDE(
    [Resolved DQ Issues],
    [Total DQ Issues],
    0
)
```

### Open Critical DQ Issues

```DAX
Open Critical DQ Issues =
CALCULATE(
    [Total DQ Issues],
    'Fact_DQ_Log'[Status] <> "Resolved",
    'Fact_DQ_Log'[Severity] = "Critical"
)
```

### Outstanding DQ Difference

```DAX
Outstanding DQ Difference =
CALCULATE(
    SUM('Fact_DQ_Log'[Difference_Amount_CAD]),
    'Fact_DQ_Log'[Status] <> "Resolved"
)
```

### Average DQ Resolution Days

```DAX
Average DQ Resolution Days =
AVERAGEX(
    FILTER(
        'Fact_DQ_Log',
        NOT ISBLANK('Fact_DQ_Log'[Resolved_Date])
    ),
    DATEDIFF(
        'Fact_DQ_Log'[Detected_Date],
        'Fact_DQ_Log'[Resolved_Date],
        DAY
    )
)
```
