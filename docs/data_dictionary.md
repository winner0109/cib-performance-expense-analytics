# Data Dictionary

## Model Overview

| Table | Grain | Purpose |
|---|---|---|
| `Fact_Performance` | One row per month, client, and product | Revenue, plan, expense, capital, and transaction performance |
| `Fact_Expense_Recovery` | One row per recoverable expense | Expense aging, recovery status, project, and vendor leakage |
| `Fact_DQ_Log` | One row per data-quality issue | Reconciliation, definition, ownership, severity, and remediation |
| `Dim_Date` | One row per reporting month | Time filtering and month sorting |
| `Dim_Client` | One row per client | Client, sector, tier, and home-region attributes |
| `Dim_Product` | One row per product | Product and product-group attributes |
| `Dim_Banker` | One row per banker | Banker, region, and seniority attributes |

## Fact_Performance

| Column | Type | Definition |
|---|---|---|
| `Month_Start` | Date | First day of the reporting month |
| `Client_ID` | Text | Synthetic client key |
| `Client` | Text | Synthetic client name |
| `Product_ID` | Text | Synthetic product key |
| `Product` | Text | CIB product or service |
| `Region` | Text | Primary client coverage region |
| `Banker_ID` | Text | Synthetic banker key |
| `Banker` | Text | Synthetic relationship banker |
| `Revenue_CAD` | Integer | Actual recognized monthly revenue |
| `Planned_Revenue_CAD` | Integer | Monthly management revenue plan |
| `Direct_Expense_CAD` | Integer | Direct expense attributable to the activity |
| `Allocated_Expense_CAD` | Integer | Shared expense allocated to the activity |
| `Recovered_Expense_CAD` | Integer | Direct expense recovered from the client |
| `Capital_CAD` | Integer | Synthetic capital allocated to support the activity |
| `Transaction_Count` | Integer | Number of transactions in the month |

## Fact_Expense_Recovery

| Column | Type | Definition |
|---|---|---|
| `Expense_ID` | Text | Unique synthetic expense record |
| `Expense_Date` | Date | Date the expense was incurred |
| `Recovery_Due_Date` | Date | Expected recovery deadline |
| `Recovery_Date` | Date | Date recovery was recorded; blank if outstanding |
| `Client_ID` / `Client` | Text | Associated synthetic client |
| `Project_ID` / `Project` | Text | Associated synthetic project |
| `Product_ID` / `Product` | Text | Associated CIB product |
| `Vendor` | Text | Synthetic external vendor |
| `Expense_Type` | Text | Expense classification |
| `Incurred_Expense_CAD` | Integer | Gross expense incurred |
| `Recoverable_Expense_CAD` | Integer | Portion eligible for recovery |
| `Recovered_Expense_CAD` | Integer | Amount recovered as of the reporting date |
| `Unrecovered_Expense_CAD` | Integer | Recoverable amount still outstanding |
| `Recovery_Status` | Text | Recovered, partially recovered, delayed, or unrecovered |
| `Days_Delayed` | Integer | Days recovered after due date or overdue at the as-of date |

## Fact_DQ_Log

| Column | Type | Definition |
|---|---|---|
| `Issue_ID` | Text | Unique synthetic issue identifier |
| `Detected_Date` | Date | Date the issue was detected |
| `Source_System` | Text | System where the issue originated or was observed |
| `Record_ID` | Text | Affected record identifier |
| `Client_ID` / `Client` | Text | Associated synthetic client |
| `Issue_Type` | Text | Missing definition, duplicate, reconciliation, mapping, ownership, or source difference |
| `Issue_Description` | Text | Standardized description |
| `Difference_Amount_CAD` | Integer | Financial difference associated with the issue |
| `Severity` | Text | Critical, High, Medium, or Low |
| `Status` | Text | Open, In Remediation, or Resolved |
| `Owner` | Text | Accountable remediation team |
| `Resolved_Date` | Date | Resolution date; blank if outstanding |

## Key Metric Definitions

| Metric | Definition |
|---|---|
| Total Expense | Direct Expense + Allocated Expense |
| Net Contribution | Revenue - Total Expense |
| Variance to Plan | Revenue - Planned Revenue |
| Net Contribution Margin | Net Contribution / Revenue |
| Top 5 Client Concentration | Revenue from the five largest clients / Total Revenue |
| Expense Recovery Rate | Recovered Expense / Recoverable Expense |
| Unrecovered Expense | Recoverable Expense - Recovered Expense |
| DQ Resolution Rate | Resolved DQ Issues / Total DQ Issues |
| Outstanding DQ Difference | Difference amounts associated with unresolved issues |
