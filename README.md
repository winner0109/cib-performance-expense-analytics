# CIB Performance & Expense Analytics

*A synthetic CIB management-reporting solution for revenue performance, client and product economics, expense recovery, and data-quality risk.*

**Power BI · DAX · Power Query · SQL · Excel**  
**Reporting period:** FY2025 · **Currency:** CAD

> **Synthetic-data disclosure**  
> All clients, bankers, projects, vendors, issues, transactions, and financial results are fictional. This project contains no TD Bank, TD Securities, or other employer data.

## At a Glance

**Business question**

How can CIB management identify revenue underperformance, client and product concentration, expense-recovery leakage, and reporting-control risk from one consolidated view?

**Scope**

| Item | Value |
|---|---:|
| Reporting period | January-December 2025 |
| Clients | 24 |
| Products | 5 |
| Regions | 4 |
| Bankers | 12 |
| Performance rows | 1,440 |
| Expense-recovery records | 540 |
| Data-quality issues | 120 |

## FY2025 Headline

Revenue reached **$197.7M**, finishing **$9.4M, or 4.5%, below plan**. Net contribution was **$165.5M**, expense recovery was **84.8%**, and **$2.6M** of recoverable expense remained outstanding.

## Key Findings

- **Equity Capital Markets** generated the largest negative product variance at approximately **$10.6M below plan**.
- **Debt Capital Markets** exceeded plan by approximately **$4.1M**, partially offsetting ECM and Corporate Lending weakness.
- The five largest clients generated **29.3%** of total revenue.
- **163** recovery records were delayed, with an average delay of **57.4 days**.
- **49 of 120** DQ issues remained open or in remediation, including **four critical issues** and **$578.4K** of unresolved financial differences.

## Dashboard Walkthrough

### 1. Executive Overview

**What it answers:** Are revenue, expense, contribution, and recovery meeting management expectations?

**Key insight:** Revenue was 4.5% below plan, with ECM producing the largest negative product variance.

**Management action:** Review pipeline conversion, execution timing, and fee realization in underperforming products.

![Executive Overview](screenshots/01_executive_overview.png)

### 2. Client & Product Economics

**What it answers:** Where are revenue, contribution, and capital concentrated?

**Key insight:** Top-five client concentration was 29.3%, while Pacific Hospitality recorded the largest client-level shortfall at approximately $1.5M.

**Management action:** Review client-product segments that combine negative variance with high capital usage.

![Client & Product Economics](screenshots/02_client_product_economics.png)

### 3. Expense Recovery

**What it answers:** Which recoverable expenses are delayed, outstanding, or concentrated?

**Key insight:** Recovery was 84.8%, leaving $2.6M outstanding; Northstar Energy had the largest client-level balance at approximately $300.7K.

**Management action:** Introduce aging- and materiality-based escalation thresholds.

![Expense Recovery](screenshots/03_expense_recovery.png)

### 4. Data Quality

**What it answers:** Which issues create the greatest reporting, reconciliation, and control risk?

**Key insight:** 49 issues remained unresolved, including four critical items and $578.4K of financial differences.

**Management action:** Establish owner-level remediation tracking, due dates, and escalation rules.
![Data Quality](screenshots/04_data_quality.png)

## Analytical Approach

1. Generated a fully synthetic management-reporting dataset.
2. Structured the model around three fact tables and four conformed dimensions.
3. Cleaned and typed data in Power Query.
4. Created DAX measures for revenue, variance, contribution, concentration, recovery, and DQ remediation.
5. Built four management-oriented report pages.
6. Validated headline measures against an independent summary table.
7. Reproduced core investigations in SQL using CSV exports.

## Data Model

- `Fact_Performance`
- `Fact_Expense_Recovery`
- `Fact_DQ_Log`
- `Dim_Date`
- `Dim_Client`
- `Dim_Product`
- `Dim_Banker`

<img width="1453" height="942" alt="05_Model" src="https://github.com/user-attachments/assets/25b53b5d-0ff9-43db-8994-c7690927819f" />


## Recommendations

1. Investigate the ECM shortfall by client, pipeline stage, execution timing, and fee realization.
2. Apply aging and materiality thresholds to expense-recovery escalation.
3. Review capital usage together with revenue, contribution, risk, and strategic relationship value.
4. Introduce weekly tracking for critical and high-severity DQ issues.
5. Reconcile material source-system differences before management-report publication.

## Limitations

- The dataset is fully synthetic.
- Net contribution is not full economic profit.
- Capital usage is simplified and does not represent regulatory or risk-adjusted capital.
- The DQ table is an issue log rather than a complete tested population.
- Recovery aging uses a static reporting as-of date.

## Project Links

- **GitHub repository:** add your public GitHub URL
- **Power BI file:** link to `powerbi/CIB_Performance_Expense_Analytics_FY2025.pbix`
- **Dashboard PDF:** link to `docs/CIB_Performance_Expense_Analytics_FY2025.pdf`

See the [data dictionary](docs/data_dictionary.md).

## Analytical Method

1. Generated fully synthetic FY2025 client, product, banker, expense-recovery, and DQ records.
2. Cleaned and typed the source data in Power Query.
3. Built a star-schema model with shared dimensions.
4. Created reusable DAX measures for performance, concentration, recovery, and controls.
5. Designed four report pages around distinct management questions.
6. Validated headline results against an independent summary table.
7. Reproduced core investigations in DuckDB-compatible SQL.

## Technical Evidence

- [DAX measure library](dax/measures.md)
- [SQL setup and instructions](sql/README.md)
- [Revenue variance analysis](sql/01_revenue_variance.sql)
- [Client and product economics](sql/02_client_product_economics.sql)
- [Expense-recovery analysis](sql/03_expense_recovery.sql)
- [Data-quality analysis](sql/04_data_quality.sql)
- [CSV data tables](data/csv/)
- [Executive memo](docs/executive_memo.md)

## Recommendations

1. Investigate ECM pipeline conversion, execution timing, and fee realization.
2. Prioritize material and aged unrecovered expenses through owner-level escalation.
3. Review capital usage together with revenue, contribution, risk, and relationship value.
4. Establish weekly remediation tracking for critical and high-severity DQ issues.
5. Reconcile material source-system differences before management reporting publication.

## Repository Structure

```text
.
├── README.md
├── powerbi/
│   └── CIB_Performance_Expense_Analytics_FY2025.pbix
├── data/
│   ├── CIB_Performance_Expense_Analytics_Synthetic_Data.xlsx
│   ├── README.md
│   └── csv/
├── screenshots/
│   ├── 01_executive_overview.png
│   ├── 02_client_product_economics.png
│   ├── 03_expense_recovery.png
│   └── 04_data_quality.png
├── dax/
│   └── measures.md
├── sql/
│   ├── 00_setup_duckdb.sql
│   ├── 01_revenue_variance.sql
│   ├── 02_client_product_economics.sql
│   ├── 03_expense_recovery.sql
│   ├── 04_data_quality.sql
│   └── README.md
└── docs/
    ├── CIB_Performance_Expense_Analytics_FY2025.pdf
    ├── data_dictionary.md
    ├── executive_memo.md
    └── portfolio_case_study.md
```

## Reproduce the Analysis

### Power BI

1. Download the source workbook from `data/`.
2. Open the `.pbix` file under `powerbi/`.
3. If prompted, update the data-source path to the downloaded workbook.
4. Refresh the report.

### SQL

Install DuckDB, then run from the repository root:

```bash
duckdb cib_analytics.duckdb < sql/00_setup_duckdb.sql
duckdb cib_analytics.duckdb < sql/01_revenue_variance.sql
```

Run the remaining SQL files in the same way.

## Limitations

- Net contribution excludes compensation, funding costs, tax, expected loss, and other full-economic costs.
- Average capital is a simplified monthly average and is not RAROC or regulatory capital.
- The DQ table is an issue log, not a complete tested population; a pass rate cannot be inferred.
- Expense-recovery aging uses a static reporting as-of date.
- Results are fictional and should not be interpreted as actual bank performance or investment advice.
